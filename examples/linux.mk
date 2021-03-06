# vim: syntax=make
reboot=sync;sync;sync;sleep 35;sync;shutdown -r now; exit 1

Block00: images rsync_all 

Gold00:	systemimager_rsyncd systemimager-rsync-args.patch

cron: rsync_all 

images:
	- umount $(images)
	- umount $(images)
	if [ -n "$(EXPORT_IMAGES)" ] ;\
	then \
		rm -f $(images); \
		ln -s $(EXPORT_IMAGES) $(images); \
		touch $@; \
	else \
		mkdir -p $(images) ; \
		mount -o bg,soft,intr,rsize=8192,wsize=8192,vers=3 \
			$(imagesvr) $(images); \
	fi


rsync_all:
	cd /; rsync -avz $(RSYNC_SERVER)::common .
	cd /; rsync -avz $(RSYNC_SERVER)::$(OS) .
	cd /; rsync -avz $(RSYNC_SERVER)::$(DOMAIN) .
	chmod 600 /root/.ssh/authorized_keys 
	chmod 440 /etc/sudoers
	# chmod 750 /etc/security
	# apt-get update

rsyncd:
	ln -s /etc/init.d/rsyncd /etc/rcS.d/S41rsyncd
	touch $@

systemimager_rsyncd:
	ln -s /etc/systemimager/rsyncd.conf /etc/rsyncd.conf
	ln -s /etc/init.d/systemimager-server /etc/rcS.d/S41rsyncd
	touch $@

setdate:
	- ntpdate -b $(NTPDATE_SERVERS)


#################################################################
#
#  "standard" rules below
#
#################################################################


# install a deb
%.deb:
	dpkg -i $(images)/$@
	mkdir -p `dirname $@`
	touch $@

# install an RPM
%.rpm:
	rpm -Uvh $(images)/foo.com/$@
	touch $@

%.tar.gz:
	rm -rf /tmp/$* # to avoid symlink attacks
	cd /tmp && tar -xzvf $(images)/t7a.org/apt-tar/$@
	cd /tmp/$* && make install
	rm -rf /tmp/$*
	touch $@

# Patches made with:
#
# echo etc/fai/fai.conf | cpio -pudvm /tmp
# cd /tmp
# vi etc/fai/fai.conf
# makepatch ../etc/fai/fai.conf etc/fai/fai.conf >
#     ~/cvs/t7a.org/patches/fai.conf-localize.patch
#
# bootmisc.sh-notmp.patch fai.conf-localize.patch \
#   systemimager-rsync-args.patch \
#   : patchutils_0.2.11-2 makepatch_2.00.03-1 
%.patch:
	cd /; applypatch -verbose $(images)/t7a.org/patches/$@
	touch $@


# example default 
# .DEFAULT:
# 	# apt-get -q -y install `echo $@ | tr '_' '=' | tr '+' ':' `
# 	$(ISCONFDIR)/bin/apkg $(images)/apt-proxy $@
# 	touch $@

