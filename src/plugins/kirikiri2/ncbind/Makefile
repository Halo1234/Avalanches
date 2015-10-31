#/**
# * $Revision: 144 $
#**/

KRKRPLUGINDIR = ..
include $(KRKRPLUGINDIR)/MakefileKrkrPlugins

cpps =\
	 ncbind.cpp
objs = $(cpps:.cpp=.o)

target : objs

objs : $(objs)

ifneq ($(MAKECMDGOALS), clean)
include $(cpps:.cpp=.d)
endif

clean :
	rm -f $(objs)
	rm -f $(cpps:.cpp=.d)


