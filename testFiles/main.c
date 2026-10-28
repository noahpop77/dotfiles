#include <stdio.h>
#include <time.h>
#include <unistd.h>


int main(void) {
    time_t inttime = time(NULL);
    printf("%ld Hello, world!\n", inttime);
    return 0;
}
