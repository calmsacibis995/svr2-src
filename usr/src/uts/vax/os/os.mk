# @(#)os.mk	6.6
LIBNAME = ../lib1
INCRT = /usr/include
CFLAGS = -O -I$(INCRT)
C2 = /lib/c2
FRC =
FILES =\
	$(LIBNAME)(acct.o)\
	$(LIBNAME)(alloc.o)\
	$(LIBNAME)(bio.o)\
	$(LIBNAME)(bitmasks.o)\
	$(LIBNAME)(blklist.o)\
	$(LIBNAME)(clock.o)\
	$(LIBNAME)(errlog.o)\
	$(LIBNAME)(exec.o)\
	$(LIBNAME)(exit.o)\
	$(LIBNAME)(fault.o)\
	$(LIBNAME)(fio.o)\
	$(LIBNAME)(flock.o)\
	$(LIBNAME)(fork.o)\
	$(LIBNAME)(getpages.o)\
	$(LIBNAME)(grow.o)\
	$(LIBNAME)(iget.o)\
	$(LIBNAME)(ipc.o)\
	$(LIBNAME)(lock.o)\
	$(LIBNAME)(machdep.o)\
	$(LIBNAME)(macherr.o)\
	$(LIBNAME)(main.o)\
	$(LIBNAME)(malloc.o)\
	$(LIBNAME)(move.o)\
	$(LIBNAME)(msg.o)\
	$(LIBNAME)(nami.o)\
	$(LIBNAME)(page.o)\
	$(LIBNAME)(physio.o)\
	$(LIBNAME)(pipe.o)\
	$(LIBNAME)(prf.o)\
	$(LIBNAME)(probe.o)\
	$(LIBNAME)(ptrace.o)\
	$(LIBNAME)(rdwri.o)\
	$(LIBNAME)(region.o)\
	$(LIBNAME)(sched.o)\
	$(LIBNAME)(sem.o)\
	$(LIBNAME)(shm.o)\
	$(LIBNAME)(sig.o)\
	$(LIBNAME)(slp.o)\
	$(LIBNAME)(startup.o)\
	$(LIBNAME)(subr.o)\
	$(LIBNAME)(swapalloc.o)\
	$(LIBNAME)(swtch.o)\
	$(LIBNAME)(sys1.o)\
	$(LIBNAME)(sys2.o)\
	$(LIBNAME)(sys3.o)\
	$(LIBNAME)(sys4.o)\
	$(LIBNAME)(syscall.o)\
	$(LIBNAME)(sysent.o)\
	$(LIBNAME)(text.o)\
	$(LIBNAME)(timeout.o)\
	$(LIBNAME)(trap.o)\
	$(LIBNAME)(utssys.o)

all:	$(LIBNAME) 

.PRECIOUS:	$(LIBNAME)

$(LIBNAME):	$(FILES)
	-chown bin $(LIBNAME)
	-chgrp bin $(LIBNAME)
	-chmod 664 $(LIBNAME)

.c.a:
	$(CC) -I$(INCRT) -S $<
	ed - $*.s <../spl.ed
	sed -f ../calls.sed < $*.s > $*.ss
	$(C2) $*.ss $*.os$
	as -o $*.o $*.os$
	rm -f $*.s $*.ss $*.os
	ar rv $@ $*.o
	-rm -f $*.o
clean:
	-rm -f *.o

clobber:	clean
	-rm -f $(LIBNAME)

