#/**
# * $Revision: 144 $
# *
# * 吉里吉里プラグインを全てビルドします。
#**/

KRKRPLUGINDIR = .
include $(KRKRPLUGINDIR)/MakefileKrkrPlugins

projects = BlueMonday-88


target : $(TPSTUBOBJ) $(NCBINDOBJ)
	@(set -e; for dir in $(projects); do cd $$dir; $(MAKE) all; cd ..; done)
	@echo "All done."

$(NCBINDOBJ) :
	@(set -e; cd ncbind; $(MAKE) all;)

clean :
	@(set -e; cd ncbind; $(MAKE) clean;)
	@(set -e; for dir in $(projects); do cd $$dir; $(MAKE) clean; cd ..; done)
	rm -f $(TPSTUBOBJ)


