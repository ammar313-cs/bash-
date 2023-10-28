#!/bin/bash
 
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
 
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
 

echo "IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config
echo "IdentitiesOnly yes" >> ~/.ssh/config
 

sudo service ssh restart
 

if sudo service ssh status | grep "active (running)"; then
   
    ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa localhost "mkdir -p ~/test_directory && echo 'I am doing the task2.' > ~/test_directory/filecreatedinnoninteractivemode.txt"
 
    echo "SSH Configuration and tasks have been completed successfully."
else
    echo "SSH service is not running. Please check the SSH configuration."
fi