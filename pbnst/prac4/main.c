#include <stdio.h>
#include "controlsem.h"
#include <stdbool.h>





int main() {

  controlsem_init();
  while (true){
    tick_monitor();
    tick_semaphore();
  }
  return 0;
}
