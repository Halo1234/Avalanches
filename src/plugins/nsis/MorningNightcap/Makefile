#/**
# * $Revision: 144 $
#**/

NSISPLUGINDIR = ..
include $(NSISPLUGINDIR)/MakefileNsisPlugins

CPPFLAGS += -DMORNINGNIGHTCAP_EXPORTS
TARGETNAME = MorningNightcap

TARGET = $(TARGETNAME).dll
IMPORTLIB = $(TARGETNAME).lib
EXPORTDEF = $(TARGETNAME).def

cpps =\
	  Entry.cpp\
	  ExportFunctions.cpp\
	  Index.cpp\
	  KrkrCF.cpp\
	  TextBasedFile.cpp\
	  ExternalInstallerIndex.cpp
objs = $(cpps:.cpp=.o)

target : $(TARGET)
	@echo ""
	@echo "   MorningNightcap.dll build completed."
	@echo ""

$(TARGET) : $(objs)
	$(CXX) $(CXXFLAGS) -shared -o $(TARGET) $(EXPORTDEF) $(objs) -lpluginapi
	cp $(TARGET) $(TOOLSDIR)/plugins/$(TARGET)
#	$(TOOLSDIR)/plugins/update.sh

ifneq ($(MAKECMDGOALS), clean)
include $(cpps:.cpp=.d)
endif

clean :
	rm -f $(objs) $(cpps:.cpp=.d) $(TARGET) $(IMPORTLIB)


