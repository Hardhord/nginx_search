#!/bin/bash
temp_file="/tmp/temp_nmap_script.tmp"
temp_file2="/tmp/temp_nmap_script2.tmp"
temp_file3="/tmp/temp_nmap_script3.tmp"

echo "Please enter search network (format 192.168.0.0/24):"
read src_network
nmap -sn $src_network > $temp_file
cat $temp_file | grep -A1 "Host is up" | sed '/Host is up/d' | sed '$d' | cut -b22- | sed 's/([^)]*)//g' > $temp_file2

nmap -p80,443 -sV -iL $temp_file2 > $temp_file3
echo " "
echo "RESULT: NGINX SERVICES FIND ON HOSTS"
echo "-------------------"
cat $temp_file3 | grep "open" -B4 | grep "nginx" -B4 | grep "Nmap" | cut -b 21-
echo "-------------------"
