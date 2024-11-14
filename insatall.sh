#!/bin/bash
#
export NEWT_COLORS='
window=,blue
border=white,blue
textbox=white,black
button=black,green'


#================================================================================
#                 functions Menu 

menuMain ()
{
  OPT_Main=$(whiptail --title 'Что сделать?' --menu 'Выберете опцию' 15 60 5 \
  'Init'        'Начальная инициализация' \
  'Settings'       'Настройка программ' 3>&1 1>&2 2>&3)
  exitstatus=$?

  if [ $exitstatus = 0 ]; then
    echo 'Выбрана опция: '$OPT_Main
  else
    echo 'Exit'
  fi

}

menuInstall ()
{
  echo 'Insatll menu'

  OPT_Install=$(whiptail --title 'Что установить?' --checklist 'Выберите что установить' 15 60 4 \
  'env'       'Окружение'       ON \
  'Progs'     'Любимые проги'   ON  3>&1 1>&2 2>&3)
  
  exitstatus=$?
    if [ $exitstatus = 0 ]; then
      echo 'Ваш ответ' $OPT_Install
    else
      echo 'Exit'
    fi
}

menuENV ()
{
  echo 'ENV menu'
  OPT_ENV=$(whiptail --title 'ENV' --checklist 'Настраиваем окружение' 15 60 4 \
  'Alias'         'Мои алиасы'                ON \
  'NiceBash'     'красивая оболочка bash'    ON  3>&1 1>&2 2>&3)
  
  exitstatus=$?
    if [ $exitstatus = 0 ]; then
      echo 'Ваш ответ' $OPT_ENV
    else
    echo 'Exit'
    fi
}

menuProg ()
{
  echo 'Progs menu'
  OPT_Progs=$(whiptail --title 'Progs' --checklist 'Выбираем проги' 20 60 15 \
  'NetTools'         'Инструменты для работы с net'        ON \
  'Htop'              'Информативная утилита по процессам'  ON \
  'Bottom'            'Типо диспетчер задач'                ON \
  'sd'                'Человеческая поиск / замена'         ON \
  'Bat'               'Замена cat'                         ON \
  'LazyVim'          'Мощный тесктовый редактор'           ON \
  'LazyGit'          'Консольный вывод git'                OFF \
  'Fail2Ban'          'Защита ssh от брутфорс'              OFF \
  'Docker'            '+ docker-compose'                     OFF \
  'Zabbix'            'Zabbix agent 2'                      OFF \
  'PSQL'              'Postgresql'                          OFF \
  'SQL'               'My SQL'                              OFF \
  'Watch'             'Запуск команды подряд'               OFF \
  'Watchman'          'Отслеживание изменений в файлах'     OFF \
  'TermShark'         'Почти WireShark' OFF 3>&1 1>&2 2>&3 )
  
  exitstatus=$?
  if [ $exitstatus = 0 ]; then
    echo 'Ваш ответ' $OPT_Progs
  else
    echo 'Exit'
  fi
}


#================================================================================
#установки программ


  #if [ $exitstatus = 0 ]; then
  #if [[ '${ANS_ENV[@]}' =~ 'Alias' ]]; then; setAlias; fi
  #if [[ '${ANS_ENV[@]}' =~ 'Nice bash' ]]; then; setNiceBash; fi




#================================================================================

#================================================================================
#                   functions install anyware


setAlias ()
{
sudo apt install wget -y
wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/ELL-sey/my_start_work/refs/heads/main/aliases.txt
cat aliases.txt >>  ~/.bashrc
rm aliases.txt
# закоментировать предустановленный ll 
}

setInit ()
{
sudo localectl set-locale LANG=ru_RU.UTF-8
sudo timedatectl set-timezone Asia/Novosibirsk
}

setNiceBash ()
{
  curl -sS https://starship.rs/install.sh | sh
  eval "$(starship init bash)"
}

getBat ()
{
  sudo apt install bat -y
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat ~/.local/bin/bat
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
  echo "alias cat=batcat" >>  ~/.bashrc
}

getDocker ()
{
  sudo apt update > /dev/null
  sudo apt install curl software-properties-common ca-certificates apt-transport-https -y
  wget -O- https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor | sudo tee /etc/apt/keyrings/docker.gpg > /dev/null
  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable"| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt update > /dev/null
  sudo apt install docker-ce -y
  sudo apt-get install docker-compose -y
  sudo usermod -aG docker $USER
}

getFail2Ban ()
{
  sudo apt install fail2ban -y
}

getBottom ()
{
  curl -LO https://github.com/ClementTsang/bottom/releases/download/0.10.2/bottom_0.10.2-1_amd64.deb
  sudo dpkg -i bottom_0.10.2-1_amd64.deb
  echo "alias dz=bottom" >>  ~/.bashrc
  echo "alias btm=bottom" >>  ~/.bashrc
}


getHtop ()
{
  sudo apt install htop -y
}

getLazyGit ()
{
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
echo "alias lg=lazygit" >>  ~/.bashrc
echo "alias nano=nvim" >>  ~/.bashrc
}

getLazyVim ()
{
sudo apt-get update && sudo apt-get install git neovim build-essential -y 
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
echo "alias vi=nvim" >>  ~/.bashrc
echo "alias vim=nvim" >>  ~/.bashrc
}

getPSQL ()
{
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt update
  apt -y install postgresql
}

getSQL ()
{
 echo "install SQL"
}

getNetTools ()
{
 sudo apt install net-tools -y
}

getsd ()
{
 sudo apt install sd -y
}

getZabbix ()
{
  echo 'setZabbixAgent2'
}

getGit ()
{
  sudo apt install git -y
}

getWatch ()
{
  echo "in watch"
}

getWatchman ()
{
  echo "in wat men"
}

getTermShark ()
{
  sudo apt install termshark -y
}

#================================ Сама программа  ================================================

wget -q --tries=2 --timeout=3 --spider http://google.com
if [[ !  $? -eq 0 ]]; then
  echo "Network Error"
  exit 1
fi

menuMain
cd

if [ $OPT_Main = 'Init'  ]; then
  setInit
  exit 0
fi

if [ $OPT_Main = 'Settings'  ]; then
  menuInstall
fi

if  [[ " ${OPT_Install[*]} " =~ 'env' ]]; then 
  menuENV
fi

if  [[ " ${OPT_Install[*]} " =~ 'Progs' ]]; then
  menuProg
fi





for i in $OPT_Progs
do
b=${i%\"} ; c=${b#\"} 
"get$c"
#command
done

for i in $OPT_ENV
do
b=${i%\"} ; c=${b#\"} ; command="set$c"
command
done
