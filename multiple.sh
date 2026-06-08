#!/bin/bash

read -p "Enter num: " num

for ((i=1; i<=10; i++)) do
    echo $num x $i$'\t' = $((i*num))
done

read -p "Enter power: " power
res=1
j=1
while [[ j -le power ]] do
    res=$((num*res))
    ((j++))
done
echo "result $num^$power: $res"