# 纺射加密

# 加密函数
def encryption(m,key):
    c = '';
    for ch in m:
        c = c + chr(((ord(ch)-ord('a')) * key[0] + key[1]) % 26 + ord('a'))
    return c

# 求取逆元
def git_inverse_element(a):
    n = 1
    while a * n % 26 != 1:
        n += 1
    return n

# 解密函数
def decryption(c,key):
    m = '';
    n = git_inverse_element(key[0])
    for ch in c:
        m = m + chr((ord(ch) - ord('a') - key[1]) * n % 26 + ord('a'))
    return m

# 判断两个数是否互素
def is_coprime(a,b):
    if a < b:
        rema = b % a
    else:
        rema = a % b
        a = b
    if rema == 0:
        return False
    elif rema == 1:
        return True
    else:
        return is_coprime(a,rema)
# 判断密钥是否合法
def is_right_key(key):
    if len(key) == 2 and is_coprime(key[0],26):
        return True
    return False

m = input('请输入明文::')

while True:
    key = input('请输入纺射加密密钥::').split()
    key[0] = int(key[0])
    key[1] = int(key[1])
    if is_right_key(key):
        break

c = encryption(m,key) #得到密文
del m
del key

# 根据用户输入密钥将密文转换为'明文'
while True:
    key = input('请输入解密密钥::').split()
    if len(key) == 0:
        break
    key[0] = int(key[0])
    key[1] = int(key[1])
    m = decryption(c,key)
    print('明文为::',m)
