#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>
#include "c_matrix.h"
#include <gsl/gsl_cblas.h>
#include <string.h>

void MM(int *A, int *B, int *C, int n);
void openMP_MM(int *A, int *B, int *C, int n);
void winograd(int *A, int *B, int *C, int n);
int winograd_inner(int *a, int *b, int n);
void run_algo(void (*algo)(), char alog_name[], int print);
void run_algo_cblas(int print);
void MM_dc(int *A, int *B, int *C, int n);
void strassen(int *A, int *B, int *C, int n);
void printMatrix(int *C, int n);
void printMatrix_double(double *C, int n);
void split(int *in, int *out, int n, int col, int row);
void join(int *in, int *out, int n, int col, int row);
void add(int *A, int *B, int *C, int n);
void sub(int *A, int *B, int *C, int n);
void multiply(int *A, int *B, int *C, int n);

int main() {
	// omp_set_dynamic(0);
	// omp_set_num_threads(4);
//	run_algo(openMP_MM, "openMP_MM",0);
	run_algo(MM_dc, "MM_dc",0);
	run_algo(strassen, "strassen",0);

	run_algo(MM, "MM", 0);
  run_algo(winograd, "winograd", 0);
  run_algo_cblas(0);

	return 0;
}

void MM(int *A, int *B, int *C, int n) {
	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < n; ++j) {
			int sum = 0;
			for (int k = 0; k < n; ++k) {
				sum += (*((A + i * n) + k)) * (*((B + k * n) + j));
			}
			*((C + i * n) + j) = sum;
		}
	}
}

int winograd_inner(int *a, int *b, int n){
	int ab = 0;
	if(n%2==0)
		{
			int xi = 0;
			int etha = 0;
			for(int i = 0; i<n/2;++i)
			{
				xi += a[2*i]*a[2*i+1];
				etha += b[2*i]*b[2*i+1];
				ab += (a[2*i]+b[2*i+1])*(a[2*i+1]+b[2*i]);
			}
			ab = ab-etha-xi;
		}
		return ab;
	}

	void winograd(int *A, int *B, int *C, int n) {

		int xi_array[n];
		int etha_array[n];
		int xi = 0;
		int etha = 0;
		int ab = 0;

		for (int i = 0; i < n; ++i) {
			xi = 0;
			etha = 0;
			for(int k = 0;k<n/2;++k)
			{
				xi += (*((A + i * n) + 2*k))*(*((A + i * n) + (2*k+1)));
				etha += (*((B + 2*k * n) + i))*(*((B + (2*k+1) * n) + i));
			}
			xi_array[i] = xi;
			etha_array[i] = etha;
    }

		for (int i = 0; i < n; ++i) {
			for (int j = 0; j < n; ++j) {
				ab = 0;
				for(int k = 0;k<n/2;++k)
				{
			  	ab += ((*((A + i * n) + 2*k))+(*((B + (2*k+1) * n) + j)))*((*((A + i * n) + (2*k+1)))+(*((B + 2*k * n) + j)));
				}
				*((C + i * n) + j) =  ab-etha_array[j]-xi_array[i];
				}
			}




		// for (int i = 0; i < n; ++i) {
		// 	int *a = (int*) malloc(n * sizeof(int));
		// 	for(int k = 0; k<n; ++k)
		// 	{
		// 		a[k] = (*((A + i * n) + k));
		// 	}
		//
		// 	for (int j = 0; j < n; ++j) {
		// 		int *b = (int*) malloc(n * sizeof(int));
		// 		for(int k = 0; k<n; ++k)
		// 		{
		// 			b[k] =(*((B + k * n) + j));
		// 		}
		// 		*((C + i * n) + j) = winograd_inner(a,b,n);
		// 		}
		// 	}
		}


void openMP_MM(int *A, int *B, int *C, int n) {

		#pragma omp parallel for
		for (int i = 0; i < n; ++i) {
			for (int j = 0; j < n; ++j) {
				int sum = 0;
				for (int k = 0; k < n; ++k) {
					sum += (*((A + i * n) + k)) * (*((B + k * n) + j));
				}
				*((C + i * n) + j) = sum;
			}
		}
}

