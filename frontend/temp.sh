#!/bin/bash

python3 fake.py

if [ $? -ne 0 ]; then 
  # The command failed, print an error message 
  echo "The command failed with exit status $?" 
  # Exit the script with a non-zero exit status to indicate failure 
  exit 1 
else 
  # The command was successful, print a success message 
  echo "The command succeeded with exit status $?" 
fi 

nginx -g daemon off
python3 app.py