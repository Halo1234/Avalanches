#/**
# * $Revision: 144 $
# *
# * NSIS プラグインを全てビルドします。
#**/

NSISPLUGINDIR = .
include $(NSISPLUGINDIR)/MakefileNsisPlugins

projects = MorningNightcap


target :
	@(set -e; for dir in $(projects); do cd $$dir; $(MAKE) all; cd ..; done)
	@echo "All done."

clean :
	@(set -e; for dir in $(projects); do cd $$dir; $(MAKE) clean; cd ..; done)


