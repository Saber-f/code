n = int(input("How many primes do you want ?  "))
i = 5;j = 7;
while n > 0:
    if i % 3 != 0:
        print(i)
        i += 6
        n -= 1
        if n <= 0:
            break;
    if j % 3 != 0:
        print(j)
        j += 6
        n -= 1
        if n <= 0:
            break;
    
    
