//C, C++
#include <iostream>
#include <stdlib.h>
#include <assert.h>
#include <fstream>
#include <iomanip>
#include <time.h>
#include <chrono>
#include <thread>

int _i_max = 50000;

double dummyloop(int i_max = 50000);

static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
                                unsigned int *ecx, unsigned int *edx);
void native_cpuid_main();

int main(int argc, char *argv[]){
  //
  if(argc == 4 && atoi(argv[1])==1){
    clock_t start, finish;
    start = clock();
    std::ofstream fout;
    std::string jobID = argv[2];
    std::string fname = argv[3];
    std::cout<<"jobID        : "<<jobID<<std::endl
	     <<"fname        : "<<fname<<std::endl;
    fout.open(fname.c_str());
    fout<<"jobID        : "<<jobID<<std::endl;
    fout<<"fname        : "<<fname<<std::endl;
    fout<<"dummyloop()  : "<<dummyloop(_i_max)<<std::endl;
    fout<<"i_max        : "<<_i_max<<std::endl;
    fout<<"n loops      : "<<(double)_i_max*(double)_i_max<<std::endl;
    fout<<"threadID     : "<<std::this_thread::get_id()<<std::endl;
    finish = clock();
    fout<<"Working time : "<<(finish - start)/CLOCKS_PER_SEC<<" (sec)"<<std::endl;
    std::cout<<"Working time : "<<(finish - start)/CLOCKS_PER_SEC<<" (sec)"<<std::endl;
    fout.close();
    //
  }
  else if(argc == 2 && atoi(argv[1])==2){
    native_cpuid_main();
  }
  else{
    std::cout<<"  jobID   [1]"<<std::endl
	     <<"  fileout [2]"<<std::endl;
  }
  //
  return 0;
}

double dummyloop(int i_max){
  double a = 0.0;
  for(int i = 0;i<i_max;i++)
    for(int j = 0;j<i_max;j++)
      a+=i;
  return a;
}

void native_cpuid_main(){
 unsigned eax, ebx, ecx, edx;

  eax = 1; /* processor info and feature bits */
  native_cpuid(&eax, &ebx, &ecx, &edx);

  printf("stepping %d\n", eax & 0xF);
  printf("model %d\n", (eax >> 4) & 0xF);
  printf("family %d\n", (eax >> 8) & 0xF);
  printf("processor type %d\n", (eax >> 12) & 0x3);
  printf("extended model %d\n", (eax >> 16) & 0xF);
  printf("extended family %d\n", (eax >> 20) & 0xFF);
  
  /* EDIT */
  eax = 3; /* processor serial number */
  native_cpuid(&eax, &ebx, &ecx, &edx);

  /** see the CPUID Wikipedia article on which models return the serial 
      number in which registers. The example here is for 
      Pentium III */
  printf("serial number 0x%08x%08x\n", edx, ecx);
}
  
static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
                                unsigned int *ecx, unsigned int *edx)
{
        /* ecx is often an input as well as an output. */
        asm volatile("cpuid"
            : "=a" (*eax),
              "=b" (*ebx),
              "=c" (*ecx),
              "=d" (*edx)
            : "0" (*eax), "2" (*ecx));
}
