declare -a arr1=(0 1 2 3 4 5 6 7 8 9)
#to read the cipher and word file from the user
read -r -p "Enter your cipher text file:" cipher
read -r -p "Enter your word file:" words

while read x;
do
    for y in "${arr1[@]}";
    do 
        join=$x$y 
        echo $join
        size=${#join}
        if [ "$size" -lt 16 ]; 
        then 
            echo $join
            openssl enc -aes-128-cbc -d -in $cipher -out plain.txt -k $join
            plain=plain.txt
            if cat $plain|grep -f $words ;
            #if grep -w  $plain $words ;
            then
                echo "The plain text is:" 
                cat $plain
                echo "The key is:$join"
                exit
            fi
        fi
    done
done <$words