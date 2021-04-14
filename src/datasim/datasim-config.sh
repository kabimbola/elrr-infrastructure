#!/bin/bash

cd ../../../ >> /home/ubuntu/startlog.txt
pwd >> /home/ubuntu/startlog.txt
echo "run install script 1" >> /home/ubuntu/startlog.txt
curl -O https://download.clojure.org/install/linux-install-1.10.1.754.sh
sudo chmod +x linux-install-1.10.1.754.sh
sudo ./linux-install-1.10.1.754.sh >> /home/ubuntu/startlog.txt
echo "sleeping..." >> /home/ubuntu/startlog.txt
sleep 20
#git clone https://github.com/nvm-sh/nvm.git ~/.nvm >> /home/ubuntu/startlog.txt
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh -o install_nvm.sh
echo "run install script 2" >> /home/ubuntu/startlog.txt
sudo chmod +x install_nvm.sh >> /home/ubuntu/startlog.txt
echo "changed mod" >> /home/ubuntu/startlog.txt
. ./install_nvm.sh >> /home/ubuntu/startlog.txt
echo "sleeping..." >> /home/ubuntu/startlog.txt
sleep 20
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
echo "downloaded nvm binaries" >> /home/ubuntu/startlog.txt
source ~/.bashrc >> /home/ubuntu/startlog.txt
#for pid in `lslocks -rn | grep /var/lib/dpkg/lock|awk '{print $2}'`;
#do
#    sudo kill $pid;
#done
echo "installing nvm" >> /home/ubuntu/startlog.txt
nvm install 14.15.1 >> /home/ubuntu/startlog.txt
echo "nvm installed" >> /home/ubuntu/startlog.txt
nvm use 14.15.1 >> /home/ubuntu/startlog.txt
echo "installing git make and wrap..." >> /home/ubuntu/startlog.txt
#sudo apt install git make rlwrap -y >> /home/ubuntu/startlog.txt
#sudo apt install make -y >> /home/ubuntu/startlog.txt
#install rlwrap -y >> /home/ubuntu/startlog.txt
echo "git make and rlwrap installed" >> /home/ubuntu/startlog.txt

#echo "cloning ELRR Repo..." >> /home/ubuntu/startlog.txt
#git clone https://github.com/US-ELRR/Misc.git >> /home/ubuntu/startlog.txt
echo "Cloning DATASIM repo..." >> /home/ubuntu/startlog.txt
git clone https://github.com/yetanalytics/datasim.git >> /home/ubuntu/startlog.txt
cd datasim/
touch .lein-env && echo "{:credentials generic:generic }" > .lein-env
echo "cloned DATASIM repo. Added credential file" >> /home/ubuntu/startlog.txt
cd ..
echo "cloning DATASIM-UI repo..." >> /home/ubuntu/startlog.txt
git clone https://github.com/yetanalytics/datasim-ui.git >> /home/ubuntu/startlog.txt
echo "cloned DATASIM-UI repo" >> /home/ubuntu/startlog.txt

echo "Updating DATASIM/DATASIM-UI config with Public" >> /home/ubuntu/startlog.txt
export PUBLIC_DNS=`curl http://169.254.169.254/latest/meta-data/public-hostname 2>/dev/null`
sudo sed -i 's/localhost/'$PUBLIC_DNS'/g' /home/datasim/code/datasim-ui/dev.cljs.edn
sudo sed -i 's/localhost/'$PUBLIC_DNS'/g' /home/datasim/code/datasim/src/server/com/yetanalytics/datasim/server.clj
echo "Creating DATASIM bundle..." >> /home/ubuntu/startlog.txt
#sudo chmod 777 -R datasim/ >> /home/ubuntu/startlog.txt
#sudo chmod 777 -R datasim-ui/ >> /home/ubuntu/startlog.txt
cd datasim/
make clean >> /home/ubuntu/startlog.txt
make bundle >> /home/ubuntu/startlog.txt
echo "Created DATASIM bundle. Launching DATASIM API server..." >> /home/ubuntu/startlog.txt
screen -dm -S "DATASIM" make server
sleep 60
echo "DATASIM API server launched." >> /home/ubuntu/startlog.txt
cd ../datasim-ui/
echo "Launching DATASIM-UI FIG..." >> /home/ubuntu/startlog.txt
make clean >> /home/ubuntu/startlog.txt
screen -dm -S "DATASIM-UI-FIG" make fig
sleep 30
echo "DATASIM-UI FIG launched. Launching DATASIM-UI SASS server..." >> /home/ubuntu/startlog.txt
screen -dm -S "DATASIM-UI-SASS" make build-sass
#sleep 60
echo "DATASIM-UI SASS server launched." >> /home/ubuntu/startlog.txt
