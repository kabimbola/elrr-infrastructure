#!/bin/bash

cd ../../../ >> /home/ubuntu/datasimlog.txt # navigating out of the `elrr-infrastructure` repo
pwd >> /home/ubuntu/datasimlog.txt
echo "run install script 1" >> /home/ubuntu/datasimlog.txt
sudo curl -O https://download.clojure.org/install/linux-install-1.10.1.754.sh
sudo chmod +x linux-install-1.10.1.754.sh
sudo ./linux-install-1.10.1.754.sh >> /home/ubuntu/datasimlog.txt
echo "sleeping..." >> /home/ubuntu/datasimlog.txt
sleep 15
sudo curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh -o install_nvm.sh
echo "run install script 2" >> /home/ubuntu/datasimlog.txt
sudo chmod +x install_nvm.sh >> /home/ubuntu/datasimlog.txt
echo "changed mod" >> /home/ubuntu/datasimlog.txt
. ./install_nvm.sh >> /home/ubuntu/datasimlog.txt
echo "sleeping..." >> /home/ubuntu/datasimlog.txt
sleep 20
# Must run the three lines below to make nvm within the path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
echo "downloaded nvm binaries" >> /home/ubuntu/datasimlog.txt
source ~/.bashrc >> /home/ubuntu/datasimlog.txt
echo "installing nvm" >> /home/ubuntu/datasimlog.txt
nvm install 14.15.1 >> /home/ubuntu/datasimlog.txt
echo "nvm installed" >> /home/ubuntu/datasimlog.txt
nvm use 14.15.1 >> /home/ubuntu/datasimlog.txt

# set-up for DATASIM CLI / UI components
echo "Cloning DATASIM repo..." >> /home/ubuntu/datasimlog.txt
sudo git clone https://github.com/yetanalytics/datasim.git >> /home/ubuntu/datasimlog.txt
sudo chown -R ubuntu:ubuntu datasim/
cd datasim/
touch .lein-env && echo "{:credentials generic:generic }" > .lein-env ## UPDATE CREDENTIALS IF REQUIRED
echo "cloned DATASIM repo. Added credential file" >> /home/ubuntu/datasimlog.txt
cd ..
echo "cloning DATASIM-UI repo..." >> /home/ubuntu/datasimlog.txt
sudo git clone https://github.com/yetanalytics/datasim-ui.git >> /home/ubuntu/datasimlog.txt
sudo chown -R ubuntu:ubuntu datasim-ui/
echo "cloned DATASIM-UI repo" >> /home/ubuntu/datasimlog.txt

# Dynamically pulling the DNS for the EC2 instance and updating DATASIM config
echo "Updating DATASIM/DATASIM-UI config with Public IP" >> /home/ubuntu/datasimlog.txt
export PUBLIC_DNS=`curl http://169.254.169.254/latest/meta-data/public-hostname 2>/dev/null`
sudo sed -i 's/localhost/'$PUBLIC_DNS'/g' /home/datasim/code/datasim-ui/dev.cljs.edn
sudo sed -i 's/localhost/'$PUBLIC_DNS'/g' /home/datasim/code/datasim/src/server/com/yetanalytics/datasim/server.clj
echo "Creating DATASIM bundle..." >> /home/ubuntu/datasimlog.txt
cd datasim/
make clean >> /home/ubuntu/datasimlog.txt
make bundle >> /home/ubuntu/datasimlog.txt
echo "Created DATASIM bundle. Launching DATASIM API server..." >> /home/ubuntu/datasimlog.txt
screen -dm -S "DATASIM" make server # opening a separate shell for the DATASIM API server
sleep 60
echo "DATASIM API server launched." >> /home/ubuntu/datasimlog.txt
cd ../datasim-ui/
echo "Launching DATASIM-UI FIG..." >> /home/ubuntu/datasimlog.txt
make clean >> /home/ubuntu/datasimlog.txt
screen -dm -S "DATASIM-UI-FIG" make fig # opening a separate shell for the DATASIM UI
sleep 30
echo "DATASIM-UI FIG launched. Launching DATASIM-UI SASS server..." >> /home/ubuntu/datasimlog.txt
screen -dm -S "DATASIM-UI-SASS" make build-sass
echo "DATASIM-UI SASS server launched." >> /home/ubuntu/datasimlog.txt
