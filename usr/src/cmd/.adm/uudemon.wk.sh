
#	@(#)uudemon.wk.sh	1.4

# 'perform once per week, Sunday at 0530 hours'
PATH=:/usr/lib/uucp:/bin:/usr/bin
cd /usr/spool/uucp
rm -f o.Log-WEEK* o.SYSLOG*
mv Log-WEEK o.Log-WEEK
(date; echo =============================) >> o.Log-WEEK
mv SYSLOG o.SYSLOG
pack o.Log-WEEK o.SYSLOG
