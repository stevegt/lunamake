# vim: syntax=make
imagesvr=$(IMAGESVR)
images=$(IMAGES)
barrier_port=$(BARRIER_PORT)
barrier=$(BARRIER)

all: 
	@echo usage: isconf CONTEXT
	exit 126

# NOTE: the exclude stanza is normally never executed and is only here
# to catch errors in the 'isconf' script.  The isconf script
# itself should catch excludes
exclude:
	@echo excluding $(HOSTNAME) from configuration management -- exiting
	exit 127

reboot:
	- rm .reboot_needed
	shutdown -r now
	sleep 999

Data-Dump-0.04: gzip 
	IMAGES=$(IMAGES) $(ISCONFDIR)/bin/installpm $@
	touch $@

IS-Init-0.92: 
	chfs -a size=+10000 /usr
	cd /tmp; gunzip -c $(images)/cpan.org/$@.tar.gz | tar xvf -
	cd /tmp/$@; perl Makefile.PL; make test install
	cp /tmp/$@/isinit /etc
	mkdir -p /var/run/is
	touch $@

include $(ISCONFDIR)/conf/$(OS).mk
# include $(ISCONFDIR)/conf/$(OS)_$(OSVERSION).mk
# include $(ISCONFDIR)/conf/$(OS)_$(OSVERSION)_$(HARDWARE).mk