void MM_dc(int *A, int *B, int *C, int n) {
	if (n <= 2) {
		MM((int*) A, (int*) B, (int*) C, n);
	} else {
		int *A11 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *A12 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *A21 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *A22 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *B11 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *B12 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *B21 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *B22 = (int*) malloc(n / 2 * n / 2 * sizeof(int));

		split((int*) A, (int*) A11, n / 2, 0, 0);
		split((int*) A, (int*) A12, n / 2, 0, n / 2);
		split((int*) A, (int*) A21, n / 2, n / 2, 0);
		split((int*) A, (int*) A22, n / 2, n / 2, n / 2);
		split((int*) B, (int*) B11, n / 2, 0, 0);
		split((int*) B, (int*) B12, n / 2, 0, n / 2);
		split((int*) B, (int*) B21, n / 2, n / 2, 0);
		split((int*) B, (int*) B22, n / 2, n / 2, n / 2);

		int *tmp1 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *tmp2 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *tmp3 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *tmp4 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *tmp5 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *tmp6 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *tmp7 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *tmp8 = (int*) malloc(n / 2 * n / 2 * sizeof(int));

		MM_dc((int*) A11, (int*) B11, (int*) tmp1, n / 2);
		MM_dc((int*) A12, (int*) B21, (int*) tmp2, n / 2);
		MM_dc((int*) A11, (int*) B12, (int*) tmp3, n / 2);
		MM_dc((int*) A12, (int*) B22, (int*) tmp4, n / 2);
		MM_dc((int*) A21, (int*) B11, (int*) tmp5, n / 2);
		MM_dc((int*) A22, (int*) B21, (int*) tmp6, n / 2);
		MM_dc((int*) A21, (int*) B12, (int*) tmp7, n / 2);
		MM_dc((int*) A22, (int*) B22, (int*) tmp8, n / 2);

		free(A11);
		free(A12);
		free(A21);
		free(A22);
		free(B11);
		free(B12);
		free(B21);
		free(B22);

		int *C11 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *C12 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *C21 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *C22 = (int*) malloc(n / 2 * n / 2 * sizeof(int));

		add((int*) tmp1, (int*) tmp2, (int*) C11, n / 2);
		add((int*) tmp3, (int*) tmp4, (int*) C12, n / 2);
		add((int*) tmp5, (int*) tmp6, (int*) C21, n / 2);
		add((int*) tmp7, (int*) tmp8, (int*) C22, n / 2);

		free(tmp1);
		free(tmp2);
		free(tmp3);
		free(tmp4);
		free(tmp5);
		free(tmp6);
		free(tmp7);
		free(tmp8);

		join((int*) C11, (int*) C, n / 2, 0, 0);
		join((int*) C12, (int*) C, n / 2, 0, n / 2);
		join((int*) C21, (int*) C, n / 2, n / 2, 0);
		join((int*) C22, (int*) C, n / 2, n / 2, n / 2);

		free(C11);
		free(C12);
		free(C21);
		free(C22);

	}
}

