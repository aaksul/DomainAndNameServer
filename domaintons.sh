#!/bin/bash
#open directory

FINDPATH(){
#!/bin/bash
#Find path of file that contain domains

ARGS=$@

FILE1=$ARGS

FILE_PATH=$( find /home -name $FILE1 | sed '2,$d' | sed 's/.//' )

if [ $FILE_PATH ]
then 

echo  $FILE_PATH 
#return path of file
else 

echo 'file not found'
fi

}


ask_write(){

#this script give ip adrress from domain
TXTFILE=$1
CATEG=$2
FILEDIRECTORY=$(dirname  $TXTFILE)
echo "file is ->>> " $TXTFILE

while read DOMAIN
do
IP=$(dig $DOMAIN +short)

echo "domain->" $DOMAIN

echo "ip->" $IP

NAMESERVER1=$(dig -x "$IP" +answer | grep 'arpa.\ [0-9]' | cut -d'R' -f2 | sed 's/[^a-z.]//g')
#write to document

NAMESERVER=$(echo $NAMESERVER1 | tr ' ' '\n')


	for NS in $NAMESERVER
	do

	echo $DOMAIN ';' "$NS">>$FILEDIRECTORY/answerof"$CATEG".txt  
	done

done<$TXTFILE
}


#!/bin/bash
#open directory


if [ $1 ]
#Check argument
then

FOLDER=$1

ARRAY=$(ls $FOLDER)
#assignment subfolder called categories name of given folder to array 

LIST=$(echo $ARRAY | tr ' ' '\n')
#arrangment array for line by line reading

for CATEGORY in $LIST
#line by line reading list to make process on categories folder orderly  
do

DIRECTORY=$(FINDPATH $CATEGORY'.txt')


echo $DIRECTORY

ask_write /$DIRECTORY $CATEGORY

 
done

else

	echo "Enter File Name"
	exit 0
fi

