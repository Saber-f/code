# -*- coding: utf-8 -*-
import sys
if __name__=="__main__":
        infile = sys.argv[1]
        outfile = sys.argv[2]
        fin = open(infile, 'r')
        fout = open(outfile, 'w')
        a = fin.readline().strip()
        b = fin.readline().strip()
        c = float(a)+float(b)
        fout.write('%f' % c)
        fout.close()
        fin.close()