void strassen(int *A, int *B, int *C, int n) {
	if (n <= 2) {

		int P, Q, R, S, T, U, V;
		P = ((*((A + 0 * n) + 0)) + (*((A + 1 * n) + 1)))
				* ((*((B + 0 * n) + 0)) + (*((B + 1 * n) + 1)));
		Q = ((*((A + 1 * n) + 0)) + (*((A + 1 * n) + 1)))
				* ((*((B + 0 * n) + 0)));
		R = ((*((A + 0 * n) + 0)))
				* ((*((B + 0 * n) + 1)) - (*((B + 1 * n) + 1)));
		S = ((*((A + 1 * n) + 1)))
				* ((*((B + 1 * n) + 0)) - (*((B + 0 * n) + 0)));
		T = ((*((A + 0 * n) + 0)) + (*((A + 0 * n) + 1)))
				* ((*((B + 1 * n) + 1)));
		U = ((*((A + 1 * n) + 0)) - (*((A + 0 * n) + 0)))
				* ((*((B + 0 * n) + 0)) + (*((B + 0 * n) + 1)));
		V = ((*((A + 0 * n) + 1)) - (*((A + 1 * n) + 1)))
				* ((*((B + 1 * n) + 0)) + (*((B + 1 * n) + 1)));
		(*((C + 0 * n) + 0)) = P + S - T + V;
		(*((C + 0 * n) + 1)) = R + T;
		(*((C + 1 * n) + 0)) = Q + S;
		(*((C + 1 * n) + 1)) = P + R - Q + U;

	} else {
		int *A11 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *A12 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *A21 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *A22 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *B11 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *B12 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *B21 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *B22 = (int*) malloc(n / 2 * n / 2 * sizeof(int));

		split((int*) A, (int*) A11, n / 2, 0, 0);
		split((int*) A, (int*) A12, n / 2, 0, n / 2);
		split((int*) A, (int*) A21, n / 2, n / 2, 0);
		split((int*) A, (int*) A22, n / 2, n / 2, n / 2);
		split((int*) B, (int*) B11, n / 2, 0, 0);
		split((int*) B, (int*) B12, n / 2, 0, n / 2);
		split((int*) B, (int*) B21, n / 2, n / 2, 0);
		split((int*) B, (int*) B22, n / 2, n / 2, n / 2);

		int *P = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *Q = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *R = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *S = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *T = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *U = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *V = (int*) malloc(n / 2 * n / 2 * sizeof(int));

		int *addA = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *addB = (int*) malloc(n / 2 * n / 2 * sizeof(int));

    add((int*) A11, (int*) A22, (int*) addA, n / 2);
		add((int*) B11, (int*) B22, (int*) addB, n / 2);
		strassen((int*) addA, (int*) addB, (int*) P, n / 2);

		add((int*) A21, (int*) A22, (int*) addA, n / 2);
		strassen((int*) addA, (int*) B11, (int*) Q, n / 2);

		sub((int*) B12, (int*) B22, (int*) addB, n / 2);
		strassen((int*) A11, (int*) addB, (int*) R, n / 2);

		sub((int*) B21, (int*) B11, (int*) addB, n / 2);
		strassen((int*) A22, (int*) addB, (int*) S, n / 2);

		add((int*) A11, (int*) A12, (int*) addA, n / 2);
		strassen((int*) addA, (int*) B22, (int*) T, n / 2);

		sub((int*) A21, (int*) A11, (int*) addA, n / 2);
		add((int*) B11, (int*) B12, (int*) addB, n / 2);
		strassen((int*) addA, (int*) addB, (int*) U, n / 2);

		sub((int*) A12, (int*) A22, (int*) addA, n / 2);
		add((int*) B21, (int*) B22, (int*) addB, n / 2);
		strassen((int*) addA, (int*) addB, (int*) V, n / 2);

		free(A11);
		free(A12);
		free(A21);
		free(A22);
		free(B11);
		free(B12);
		free(B21);
		free(B22);
		free(addA);
		free(addB);

		int *C11 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *C12 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *C21 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *C22 = (int*) malloc(n / 2 * n / 2 * sizeof(int));

		int *resAdd1 = (int*) malloc(n / 2 * n / 2 * sizeof(int));
		int *resAdd2 = (int*) malloc(n / 2 * n / 2 * sizeof(int));

		add((int*) R, (int*) T, (int*) C12, n / 2);
		add((int*) Q, (int*) S, (int*) C21, n / 2);

		add((int*) P, (int*) S, (int*) resAdd1, n / 2);
		add((int*) resAdd1, (int*) V, (int*) resAdd2, n / 2);
		sub((int*) resAdd2, (int*) T, (int*) C11, n / 2);

		add((int*) P, (int*) R, (int*) resAdd1, n / 2);
		add((int*) resAdd1, (int*) U, (int*) resAdd2, n / 2);
		sub((int*) resAdd2, (int*) Q, (int*) C22, n / 2);

		free(P);
		free(Q);
		free(R);
		free(S);
		free(T);
		free(U);
		free(V);
		free(resAdd1);
		free(resAdd2);

		join((int*) C11, (int*) C, n / 2, 0, 0);
		join((int*) C12, (int*) C, n / 2, 0, n / 2);
		join((int*) C21, (int*) C, n / 2, n / 2, 0);
		join((int*) C22, (int*) C, n / 2, n / 2, n / 2);

		free(C11);
		free(C12);
		free(C21);
		free(C22);
	}
}

