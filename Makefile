vpath:
	echo `hostname` TOS > $(LM_VPATH_FN)

foo:
	$(MAKE) -f $(LM_MAKEFILE) bar
	touch $@

bar:
	touch $@
