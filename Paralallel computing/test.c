#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
int main(){
	printf("Num of threads %d\n",omp_get_num_threads());
	printf("----------------------------------------\n");
	#pragma omp parallel 
	{
		#pragma omp single 
		{
			printf("Num of threads %d\n",omp_get_num_threads());
			printf("Num of processors %d \n",omp_get_num_procs());
		}
		printf("Thread number is %d\n",omp_get_thread_num());
	}
	return 0;
}