//test of ga

import random
import math

hex = 2 # Hexdecimal
pop = 60 # Population
gene_len 50 # The length of the gene

# Fitness function (Evaluation of the pros and cons of genes)
def f(l):
    f = (list2n(l)-hex**(gene_len-1))/10000;
    return f*math.sin(f)
    
# Number conversion list
def n2list(n):
    l = []
    while n > 0:
        l.insert(0, n % hex)
        n //= hex
    return l
# List conversion number
def list2n(l):
    n = 0
    for t in l:
        n *= 10
        n += t
    return n

# Get the initial population
def get_fist():
    l = []
    i = 0 
    while i < pop:
        j = 0
        ll = [];
        while j < gene_len:
            ll.append(random.randint(0,hex-1))
        l.append[ll]
        i += 1
    return l;


