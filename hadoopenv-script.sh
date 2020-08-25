export DEBIAN_FRONTEND=noninteractive
adminuser_name=$1
sudo apt-get install -y update 2>/dev/null
sudo apt-get install -y unzip
##==========================================================================

# Passwordless ssh login for root
echo "# Passwordless ssh login for root-----------"
pwd
cd /root
rm -f /root/.ssh/id_rsa
ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 0600 /root/.ssh/authorized_keys
## ----------------------------------------------
echo 'sleep 2 && exit'|ssh -o StrictHostKeyChecking=no root@localhost /bin/bash
echo 'sleep 2 && exit'|ssh -o StrictHostKeyChecking=no root@0.0.0.0 /bin/bash

#--------------------------------------------------

# Creating Installation directory 
echo "------------------- # Creating Installation directory  ------------------------"
sudo mkdir -p /app/bigdata
sudo chown -R $adminuser_name:$adminuser_name /app

wget https://github.com/rajuchal/multiuser_env_template/archive/master.zip
unzip master.zip
cd multiuser_env_template-master/

echo "------------------- # Starting Installation  ------------------------"
sh install-common.sh $adminuser_name


#ssh -o StrictHostKeyChecking=no -T $adminuser_name@localhost 'sleep 2 && exit'
#ssh -o StrictHostKeyChecking=no -T $adminuser_name@0.0.0.0 'sleep 2 && exit'
