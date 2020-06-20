#!/bin/bash


clean_line() { printf "\r"; }

# define usage function
usage(){
	echo "Usage: $0 type file_to_read hash"
	echo ""
	echo "Options:"
	echo " -1 for md5 hashes "
	echo " -2 for sha1 hashes "
	echo " -3 for sha224 hashes "
	echo " -4 for sha256 hashes "
	echo " -5 for sha384 hashes "
	echo " -6 for sha512 hashes "

	echo ""
	echo "Exapmples:"
	echo "Example: ./cracker.sh -1 list 725fda58c5d23e684545878a8fdca9e6"
	echo "Example: ./cracker.sh -2 list 22e080e638de902b544ea9a7283e258d3fd182a2"
}

crackeracki(){
	echo "	#####################################"
	echo "	#                                   #"
	echo "	#                                   #"
	echo "	#      `tput bold` Byte the cracker            #"
	echo "	#                                   #"
	echo "	#                                   #"
	echo "	###                                 #"
	echo "	   ####                             #"
	echo "    	        ###                         #"
	echo "      	           ## #######################"
}

banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}

# Input file
input_file=$2

# The provided hash
hash_to_crack=$3

# invoke  usage
# call usage() function if filename not supplied
if [ "$#" -ne 3 ] ; then 
		usage
		exit 2
	fi
crackeracki
banner "Start cracking....Fasten your seatbelts"
#read -s -N 1 key &
start=$(date | awk '{print $4}')
size=$(wc -l $input_file | awk '{print $1}')
echo "File provided has "$size "lines"
counter=0
while getopts "1:2:3:4:5:6:" option; do
	case ${option} in
		1 )
		while read line;do
			(( counter++ ))
			echo -ne "Percentage:" $(( ($counter *100 ) / $size))"%" && clean_line
			echo -n "$line" | md5sum | cut -d ' ' -f1 | grep $hash_to_crack  && echo "Cracked hash:"`tput bold`$line && echo "Found in $counter line" && banner "Finished" && exit 1
		done < $input_file
		;;
		2 )
		while read line;do 
			echo -n "$line" | sha1sum | cut -d ' ' -f1  | grep $hash_to_crack && echo "Cracked hash:"`tput bold`$line && banner "Finished" && exit 1
		done < $input_file
		;;
		3 )
		while read line;do 
			echo -n "$line" | sha224sum | cut -d ' ' -f1  | grep $hash_to_crack && echo "Cracked hash:"`tput bold`$line && banner "Finished" && exit 1
		done < $input_file
		;;
		4 )
		while read line;do 
			echo -n "$line" | sha256sum | cut -d ' ' -f1  | grep $hash_to_crack && echo "Cracked hash:"`tput bold`$line && banner "Finished" && exit 1
		done < $input_file
		;;
		5 )
		while read line;do 
			echo -n "$line" | sha384sum | cut -d ' ' -f1  | grep $hash_to_crack && echo "Cracked hash:"`tput bold`$line && banner "Finished" && exit 1
		done < $input_file
		;;
		6 )
		while read line;do 
			echo -n "$line" | sha512sum | cut -d ' ' -f1  | grep $hash_to_crack && echo "Cracked hash:"`tput bold`$line && banner "Finished" && exit 1
		done < $input_file
		;;
		* ) usage
			exit 1
	esac
done
