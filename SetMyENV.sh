#!/bin/bash

cd 

echo "Проверим интернет соединение"
wget -q --tries=2 --timeout=3 --spider http://google.com
if [[ ! $? -eq 0 ]]; 
then
  echo "Error: Чето не то с инетом"
  exit 1
fi



echo "Поменять локаль на Русский?"
read user_answ

if [[ $user_answ  == y* ]];
then
  sudo localectl set-locale LANG=ru_RU.UTF-8
fi

sudo timedatectl set-timezone Asia/Novosibirsk
sudo apt install vim neovim curl git net-tools htop


echo "Lazy Vim нужен?"
read user_answ

if [[ $user_answ  == y* ]];
then
sudo apt-get update && sudo apt-get install build-essential 
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
fi


# install ALIASES
wget https://github.com/ELL-sey/my_start_work/blob/main/aliases.txt 
cat aliases.txt >>  ~/.bashrc
rm aliases.txt


# ШтInstall progs


echo "Нужо установить че нить?"
read user_answ

if [[ ! $user_answ  == y* ]];
then
  exit 0
fi



echo "Нужен Fail2ban?"
read user_answ

if [[ $user_answ  == y* ]];
then
  sudo apt install fail2ban -y
#vim /etc/fail2ban/jail.conf


fi
echo "Нужен docker?"
read user_answ

if [[ $user_answ  == y* ]];
then
  sudo apt update > /dev/null
  sudo apt install curl software-properties-common ca-certificates apt-transport-https -y
  wget -O- https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null
  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable"| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update > /dev/null
  sudo apt install docker-ce -y
  sudo apt-get install docker-compose
  sudo usermod -aG docker $USER
fi


# Postgresql
# python
# zabbix agent

