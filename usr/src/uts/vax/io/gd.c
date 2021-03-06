/* @(#)gd.c	6.1 */
/*
 * General Disk Driver
 */

#include "sys/param.h"
#include "sys/types.h"
#include "sys/sysmacros.h"
#include "sys/dir.h"
#include "sys/signal.h"
#include "sys/user.h"
#include "sys/errno.h"
#include "sys/buf.h"
#include "sys/elog.h"
#include "sys/iobuf.h"
#include "sys/systm.h"
#include "sys/mba.h"
#include "sys/gdisk.h"

static int gdelog[] = {HP0, HP1, HP2, HP3};

gdopen(dev)
{
	register struct iobuf *dp;
	register struct device *rp;
	register pos;
	register i;
	int	drive, ctl, dt;

	ctl = gdctl(dev);
	if (ctl >= gd_cnt) {
		u.u_error = ENXIO;
		return;
	}
	if ((gdtab[ctl].b_flags&B_ONCE)==0) {
		gdtab[ctl].b_flags |= B_ONCE;
		gdtimer(ctl);
	}
	drive = gddrive(dev);
	pos = gdpos(dev);
	dp = &gdutab[pos];
	rp = (struct device *)&(gd_addr[ctl]->ereg[drive]);
	dp->io_addr = (physadr)rp;
	dp->io_mba = (physadr)gd_addr[ctl];
	dp->io_nreg = NDEVREG;
	dp->io_stp = &gdstat[pos].ios;
	if (gdtype[pos])
		return;
	spl5();
	if (!(rp->ds & MOL)) {
		rp->cs1 = 0;	/* seize if dual port */
		dp->wtime = WMOL;
		sleep((caddr_t)dp, GDPRI);
	}
	dt = rp->dt & DTYPE;
	spl0();
	if (gdtype[pos])
		return;
	for (i = 0; gdsw[i].type != 0; i++)
		if (dt == gdsw[i].type) {
			gdtype[pos] = gdsw[i].type;
			gdindex[pos] = i;
			dp->b_dev = makedev(gdelog[ctl], gdstod(drive));
			(*gdsw[i].open)(dev);
			break;
		}
	if (!gdtype[pos]) {
		u.u_error = ENODEV;
		printf("Drive %o, ctl %o, type %o unknown.\n",
			drive, ctl, dt);
	}
}

gdclose()
{
}

gdstrategy(bp)
register struct buf *bp;
{
	register pos;
	daddr_t	last;

	pos = gdpos(bp->b_dev);
	last = gdloc(pos).sizep[gdslice(bp->b_dev)].nblocks;
	if (bp->b_blkno < 0 || bp->b_blkno >= last) {
		if (bp->b_blkno == last && bp->b_flags&B_READ)
			bp->b_resid = bp->b_bcount;
		else {
			bp->b_flags |= B_ERROR;
			bp->b_error = ENXIO;
		}
		iodone(bp);
		return;
	}
	bp->av_forw = NULL;
	bp->b_start = lbolt;
	gdstat[pos].io_cnt++;
	gdstat[pos].io_bcnt += btoc(bp->b_bcount);
	(*gdloc(pos).strategy)(bp);
}

gdstart(ctl)
{
	register struct buf *bp;
	register struct iobuf *dp;
	register struct device *rp;
	int	com;

    loop:
	if ((dp = (struct iobuf *)gdtab[ctl].b_actf) == NULL)
		return;
	if ((bp = dp->b_actf) == NULL) {
		gdtab[ctl].b_actf = dp->b_forw;
		goto loop;
	}
	rp = (struct device *)dp->io_addr;
	gdtab[ctl].b_active++;
	/* Every start routine must set cylin and trksec */
	rp->dc = bp->cylin;
	rp->da = (int)bp->trksec;
	blkacty |= (1<<major(dp->b_dev));
	mbasetup(bp, dp->io_mba);
	if (bp->b_flags & B_READ)
		com = RCOM | GO;
	else
		com = WCOM | GO;
	if (pwr_act >= 0)
		rp->cs1 = com;
}

