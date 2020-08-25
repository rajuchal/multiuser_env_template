echo "#---------- Post installation configuration started --------------# "
rm -rf $HOME/.ssh
mkdir $HOME/.ssh
ssh-keygen -q -t rsa -N '' -f $HOME/.ssh/id_rsa && cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys
ssh -o StrictHostKeyChecking=no $USER@localhost 'sleep 2 && exit'
ssh -o StrictHostKeyChecking=no $USER@0.0.0.0 'sleep 2 && exit'
start-dfs.sh
start-yarn.sh
hdfs dfs -mkdir -p /user/$USER

echo "#------------- Post installation configuration completed ----------------------# "