$(LIBNAME)(acct.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/acct.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/file.h\
	$(FRC)
$(LIBNAME)(alloc.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/mount.h\
	$(INCRT)/sys/filsys.h\
	$(INCRT)/sys/fblk.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/ino.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/var.h\
	$(FRC)
$(LIBNAME)(bio.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/iobuf.h\
	$(INCRT)/sys/conf.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/var.h\
	$(FRC)
$(LIBNAME)(bitmasks.o):\
	$(FRC)
$(LIBNAME)(blklist.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(clock.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/psl.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/callo.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/text.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/tuneable.h\
	$(INCRT)/sys/sysmacros.h\
	$(FRC)

$(LIBNAME)(errlog.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/conf.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/utsname.h\
	$(INCRT)/sys/mba.h\
	$(INCRT)/sys/elog.h\
	$(INCRT)/sys/erec.h\
	$(INCRT)/sys/err.h\
	$(INCRT)/sys/iobuf.h\
	$(INCRT)/sys/var.h\
	$(FRC)
$(LIBNAME)(exec.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/acct.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/reg.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/filehdr.h\
	$(INCRT)/scnhdr.h\
	$(INCRT)/aouthdr.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(exit.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(fault.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/psl.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/utsname.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/pfdat.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/swap.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(fio.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/filsys.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/conf.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/mount.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/acct.h\
	$(INCRT)/sys/sysinfo.h\
	$(FRC)
$(LIBNAME)(flock.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/flock.h\
	$(FRC)
$(LIBNAME)(fork.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/text.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(getpages.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/tuneable.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/pfdat.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/swap.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(grow.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/tuneable.h\
	$(INCRT)/sys/bitmasks.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/pfdat.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(iget.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/mount.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/ino.h\
	$(INCRT)/sys/filsys.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/stat.h\
	$(INCRT)/sys/conf.h\
	$(FRC)
$(LIBNAME)(ipc.o):\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/ipc.h\
	$(FRC)
$(LIBNAME)(lock.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/lock.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(FRC)
$(LIBNAME)(machdep.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/reg.h\
	$(INCRT)/sys/psl.h\
	$(INCRT)/sys/utsname.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/clock.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/shm.h\
	$(INCRT)/sys/acct.h\
	$(INCRT)/sys/file.h\
	$(FRC)
$(LIBNAME)(macherr.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/sysinfo.h\
	$(FRC)
$(LIBNAME)(main.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/filsys.h\
	$(INCRT)/sys/mount.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/conf.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(malloc.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/mem.h\
	$(FRC)
$(LIBNAME)(move.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/buf.h\
	$(FRC)
$(LIBNAME)(msg.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/msg.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysmacros.h\
	$(FRC)
$(LIBNAME)(nami.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/mount.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/var.h\
	$(FRC)
$(LIBNAME)(page.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/mount.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/pfdat.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/swap.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(physio.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/conf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/swap.h\
	$(FRC)
$(LIBNAME)(pipe.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/file.h\
	$(FRC)
$(LIBNAME)(prf.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/conf.h\
	$(FRC)
$(LIBNAME)(probe.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/text.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/errno.h\
	$(FRC)
$(LIBNAME)(ptrace.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/reg.h\
	$(INCRT)/sys/text.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/psl.h\
	$(FRC)
$(LIBNAME)(rdwri.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/conf.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/tty.h\
	$(FRC)
$(LIBNAME)(region.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/pfdat.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/debug.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/map.h\
	$(FRC)
$(LIBNAME)(sched.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/text.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/errno.h\
	$(FRC)
$(LIBNAME)(sem.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/sem.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/buf.h\
	$(FRC)
$(LIBNAME)(shm.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/shm.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/mtpr.h\
	$(FRC)
$(LIBNAME)(sig.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/text.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/ipc.h\
	$(FRC)
$(LIBNAME)(slp.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/text.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/errno.h\
	$(FRC)
$(LIBNAME)(startup.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/reg.h\
	$(INCRT)/sys/psl.h\
	$(INCRT)/sys/utsname.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/clock.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/shm.h\
	$(INCRT)/sys/acct.h\
	$(INCRT)/sys/tty.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/pfdat.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(subr.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/mount.h\
	$(INCRT)/sys/var.h\
	$(FRC)
$(LIBNAME)(swapalloc.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/conf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/swap.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(swtch.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/sysinfo.h\
	$(FRC)
$(LIBNAME)(sys1.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/reg.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/acct.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/ipc.h\
	$(INCRT)/sys/shm.h\
	$(FRC)
$(LIBNAME)(sys2.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/sysinfo.h\
	$(FRC)
$(LIBNAME)(sys3.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/mount.h\
	$(INCRT)/sys/ino.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/filsys.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/flock.h\
	$(INCRT)/sys/conf.h\
	$(INCRT)/sys/stat.h\
	$(INCRT)/sys/ttold.h\
	$(INCRT)/sys/var.h\
	$(FRC)
$(LIBNAME)(sys4.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/file.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/clock.h\
	$(FRC)
$(LIBNAME)(syscall.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/map.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/reg.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/psl.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/mtpr.h\
	$(FRC)
$(LIBNAME)(sysent.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/systm.h\
	$(FRC)
$(LIBNAME)(text.o):\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/inode.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/pfdat.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(timeout.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/callo.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/text.h\
	$(INCRT)/sys/psl.h\
	$(INCRT)/sys/var.h\
	$(FRC)
$(LIBNAME)(trap.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/systm.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/region.h\
	$(INCRT)/sys/proc.h\
	$(INCRT)/sys/reg.h\
	$(INCRT)/sys/psl.h\
	$(INCRT)/sys/trap.h\
	$(INCRT)/sys/seg.h\
	$(INCRT)/sys/sysinfo.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/mtpr.h\
	$(INCRT)/sys/debug.h\
	$(FRC)
$(LIBNAME)(utssys.o):\
	$(INCRT)/sys/param.h\
	$(INCRT)/sys/types.h\
	$(INCRT)/sys/sysmacros.h\
	$(INCRT)/sys/page.h\
	$(INCRT)/sys/buf.h\
	$(INCRT)/sys/filsys.h\
	$(INCRT)/sys/mount.h\
	$(INCRT)/sys/dir.h\
	$(INCRT)/sys/signal.h\
	$(INCRT)/sys/user.h\
	$(INCRT)/sys/errno.h\
	$(INCRT)/sys/var.h\
	$(INCRT)/sys/utsname.h\
	$(FRC)
FRC:
