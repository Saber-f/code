from numpy import *

def list_str2num(A):
    i = 0;
    while i < len(A):
        A[i] = eval(A[i])
        i += 1
    return A

def input_A():
    print("Please input A::\n")
    A = []
    while True:
        d = input("  ").split()
        if d == []:
            break;
        A.append(list_str2num(d))
    return mat(A)

def print_mat(A):
    i = 0
    while i < len(A):
        j = 0
        while j < size(A)/len(A):
            print(' %4g'%A[i,j],end = '')
            j += 1
        i += 1
        print()

def elimination(A):
    i = 1
    while i < len(A):
        A[i,:] -= A[i-1,:]*(A[i,i-1]/A[i-1,i-1])
        i += 1
        print()
        print_mat(A)

def main():
    A = input_A()
    print_mat(A)
    elimination(A)
main()
