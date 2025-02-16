#!/bin/bash
echo "START"
echo "Сьогодні: $(date)" >> LOG.txt

IFS=$'\n'  
list="list.txt"

echo "Перевірка доступності сайтів із списку..." >> LOG.txt

while read -r line; do
    
    echo "Перевіряємо: $line"  

    
    for protocol in "http://" "https://"; do
        url="${protocol}${line}"
             
        response=$(curl -Is --connect-timeout 5 "$url" | head -n 1)

        if echo "$response" | grep -E "(200|301|302)" >> /dev/null; then
            echo "$url is UP" >> LOG.txt
        else
            echo "$url is DOWN or RESPONSE (answer from: $response)" >> LOG.txt
        fi
    done
done < "$list"

echo "Finish" >> LOG.txt
echo "FINISH"