gdintr(ctl)
{
	register struct device *rp;
	register struct mba *mp;
	register pos, drive;
	register as;

	mp = gd_addr[ctl];
	if (mp->mbacsr&0xffffff00)
		mbasrv(mp);
	if (gdtab[ctl].b_active) {	/* data transfer underway */
		register struct buf *bp;
		register struct iobuf *dp;

		dp = (struct iobuf *)gdtab[ctl].b_actf;
		blkacty &= ~(1<<major(dp->b_dev));
		bp = dp->b_actf;
		pos = gdpos(bp->b_dev);
		drive = gddrive(bp->b_dev);
		rp = (struct device *)dp->io_addr;
		as = rp->as&0377;
		if (mp->mbasr & MBADTABT) {
			if ((*gdloc(pos).intr)(pos, bp, dp, rp, mp))
				return;
		}
		if (gdtab[ctl].b_active) {
			if (dp->io_erec)
				logberr(dp, bp->b_flags&B_ERROR);
			gdtab[ctl].b_active = 0;
			dp->b_active = 0;
			dp->b_errcnt = 0;
			dp->b_actf = bp->av_forw;
			bp->b_resid = -(mp->mbabcr) & 0xffff;
			dp->qcnt--;
			if (bp == (struct buf *)dp->acts)
				dp->acts = (int)dp->b_actf;
			if (rp->dt & DRQ)
			if (dp->b_actf == NULL
			 || ((int)gdstat[pos].io_cnt&07) == 0) {
				rp->as = (1<<drive);
				rp->cs1 = RELEASE|GO;
			}
			gdstat[pos].io_resp += lbolt - bp->b_start;
			gdstat[pos].io_act += lbolt - dp->io_start;
			iodone(bp);
		}
		gdtab[ctl].b_actf = dp->b_forw;
		if (dp->b_actf)
			(*gdloc(pos).start)(pos);
		as &= ~(1<<drive);
	} else {
		rp = (struct device *)&(gd_addr[ctl]->ereg[0]);
		as = rp->as&0377;
	}
	for (drive=0; as; drive++)
		if (as & (1<<drive)) {
			as &= ~(1<<drive);
			pos = gdmkpos(ctl, drive);
			rp->as = (1<<drive);
			if (gdtype[pos])
				(*gdloc(pos).start)(pos);
			else if (gdutab[pos].wtime) {
				gdutab[pos].wtime = WOK;
				wakeup((caddr_t)&gdutab[pos]);
			}
		}
	mp->mbasr = -1;
	if (gdtab[ctl].b_actf != NULL)
		gdstart(ctl);
}

gdread(dev)
{
	if (physck(gdloc(gdpos(dev)).sizep[gdslice(dev)].nblocks, B_READ))
		physio(gdstrategy, 0, dev, B_READ);
}

gdwrite(dev)
{
	if (physck(gdloc(gdpos(dev)).sizep[gdslice(dev)].nblocks, B_WRITE))
		physio(gdstrategy, 0, dev, B_WRITE);
}

gdtimer(ctl)
{
	register pos, drive;
	register struct iobuf *dp;
	register struct buf *bp;

	for (drive = 0; drive < 8; drive++) {
		pos = gdmkpos(ctl, drive);
		dp = &gdutab[pos];
		if (dp->wtime == WOK)
			continue;
		if (gdtype[pos])
			(*gdloc(pos).start)(pos);
		if (dp->wtime == WOK)
			continue;
		if (dp->wtime == WABORT) {
			if (dp->io_erec)
				logberr(dp, B_ERROR);
			while (bp = dp->b_actf) {
				bp->b_flags |= B_ERROR;
				dp->b_actf = bp->av_forw;
				iodone(bp);
			}
			dp->b_active = 0;
			dp->b_errcnt = 0;
			dp->qcnt = 0;
			if (!gdtype[pos])
				wakeup((caddr_t)dp);
			printf("%s drive %d on controller %d not available\n",
				gdtype[pos] ? gdloc(pos).name : "Disk",
				drive, ctl);
		}
		dp->wtime--;
	}
	if (gdtab[ctl].b_active == 0 && gdtab[ctl].b_actf != NULL)
		gdstart(ctl);
	timeout(gdtimer, ctl, 15*HZ);
}

gdclr()
{
	register ctl, drive, pos;

	for (ctl = 0; ctl < gd_cnt; ctl++) {
		if (!(gdtab[ctl].b_flags&B_ONCE))
			continue;
		gdtab[ctl].b_active = 0;
		gdtab[ctl].b_actf = NULL;
		for (drive = 0; drive < 8; drive++) {
			pos = gdmkpos(ctl, drive);
			if (gdtype[pos])
				(*gdloc(pos).start)(pos);
		}
		gdstart(ctl);
	}
}

gdprint(dev, str)
char *str;
{
	register pos;

	pos = gdpos(dev);
	if (!gdtype[pos]) {
		printf("%s on dev %o(8), type unkown\n", str, dev);
		return;
	}
	printf("%s on %s drive %d,", str, gdloc(pos).name, gddrive(dev));
	if (gd_cnt > 1)
		printf(" ctl %d,", gdctl(dev));
	printf(" slice %d\n", gdslice(dev));
}
