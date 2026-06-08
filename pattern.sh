#!/bin/bash

echo ============================
echo Pattern Types:
echo 1. Pyramid
echo 2. Diamond
echo ============================
echo ""
#read -p "Enter pattern type(1,2): " type
#read -p "Enter the height: " height

type=2 

for height in {5..8} 
do
    if [[ type -eq 1 ]];
    then
        echo Pyramid $height*
        for (( i=0; i<=height; i++ )) do 
            for (( j=0; j<=$((height+i)); j++ )) do 
                if [[ j -ge $((height-i)) && j -le $((height+i)) ]];
                then 
                    printf "* "
                else
                    printf "  "
                fi
            done
            echo
        done 
    elif [[ type -eq 2 ]]; 
    then
        echo Diamond $height*
        ach=height/2
        if [[ $((height%2)) -eq 0 ]];
        then
            ach=$((ach-1))
        fi
        for (( i=0; i<=ach; i++ )) do 
            for (( j=0; j<=$((ach+i)); j++ )) do 
                if [[ j -ge $((ach-i)) && j -le $((ach+i)) ]];
                then 
                    printf "* "
                else
                    printf "  "
                fi
            done
            echo
        done
        for (( i=0; i<=ach; i++ )) do 
            for (( j=0; j<height-i; j++ )) do  
                if [[ j -gt i && j -lt $((height-i-1)) ]];
                then 
                    printf "* "
                else
                    printf "  "
                fi
            done
            echo
        done
    else
        echo Invalid choice
    fi
done