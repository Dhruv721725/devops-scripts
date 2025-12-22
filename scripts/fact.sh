#!/bin/bash

read -p "Enter number:" num
res=1
i=2
while ((i<=num))
do
	((res*=i))
	((i++))
done

echo "factorial of $num = $res"