void add(int *A, int *B, int *C, int n) {
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			*((C + i * n) + j) = *((A + i * n) + j) + *((B + i * n) + j);
		}
	}
}

void sub(int *A, int *B, int *C, int n) {
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			*((C + i * n) + j) = *((A + i * n) + j) - *((B + i * n) + j);
		}
	}
}

void multiply(int *A, int *B, int *C, int n) {
	int mul;

	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < n; ++j) {
			mul = (*((A + i * n) + j)) * (*((B + i * n) + j));
			*((C + i * n) + j) = mul;
		}
	}
}

void split(int *in, int *out, int n, int col, int row) {
	for (int i1 = 0, i2 = col; i1 < n; i1++, i2++)
		for (int j1 = 0, j2 = row; j1 < n; j1++, j2++) {
			*((out + i1 * n) + j1) = *((in + i2 * n * 2) + j2);

		}
}

void join(int *in, int *out, int n, int col, int row) {
	for (int i1 = 0, i2 = col; i1 < n; i1++, i2++)
		for (int j1 = 0, j2 = row; j1 < n; j1++, j2++)
			*((out + i2 * n * 2) + j2) = *((in + i1 * n) + j1);
}

void printMatrix(int *C, int n) {
	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < n; ++j) {
			printf("%d ", *((C + i * n) + j));
		}
		printf("\n");
	}
}

void printMatrix_double(double *C, int n) {
	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < n; ++j) {
			printf("%.0f ", *((C + i * n) + j));
		}
		printf("\n");
	}
}

void run_algo(void (*algo)(), char alog_name[], int print)
{
	FILE *fptr;

	char fileName[40] =  "meas/";
	strcat(fileName, alog_name);
	strcat(fileName, ".txt");
	fptr = fopen(fileName, "w");


	for(int i=0; i<n_arrays; ++i)
	{
		for(int j = 0; j<1; ++j)
		{
	    int *C = (int*) malloc(n[i] * n[i] * sizeof(int));
    	double dtime = omp_get_wtime();
      algo(Ap[i], Bp[i], (int*) C, n[i]);
	    dtime = omp_get_wtime() - dtime;
			// printf("The %s program took %f seconds to execute \n", alog_name, dtime);
			fprintf(fptr, "%f,%d\n", dtime, n[i]);

			if(print==1)
			{
				printMatrix((int*)C, n[i]);
			}
			free(C);
  }
	}
	fclose(fptr);

}

void run_algo_cblas(int print)
{

	FILE *fptr;

	fptr = fopen("meas/blas.txt", "w");
	for(int i=0; i<n_arrays; ++i)
	{
		for(int j = 0; j<1; ++j)
		{
			double *dC = (double*) malloc(n[i] * n[i] * sizeof(double));
			double dtime = omp_get_wtime();
			cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, n[i], n[i], n[i], 1.0, dAp[i], n[i],
			dBp[i], n[i], 0.0, dC, n[i]);
			dtime = omp_get_wtime() - dtime;
			// printf("The cblas program took %f seconds to execute \n", dtime);
			fprintf(fptr, "%f,%d\n",dtime, n[i]);

			if(print==1)
			{
				printMatrix_double( (double*)dC, n[i]);
			}

			free(dC);
		}
	}
	fclose(fptr);

}
