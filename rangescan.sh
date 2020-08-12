#!/bin/bash

# automated nmap scanner

# $FILE=/home/leviticus/scriptresults.sh
# $TEST="$(test $FILE)"

# if [ $TEST == true ];
# then
#  rm scriptresultsopen.sh 2>/dev/null
#  rm scriptresultsclose.sh 2>/dev/null
#  rm scriptresults.sh 2>/dev/null
# else

$IPRange=/home/leviticus/dictionary2.txt

echo $IPRange

echo "Please input an IP address: "
read FirstIP  # takes user input and stores in enviroment variable

if [ $FirstIP == 127.0.0.1 ];
then
  echo "Cannot scan network, try again: "  # gives error if local loopback input in variable
  read FirstIP
fi  # ends if statement

echo "Please input last octet of IP range: "
read LastOctet

echo "Please input port to scan: "
read Port


echo " "  # space for legibility

nmap -sT -A $FirstIP-$LastOctet -p $Port >/dev/null -oG scriptresults.sh  # nmap scan putting output into grepable file

# export FailScan=$(echo scriptresults.sh)

# if [ "$FailScan" == "*Failed*" ];
# then
 # echo "Cannot scan host"
# fi
# above comment kept for potential future usage

echo "Closed ports:"  # legibility

cat scriptresults.sh | grep closed > scriptresultsclose.sh  # filters closed ports into new file
cat scriptresults.sh | grep filtered >> scriptresultsclose.sh # filters filtered ports and appends previous file
cat scriptresultsclose.sh # outputs file contents
cat scriptresults.sh | grep open > scriptresultsopen.sh  # filters open ports into new file
# cat scriptresults.sh | grep $FirstIP.* > scriptresultsIP.sh

# export WhoIP=$(echo scriptresultsIP.sh | grep $FirstIP.*)

# echo " "

# whois $WhoIP

echo " "

export OpenPort=$(echo scriptresultsopen.sh)  # create enviroment variable for following if statement

if [ $OpenPort = *open* ];  # asking if variable contains string 'open'
then
  echo "Open ports:"
  cat scriptresultsopen.sh  # output file contents if variable contains string 'open'
else
  echo "No open ports"
fi

echo " "

if [ $OpenPort = *22* ];
then
  echo "Do you have a username to connect to?"
  read UserAns
  if [ $UserAns = yes ];
  then
    echo "Please input username to connect to:  "
    read SSHUser
    echo "Please input IP to connect to: "
    read SSHIP
    echo " "
    ssh SSHUser@SSHIP
  else
    echo "You cannot connect to SSH" 
   fi
fi
# fi
