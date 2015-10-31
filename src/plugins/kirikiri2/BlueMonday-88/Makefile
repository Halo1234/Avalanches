#/**
# * $Revision: 144 $
#**/

KRKRPLUGINDIR = ..
include $(KRKRPLUGINDIR)/MakefileKrkrPlugins

CPPFLAGS += -DBLUEMONDAY88_EXPORTS
TARGETNAME = BlueMonday-88

TARGET = $(TARGETNAME).dll
IMPORTLIB = $(TARGETNAME).lib
EXPORTDEF = $(TARGETNAME).gcc.def

cpps =\
	  BM88Version.cpp\
	  CutMask.cpp\
	  Mod2DC.cpp\
	  Registory.cpp
objs = $(cpps:.cpp=.o)

target : $(TARGET)
	@echo ""
	@echo "   BlueMonday-88.dll build complited."
	@echo ""

$(TARGET) : $(objs)
	$(CXX) -shared -o $(TARGET) $(EXPORTDEF) $(TPSTUBOBJ) $(NCBINDOBJ) $(objs)
	cp $(TARGET) $(TOOLSDIR)/plugins/$(TARGET)
	$(TOOLSDIR)/plugins/update.sh

ifneq ($(MAKECMDGOALS), clean)
include $(cpps:.cpp=.d)
endif

clean :
	rm -f $(objs) $(cpps:.cpp=.d) $(TARGET) $(IMPORTLIB)


