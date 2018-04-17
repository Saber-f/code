from numpy import *

def list_str2num(A):
    i = 0
    while i < len(A):
        A[i] = float(A[i])
        i += 1
    return A

def input_A():
    print("Please input A::\n")
    A = []
    while True:
        d = input("  ").split()
        if d == []:
            break
        A.append(list_str2num(d))
    return mat(A)

def copy_mat(A):
    A_c = zeros_like(A)
    i = 0
    while i < len(A):
        j = 0
        while j < size(A)/len(A):
            A_c[i,j] = A[i,j] 
            j += 1
        i += 1
    return A_c   

def LU(A):
    L = eye(len(A))
    U = copy_mat(A)
    i = 1
    while i < len(A):
        j = i
        while j < len(A):
            n1 = U[j,i-1]/U[i-1,i-1]
            U[j,:] -= U[i-1,:]*n1
            L[j,i-1] = n1
            j += 1
        i += 1
    return (L,U)

def print_mat(A):
    i = 0
    while i < len(A):
        j = 0
        while j < size(A)/len(A):
            print(' %4.2g'%A[i,j],end = '')
            j += 1
        i += 1
        print()

def main():
    A = input_A()
    (L,U) = LU(A)
    print_mat(A);print()    
    print_mat(L);print()    
    print_mat(U);print()
    print_mat(L*U);print()
      
main()
