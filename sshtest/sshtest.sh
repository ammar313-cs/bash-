#!/bin/bash


github_username="your own username"
github_repo="your-repo name"


ssh_key_path="~/.ssh/id_rsa"


ssh_key_passphrase=""


ssh-keygen -t rsa -C "your_email@example.com should be given here "


ssh-add $ssh_key_path


ssh_config="Host github.com
    HostName github.com
    User git
    IdentityFile $ssh_key_path"

echo "$ssh_config" > ~/.ssh/config


pub_key=$(cat $ssh_key_path.pub)

curl -u "$github_username" -H "Content-Type: application/json" -X POST -d "{\"title\":\"SSH Key\",\"key\":\"$pub_key\"}" https://api.github.com/user/keys


git remote set-url origin "git@github.com:$github_username/$github_repo.git"


echo "SSH key generation and setup for GitHub completed!"
