CXX  = g++
CXX += -I./

CXXFLAGS  = -g -Wall -fPIC -Wno-deprecated
CXXFLAGS += -fconcepts

all: cpuinfo

cpuinfo: cpuinfo.c
	$(CXX) -o $@ $^ $(CXXFLAGS)

clean:
	rm -f cpuinfo
	rm -f *~
