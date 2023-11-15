import sys
import os

# num1 = 12
# num2 = 12

def add(num1, num2):
    add_res = num1 + num2
    return add_res

def sub(num1, num2):
    sub_res = num1 - num2
    return sub_res

# res = add(2, 5)
res = add(2, 5)
res = sub(2, 5)

num1 = float(sys.argv[1])
operation = sys.argv[2]
num2 = float(sys.argv[3])

# print(num1, num2, operation)

if operation == "add" :
    res = add(num1, num2)
    print(res)
elif operation == "sub" :
    res = sub(num1, num2)
    print(res)

# To get the value of the ENV Variable
print(os.getenv("WSL_DISTRO_NAME"))
