#!/bin/sh
rm -f /var/lock/LCK..
/sbin/apcupsd -b &
/sbin/apcupsd_exporter

