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

def LU(A):



def main():
    A = input_A()


main()
