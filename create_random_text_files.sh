#!/bin/bash

#RandomString(): Used to name the directories/files. 
#In the script we have a global array, containing all digits,
#capital and lower-case letters of the english alphabet.
#So this function, randomly picks a size for the name, 
#and then randomly picks this many values from the global array for the actual name of file.
function RandomString()
{
	#Random bytes(1-8)
    r=$[RANDOM%8+1]
    for ((i=0;i<$r;i++))
    do
		#code to choose a random position in global string a
        size=${#a} # size of string a
        char_index=$[RANDOM%size + 1] # random index in this string 
        name+=${a:char_index:1} #add this to the string to be returned
    done
}

#RandomData(): Created a random string of size between 1kb and 128kb, 
#again, using random values from the array descripted above.
function RandomData()
{
    r=$[RANDOM%128+1] # random amount of kb's (1-128)
    for ((i=0;i<$r*1024;i++))
    do
        size=${#a} # size of string a
        char_index=$[RANDOM%size + 1] # random index in this string 
        data+=${a:char_index:1} #add this to the string to be returned
    done
}

#Files_in_Directories(): This is a recursive function 
#that in a round-robin manner distributes files 
#in the sub-directories of a folder provided.
function Files_in_Directories()
{
    file_counter=$3
    #for every sub-directory of the folder 
    for x in  `find $2 -type d`;
    do
        name=''
        RandomString
		#we create a file with a random name
        let file_counter=file_counter+1
        name=''
        RandomString
        data=''
        #and data are written in it data, using the RandomData function explained above
        RandomData
        echo $data > ${x}/$name
		#if the files needed were created, the function returns
        if [ $file_counter -ge $1 ]; then
            break
        fi
    done
	#if there are still files to be made, the function is called recursivly
    if [ $file_counter -lt $1 ]; then
        Files_in_Directories $1 $2 $file_counter
    fi
}

##-------MAIN PART OF THE SCRIPT-------##

#checking if all arguments were provided
if [ "$#" -ne 4 ]; then
    echo Wrong amount of arguments
    exit 1
fi

#checking if the last three arguments are numbers

#A regular expression for positive integers
re='^[0-9]+$'
if ! [[ $2 =~ $re ]]; then
    echo Wrong format of argument 2
    exit 1
fi
if ! [[ $3 =~ $re ]]; then
    echo Wrong format of argument 3
    exit 1
fi
if ! [[ $4 =~ $re ]]; then
    echo Wrong format of argument 4
    exit 1
fi

#If the dir_name does not exist, we create it, or else we print a message.
if [ -e $1 ];
    then echo Already exists
else
    mkdir $1
fi

#We create the sting a, to containing containing 
#all digits, capital and lower-case letters of the english alphabet
a=' '
for x in {{a..z},{A..Z},{0..9}};
do
    a+="$x"
done


num_of_files=$2

#j is a counter for the amount of directories created
j=0
#While we have not make all the directories needed
while [ $j -lt $3 ]
do
		#dir is the name of the "parent" directory 
        dir="$1"
		#while we have not reached the levels needed and there are 
		#still directories to be made
        for ((k=0;k<$4 && j<$3;k++))
        do
			#we produce a random name
            name=''
            RandomString
            #we concatenate the name to path
            dir+='/'$name
			#and we create the directory
            mkdir $dir
            let j=j+1
        done
done
let counter=0;

#We call Files_in_Directories function passing the number of files needed and the 
#name of the "parent path". We also pass a counter, that keeps track of the number of files
#created. This is useful, as the function is recursive.
Files_in_Directories $2 $1 $counter