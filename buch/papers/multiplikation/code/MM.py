#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar 19 07:31:29 2021

@author: nunigan
"""
import numpy as np
import time
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
import tikzplotlib
def MM(A, B):
    n = np.shape(A)[0]
    C = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            C[i, j] = 0
            for k in range(n):
                C[i, j] += A[i, k]*B[k, j]
    return C


def MM_dc(A, B):
    n = np.shape(A)[0]
    if(n <= 2):
        C = np.zeros((n, n))
        C[0, 0] = A[0, 0]*B[0, 0]+A[0, 1]*B[1, 0]
        C[0, 1] = A[0, 0]*B[0, 1]+A[0, 1]*B[1, 1]
        C[1, 0] = A[1, 0]*B[0, 0]+A[1, 1]*B[1, 0]
        C[1, 1] = A[1, 0]*B[0, 1]+A[1, 1]*B[1, 1]
        return C
    else:
        A11, A12, A21, A22 = A[:n//2, :n//2], A[:n//2, n//2:], A[n//2:, :n//2], A[n//2:, n//2:]
        B11, B12, B21, B22 = B[:n//2, :n//2], B[:n//2, n//2:], B[n//2:, :n//2], B[n//2:, n//2:]
        C11 = MM_dc(A11, B11) + MM_dc(A12, B21)
        C12 = MM_dc(A11, B12) + MM_dc(A12, B22)
        C21 = MM_dc(A21, B11) + MM_dc(A22, B21)
        C22 = MM_dc(A21, B12) + MM_dc(A22, B22)
        C = np.vstack((np.hstack((C11, C12)), np.hstack((C21, C22))))
    return C


def strassen(A, B):
    n = np.shape(A)[0]
    if(n <= 2):
        C = np.zeros((n, n))
        P = (A[0, 0]+A[1, 1])*(B[0, 0]+B[1, 1])
        Q = (A[1, 0]+A[1, 1])*B[0, 0]
        R = A[0, 0]*(B[0, 1]-B[1, 1])
        S = A[1, 1]*(B[1, 0]-B[0, 0])
        T = (A[0, 0]+A[0, 1])*B[1, 1]
        U = (A[1, 0]-A[0, 0])*(B[0, 0]+B[0, 1])
        V = (A[0, 1]-A[1, 1])*(B[1, 0]+B[1, 1])
        C[0, 0] = P+S-T+V
        C[0, 1] = R+T
        C[1, 0] = Q+S
        C[1, 1] = P+R-Q+U
        return C
    else:
        m = n//2
        A11, A12, A21, A22 = A[:m, :m], A[:m, m:], A[m:, :m], A[m:, m:]
        B11, B12, B21, B22 = B[:m, :m], B[:m, m:], B[m:, :m], B[m:, m:]
        P = strassen((A11+A22),(B11+B22))
        Q = strassen((A21+A22),B11)
        R = strassen(A11,(B12-B22))
        S = strassen(A22,(B21-B11))
        T = strassen((A11+A12),B22)
        U = strassen((A21-A11),(B11+B12))
        V = strassen((A12-A22),(B21+B22))
        
        C11 = P+S-T+V
        C12 = R+T
        C21 = Q+S
        C22 = P+R-Q+U

        C = np.vstack((np.hstack((C11, C12)), np.hstack((C21, C22))))
    return C

def winograd_inner(a, b):
    n = np.shape(a)[0]
    if n%2 == 0:
        xi = np.sum(a[::2]*a[1::2])
        etha = np.sum(b[::2]*b[1::2])
        # print("xi = {}, etha = {}".format(xi, etha))
        ab = np.sum((a[::2]+b[1::2])*(a[1::2]+b[::2]))-xi-etha
    else:
        xi = np.sum(a[0:-1:2]*a[1::2])
        etha = np.sum(b[0:-1:2]*b[1::2])
        ab = np.sum((a[0:-1:2]+b[1::2])*(a[1::2]+b[0:-1:2]))-xi-etha+a[-1]*b[-1]
    return ab

def winograd(A, B):
    m,n = np.shape(A)
    n2,p = np.shape(B)
    C = np.zeros((m,p))
    for i in range(np.shape(A)[0]):
        for j in range(np.shape(B)[1]):
            C[i,j] = winograd_inner(A[i,:], B[:,j])
    return C

def winograd2(A, B):
    m,n = np.shape(A)
    n2,p = np.shape(B)
    C = np.zeros((m,p))
    xi = np.zeros((m))
    eta = np.zeros((p))
    ab = 0
    for i in range(m):
        for j in range(n//2):
            xi[i] += A[i,2*j]*A[i,2*j+1]

    for i in range(p):
        for j in range(n//2):
           eta[i] += B[2*j,i]*B[2*j+1,i]

    if n%2==0:
        for i in range(m):
            for j in range(p):
                ab = 0
                for k in range(n//2):
                    ab += (A[i,2*k]+B[2*k+1,j])*(A[i,2*k+1]+B[2*k,j])
                C[i,j] = ab-eta[j]-xi[i]
    else:
        for i in range(m):
            for j in range(p):
                ab = 0
                for k in range(n//2):
                    ab += (A[i,2*k]+B[2*k+1,j])*(A[i,2*k+1]+B[2*k,j])
                C[i,j] = ab-eta[j]-xi[i]+A[i,-1]*B[-1,j]
        
    return C
        
def test_perfomance(n):
    t_mm = []
    t_mm_dc = []
    t_mm_strassen = []
    t_wino = []
    t_np = []

    for i in n:
        A = np.random.randn(i, i)
        B = np.random.randn(i, i)
        # A = np.random.randint(-100, 100,(i, i))
        # B = np.random.randint(-100, 100,(i, i))

        start = time.time()
        C3 = strassen(A, B)
        t_mm_strassen.append(time.time() - start)

        start = time.time()
        C1 = MM(A, B)
        t_mm.append(time.time() - start)

        start = time.time()
        C2 = MM_dc(A, B)
        t_mm_dc.append(time.time() - start)

        start = time.time()
        C4 = winograd2(A, B)
        t_wino.append(time.time() - start)

        start = time.time()
        C = A@B
        t_np.append(time.time() - start)

    plt.figure(figsize=(13,8))
    plt.rcParams['font.family'] = 'STIXGeneral'
    plt.rc('axes', labelsize=23)
    plt.rc('xtick', labelsize=23)
    plt.rc('ytick', labelsize=23)
    plt.plot(n, t_mm, label='Standard', lw=5)
    plt.plot(n, t_mm_dc, label='Divide and conquer', lw=5)
    plt.plot(n, t_mm_strassen, label='Strassen', lw=5)
    plt.plot(n, t_wino, label='Winograd', lw=5)
    plt.plot(n, t_np, label='NumPy A@B', lw=5)
    plt.xscale('log', base=2)
    plt.legend()
    plt.xlabel("n")
    plt.ylabel("time (s)")
    plt.grid(True, which="both", ls="-")
    plt.tight_layout()
    # plt.yscale('log')
    plt.legend(fontsize=19)
    plt.savefig('meas_' + str(max(n))+ '.pdf')
    arr = np.array([n, t_mm, t_mm_dc, t_mm_strassen, t_wino, t_np])
    np.savetxt('meas_' + str(max(n))+ '.txt',arr)    
    return arr


def plot(num):
    arr = np.loadtxt('meas_{}.txt'.format(num))
    n, t_mm, t_mm_dc, t_mm_strassen, t_wino, t_np = arr
    plt.figure(figsize=(13,8))
    plt.rcParams['font.family'] = 'STIXGeneral'
    plt.rc('axes', labelsize=23)
    plt.rc('xtick', labelsize=23)
    plt.rc('ytick', labelsize=23)
    plt.plot(n, t_mm, label='3 For Loops', lw=5)
    plt.plot(n, t_mm_dc, label='Divide and Conquer', lw=5)
    plt.plot(n, t_mm_strassen, label='Strassen', lw=5)
    plt.plot(n, t_wino, label='Winograd', lw=5)
    plt.plot(n, t_np, label='NumPy A@B', lw=5)
    plt.legend()
    plt.xlabel("n")
    plt.ylabel("time (s)")
    plt.grid(True)
    plt.tight_layout()
    # plt.yscale('log')
    plt.legend(fontsize=19)
    plt.savefig('meas_' + str(num)+ '.pdf')    
    return arr

def plot_c_res(ave, num):
    MM = np.loadtxt("meas/MM.txt", delimiter=',')
    # winograd = np.loadtxt("meas/winograd.txt", delimiter=',')
    blas = np.loadtxt("meas/blas.txt", delimiter=',')
    MM_dc = np.loadtxt("meas/MM_dc.txt", delimiter=',')
    strassen = np.loadtxt("meas/strassen.txt", delimiter=',')

    MM_t = MM[:,0] 
    MM_n = MM[:,1] 
    MM_t = np.mean(MM_t.reshape(-1,ave),axis=1)
    MM_n = np.mean(MM_n.reshape(-1,ave),axis=1)

    MM_dc_t = MM_dc[:,0] 
    MM_dc_n = MM_dc[:,1] 
    MM_dc_t = np.mean(MM_dc_t.reshape(-1,ave),axis=1)
    MM_dc_n = np.mean(MM_dc_n.reshape(-1,ave),axis=1)

    strassen_t = strassen[:,0] 
    strassen_n = strassen[:,1] 
    strassen_t = np.mean(strassen_t.reshape(-1,ave),axis=1)
    strassen_n = np.mean(strassen_n.reshape(-1,ave),axis=1)
    
    # winograd_t = winograd[:,0] 
    # winograd_n = winograd[:,1] 
    # winograd_t = np.mean(winograd_t.reshape(-1,ave),axis=1)
    # winograd_n = np.mean(winograd_n.reshape(-1,ave),axis=1)
    
    blas_t = blas[:,0] 
    blas_n = blas[:,1] 
    blas_t = np.mean(blas_t.reshape(-1,ave),axis=1)
    blas_n = np.mean(blas_n.reshape(-1,ave),axis=1)

    def func(x, a,b):
        return b*x**a

    # popt, pcov = curve_fit(func, blas_n, blas_t)
    # popt1, pcov2 = curve_fit(func, blas_n, winograd_t)
    # popt2, pcov2 = curve_fit(func, blas_n, MM_t)

    plt.figure(figsize=(13,8))
    plt.rcParams['font.family'] = 'STIXGeneral'
    plt.rc('axes', labelsize=23)
    plt.rc('xtick', labelsize=23)
    plt.rc('ytick', labelsize=23)
    plt.plot(MM_n, MM_t, label='3 For Loops', lw=5)
    # plt.plot(winograd_n, winograd_t, label='Winograd MM', lw=5)
    plt.plot(blas_n, blas_t, label='Blas', lw=5)
    plt.plot(strassen_n, strassen_t, label='Strassen', lw=5)
    plt.plot(MM_dc_n, MM_dc_t, label='Divide and Conquer', lw=5)
    plt.xlabel("n")
    plt.ylabel("time (s)")
    plt.grid(True)
    plt.tight_layout()
    plt.legend(fontsize=19)
    plt.savefig('c_meas_' + str(num)+ '.pdf')    

    # plt.plot(blas_n, func(blas_n, *popt), 'r-', label='fit blas: a=%5.5f, b=%5.10f' % tuple(popt))
    # plt.plot(blas_n, func(blas_n, *popt1), 'r-', label='fit winograd: a=%5.5f, b=%5.10f' % tuple(popt1))
    # plt.plot(blas_n, func(blas_n, *popt2), 'r-', label='fit MM: a=%5.5f, b=%5.10f' % tuple(popt2))
  
    plt.legend()
    

# test%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if __name__ == '__main__':
    # plot_c_res(1, 4096)

 
    # plot(8)    
    n = np.logspace(1,8,8,base=2,dtype=(np.int))
    # n = np.arange(1,50,2)  
    # A = np.random.randint(-10, 6, (5,3))
    # B = np.random.randint(-10, 6, (3,5))

    # C = winograd2(A, B)
    # C_test = A@B
    # print(C)
    # print(C_test)
    # print(np.equal(C, C_test))

    t_np = test_perfomance(n)
    # C = strassen(A, B)
    # C_test = A@B
    
    
    # plot_c_res()
    # def func(x, a):
    #     return x**a

    # popt, pcov = curve_fit(func, n, t_np, bounds=(2, 3))


    # plt.figure()
    # plt.plot(n, t_np, 'b-', label='data')
    # plt.plot(n, func(n, *popt), 'r-', label='fit: a=%5.3f' % tuple(popt))
    # plt.xlabel('x')
    # plt.ylabel('y')
    # plt.legend()
    