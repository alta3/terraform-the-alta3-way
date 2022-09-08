#!/bin/bash

### Cleanup old containers
sudo docker stop bender fry zoidberg farnsworth indy &> /dev/null
sudo docker rm bender fry zoidberg farnsworth indy &> /dev/null
sudo docker network rm ansible-net &> /dev/null
rm /tmp/labrunning &> /dev/null
echo -e "Containers Cleared!\n"

echo -e "Assembling Planet Express team...\n"

### Create networks
sudo docker network create --opt com.docker.network.driver.mtu=1450 --subnet 10.10.2.0/24 ansible-net

FILE_PATH=$HOME/.config/dockerfiles/ansible

sudo docker image load -i $FILE_PATH/ssh-bender.tar
sudo docker image load -i $FILE_PATH/ssh-fry.tar
sudo docker image load -i $FILE_PATH/ssh-zoidberg.tar

### Launch containers and connect networks
sudo docker run -d  --name bender      -h bender     --ip 10.10.2.3 --network ansible-net ssh-bender
sudo docker run -d  --name fry         -h fry        --ip 10.10.2.4 --network ansible-net ssh-fry
sudo docker run -d  --name zoidberg    -h zoidberg   --ip 10.10.2.5 --network ansible-net ssh-zoidberg

echo -e "\nGOOD NEWS, EVERYONE! Complete!\n"

sudo apt install sshpass -y

echo -e ".ansible.cfg Updated (/home/student/.ansible.cfg)"
curl https://static.alta3.com/projects/ansible/deploy/ansiblecfg --create-dirs -o ~/.ansible.cfg

echo -e "Inventory File Updated (/ans/inv/dev/hosts)"
curl https://static.alta3.com/projects/ansible/deploy/hosts --create-dirs -o ~/ans/inv/dev/hosts

echo -e "Nethosts Inventory File Updated (/ans/inv/dev/nethosts)"
curl https://static.alta3.com/projects/ansible/deploy/nethosts --create-dirs -o ~/ans/inv/dev/nethosts

curl https://static.alta3.com/projects/ansible/deploy/pubkeymover --create-dirs -o ~/pubkeymover.yml
ansible-playbook ~/pubkeymover.yml -i ~/ans/inv/dev/hosts
