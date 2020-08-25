help()
{
    #TODO: Add help text here
    echo "This script installs Single Node Hadoop/Spark/Kafka/Cassandra/MongoDB cluster on Ubuntu"
    
}

log()
{
	# If you want to enable this logging add a un-comment the line below and add your account key
    	#curl -X POST -H "content-type:text/plain" --data-binary "$(date) | ${HOSTNAME} | $1" https://logs-01.loggly.com/inputs/[account-key]/tag/redis-extension,${HOSTNAME}
	echo "$1"
}

echo "Begin execution of installation script extension on ${HOSTNAME}"

#Check the current user name
USER_NAME=$1

#Check the current directory
unzipped_dir=`pwd`


#!/usr/bin/env bash
# Update the index
sudo apt-get -y update

# Install c libraries 
sudo apt-get -y install build-essential
# Install vi editor
sudo apt-get -y install vim
sudo apt-get -y install tree
sudo apt-get -y install net-tools
sudo apt-get -y install sshpass
sudo apt-get -y install unzip
sudo apt-get -y install python
sudo apt-get -y install python3.6



#ssh-keygen -q -t rsa -P "" -f /home/$USER_NAME/.ssh/id_rsa
#cat /home/$USER_NAME/.ssh/id_rsa.pub >> /home/$USER_NAME/.ssh/authorized_keys
#cat /home/$USER_NAME/.ssh/id_rsa.pub >> /home/$USER_NAME/.ssh/known_hosts

#chmod 0600 /home/$USER_NAME/.ssh/authorized_keys

# Verify ssh

ssh -o StrictHostKeyChecking=no $USER_NAME@localhost 'sleep 5 && exit'
ssh -o StrictHostKeyChecking=no $USER_NAME@0.0.0.0 'sleep 5 && exit'


echo "Installing MySQL Server"
#sudo apt-get remove mysql-server mysql-client 
#sudo apt-get purge mysql-server
#sudo apt autoremove

echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
sudo apt-get -y install mysql-server mysql-client

mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS metastore_db;" 
mysql -uroot -proot -e "CREATE USER 'hiveuser'@'localhost' IDENTIFIED BY 'hivepassword';"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'hiveuser'@'localhost' identified by 'hivepassword';"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'hiveuser'@'%' identified by 'hivepassword';"
mysql -uroot -proot -e "FLUSH PRIVILEGES;"
echo " metastore_db @MySQL server  created"

#Host Name - IP Address resolution
sudo chmod 777 /etc/hosts
cat $unzipped_dir/hosts >/etc/hosts
sudo chmod 644 /etc/hosts

#echo "`hostname -I | awk '{print $2}'`  $HOSTNAME" >>/etc/hosts

# Create directory to store the MongoDB document
sudo mkdir -p /data/db
sudo chmod 777 -R /data
sudo chown -R $USER_NAME:$USER_NAME /data

# Create directory to store the required software
mkdir -p /home/$USER_NAME/bigdata
sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/bigdata
cd /home/$USER_NAME/bigdata


# Create directories for name node and data node
#sudo mkdir -p /app/bigdata
sudo chmod 777 -R /app/
sudo chown -R $USER_NAME:$USER_NAME /app


mkdir -p /app/bigdata/hadoop_tmp/hdfs/namenode
mkdir -p /app/bigdata/hadoop_tmp/hdfs/datanode

# Create directories for spark-events
mkdir -p /app/bigdata/spark-events
mkdir -p /app/bigdata/spark_tmp/spark
#mkdir -p /tmp/spark-events


mkdir -p /app/bigdata/hive_tmp/hive
mkdir -p /app/bigdata/zookeeper

# Setting installation HOME directory - /home/$USER_NAME  ##############################

#cd /app/bigdata

# Download hadoop binaries
echo "Dowloading Hadoop"
wget  -q https://downloads.apache.org/hadoop/common/hadoop-2.9.2/hadoop-2.9.2.tar.gz

# Download Spark pre-built with hadoop 2.7+
echo "Dowloading Spark"
wget  -q https://archive.apache.org/dist/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz

echo "Dowloading SBT"
#wget -q https://github.com/sbt/sbt/releases/download/v1.2.0/sbt-1.2.0.tgz
wget -q https://piccolo.link/sbt-1.2.0.tgz



# Download jdk binaries
echo "Dowloading Java"
wget -q --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz

# Download Scala binaries
echo "Dowloading Scala"
wget -q  https://downloads.lightbend.com/scala/2.12.2/scala-2.12.2.tgz


# Download Hive binaries
echo "Dowloading Hive"
#wget  http://mirrors.estointernet.in/apache/hive/hive-1.2.2/apache-hive-1.2.2-bin.tar.gz
wget -q http://apachemirror.wuchna.com/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz


# Download Pig binaries
echo "Dowloading Pig"
#wget -q http://www-us.apache.org/dist/pig/pig-0.16.0/pig-0.16.0.tar.gz
wget -q http://apachemirror.wuchna.com/pig/pig-0.16.0/pig-0.16.0.tar.gz

# Download Kafka binaries
echo "Dowloading Kafka"
#wget  https://archive.apache.org/dist/kafka/1.1.1/kafka_2.12-1.1.1.tgz
wget -q https://archive.apache.org/dist/kafka/2.4.1/kafka_2.11-2.4.1.tgz

# Download Apache Cassandra
echo "Dowloading Cassandra"
wget -q http://apachemirror.wuchna.com/cassandra/3.0.21/apache-cassandra-3.0.21-bin.tar.gz

# Download MongoDB
echo "Dowloading MongoDB"
wget -q https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-4.0.9.tgz

# Download MySQL JDBC Driver
echo "Dowloading MySQL JDBC Driver"
wget -q https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.47.tar.gz

# Download Sqoop
echo "Dowloading Sqoop"
wget -q http://mirrors.estointernet.in/apache/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz


# Download HBase
echo "Dowloading HBase"
wget -q https://downloads.apache.org/hbase/1.6.0/hbase-1.6.0-bin.tar.gz


echo "Hadoop Extraction Started "
# Extract hadoop binaries
tar -xf hadoop-2.9.2.tar.gz
mv hadoop-2.9.2 hadoop
rm hadoop-2.9.2.tar.gz
echo "Hadoop Extraction Completed "

echo "Spark Extraction Started "
# Extract the Spark  binaries
tar -xf spark-2.4.5-bin-hadoop2.7.tgz
mv spark-2.4.5-bin-hadoop2.7 spark
rm spark-2.4.5-bin-hadoop2.7.tgz
echo "Spark Extraction Completed "

echo "Java Extraction Started "
# Extract java binaries
tar -xf jdk-8u131-linux-x64.tar.gz
mv jdk1.8.0_131 java
rm jdk-8u131-linux-x64.tar.gz
echo "Java Extraction Completed "

echo "Hive Extraction Started "
# Extract Hive binaries
tar -xf apache-hive-2.3.7-bin.tar.gz
mv apache-hive-2.3.7-bin hive
rm  apache-hive-2.3.7-bin.tar.gz
echo "Hive Extraction Completed "

echo "Pig Extraction Started "
# Extract Pig binaries
tar -xf pig-0.16.0.tar.gz
mv pig-0.16.0 pig
rm pig-0.16.0.tar.gz
echo "Pig Extraction Completed "

echo "Scala Extraction Started "
# Extract Scala binaries
 tar -xf scala-2.12.2.tgz
 mv scala-2.12.2 scala
 rm scala-2.12.2.tgz
echo "Scala Extraction Completed "

echo "SBT Extraction Started "
#Extract sbt 
tar -xf sbt-1.2.0.tgz
rm  sbt-1.2.0.tgz
echo "SBT Extraction Completed "

echo "Kafka Extraction Started "
#Extract Kafka 
tar xf kafka_2.11-2.4.1.tgz
mv kafka_2.11-2.4.1 kafka
rm kafka_2.11-2.4.1.tgz
echo "Kafka Extraction Completed "

echo "Cassandra Extraction Started "
#Extract Cassandra 
tar xf apache-cassandra-3.0.21-bin.tar.gz 
mv apache-cassandra-3.0.21 cassandra
rm apache-cassandra-3.0.21-bin.tar.gz
echo "Cassandra Extraction Completed "

echo "MongoDB Extraction Started "
#Extract MongoDB 
tar xf mongodb-linux-x86_64-4.0.9.tgz
mv mongodb-linux-x86_64-4.0.9 mongodb
rm mongodb-linux-x86_64-4.0.9.tgz
echo "MongoDB Extraction Completed "

echo "MySQL JDBC Extraction Started "
#Extract MySQL JDBC Driver 
tar xf mysql-connector-java-5.1.47.tar.gz
mv mysql-connector-java-5.1.47 mysql-connector
rm mysql-connector-java-5.1.47.tar.gz
echo "MySQL JDBC Extraction Completed "

echo "Sqoop Extraction Started "
#Extract Sqoop 
tar xf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
mv sqoop-1.4.7.bin__hadoop-2.6.0 sqoop
rm sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
echo "Sqoop Extraction Completed "

#Extract HBase 
echo "HBase Extraction Started "
tar -xf hbase-1.6.0-bin.tar.gz
mv hbase-1.6.0 hbase
rm hbase-1.6.0-bin.tar.gz
#rm $HOME/bigdata/hbase/lib/slf4j-log4j12-1.7.25.jar 
echo "HBase Extraction Completed "

sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/bigdata

echo "******* Setting Environment Variables *****************"
# set env variables in .bashrc file
echo 'export JAVA_HOME=/home/'$USER_NAME'/bigdata/java' >>/home/$USER_NAME/.bashrc
echo 'export HADOOP_HOME=/home/'$USER_NAME'/bigdata/hadoop' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin' >> /home/$USER_NAME/.bashrc
echo 'export HIVE_HOME=/home/'$USER_NAME'/bigdata/hive' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$HIVE_HOME/bin' >> /home/$USER_NAME/.bashrc
echo 'export PIG_HOME=/home/'$USER_NAME'/bigdata/pig' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$PIG_HOME/bin' >> /home/$USER_NAME/.bashrc

echo 'export SCALA_HOME=/home/'$USER_NAME'/bigdata/scala' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$SCALA_HOME/bin' >> /home/$USER_NAME/.bashrc
echo 'export SPARK_HOME=/home/'$USER_NAME'/bigdata/spark' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin' >> /home/$USER_NAME/.bashrc
echo 'export SBT_HOME=/home/'$USER_NAME'/bigdata/sbt' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$SBT_HOME/bin' >> /home/$USER_NAME/.bashrc
echo 'export KAFKA_HOME=/home/'$USER_NAME'/bigdata/kafka' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$KAFKA_HOME/bin' >> /home/$USER_NAME/.bashrc

echo 'export CASSANDRA_HOME=/home/'$USER_NAME'/bigdata/cassandra' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$CASSANDRA_HOME/bin' >> /home/$USER_NAME/.bashrc

echo 'export MONGODB_HOME=/home/'$USER_NAME'/bigdata/mongodb' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$MONGODB_HOME/bin' >> /home/$USER_NAME/.bashrc

echo 'export SQOOP_HOME=/home/'$USER_NAME'/bigdata/sqoop' >> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$SQOOP_HOME/bin' >> /home/$USER_NAME/.bashrc

# set env variables for Hbase
echo 'export HBASE_HOME=/home/'$USER_NAME'/bigdata/hbase'>> /home/$USER_NAME/.bashrc
echo 'export PATH=$PATH:$HBASE_HOME/bin'>> /home/$USER_NAME/.bashrc
echo 'export PYSPARK_PYTHON=python3.6'>> /home/$USER_NAME/.bashrc

sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.bashrc
source /home/$USER_NAME/.bashrc

echo "******* Setting Environment Variables Done*****************"


echo " ------------- Copy Hadoop configuraton files -----------------"

# Add JAVA_HOME in hadoop-env.sh
echo 'export JAVA_HOME=/home/'$USER_NAME'/bigdata/java' >> /home/$USER_NAME/bigdata/hadoop/etc/hadoop/hadoop-env.sh

# copy hadoop configuraton files from host to the guest VM
#By default, Vagrant will share your project directory (the directory with the Vagrantfile) to /vagrant

# cd $HOME/hadoop_light_cloud

cp $unzipped_dir/core-site.xml /home/$USER_NAME/bigdata/hadoop/etc/hadoop/
cp $unzipped_dir/hdfs-site.xml /home/$USER_NAME/bigdata/hadoop/etc/hadoop/
cp $unzipped_dir/mapred-site.xml /home/$USER_NAME/bigdata/hadoop/etc/hadoop/
cp $unzipped_dir/yarn-site.xml /home/$USER_NAME/bigdata/hadoop/etc/hadoop/
cp $unzipped_dir/masters /home/$USER_NAME/bigdata/hadoop/etc/hadoop/
cp $unzipped_dir/slaves /home/$USER_NAME/bigdata/hadoop/etc/hadoop/

echo " ------------- Copy Hadoop configuraton files Done-----------------"

echo " ------------- Copy Hive configuraton files -----------------"

cp $unzipped_dir/hive-site.xml /home/$USER_NAME/bigdata/hive/conf/
cp $unzipped_dir/hive-env.sh /home/$USER_NAME/bigdata/hive/conf/
cp $unzipped_dir/hive-config.sh /home/$USER_NAME/bigdata/hive/bin/
echo " ------------- Copy Hive configuraton files Done-----------------"

echo " ------------- Copy Spark configuraton files -----------------"

# copy Spark configuraton files from host to the guest VM
cp $unzipped_dir/slaves /home/$USER_NAME/bigdata/spark/conf/
cp $unzipped_dir/spark-env.sh /home/$USER_NAME/bigdata/spark/conf/
cp $unzipped_dir/spark-defaults.conf /home/$USER_NAME/bigdata/spark/conf/
cp $unzipped_dir/hive-site.xml /home/$USER_NAME/bigdata/spark/conf/
echo " ------------- Copy Spark configuraton files Done-----------------"

# copy Hive configuraton file into Sqoop conf directory
cp $unzipped_dir/hive-site.xml /home/$USER_NAME/bigdata/sqoop/conf/

echo " ------------- Copy HBase configuraton files -----------------"
#HBase related configuration file
cp  $unzipped_dir/hbase-site.xml /home/$USER_NAME/bigdata/hbase/conf/
cp  $unzipped_dir/hbase-env.sh /home/$USER_NAME/bigdata/hbase/conf/

# copy regionservers file from host to the guest VM  
#cp /vagrant/config/hbase/regionservers /home/vagrant/bigdata/hbase/conf/
echo 'localhost' >/home/$USER_NAME/bigdata/hbase/conf/regionservers

echo " ------------- Copy HBase configuraton files Done-----------------"

echo " ------------- Copy MySQL JDBC Driver files -----------------"
 
#Copy  MySQL JDBC Driver to Hive Directory
cp /home/$USER_NAME/bigdata/mysql-connector/mysql-connector-java-5.1.47.jar /home/$USER_NAME/bigdata/hive/lib/
cp /home/$USER_NAME/bigdata/mysql-connector/mysql-connector-java-5.1.47.jar /home/$USER_NAME/bigdata/sqoop/lib/
cp /home/$USER_NAME/bigdata/mysql-connector/mysql-connector-java-5.1.47.jar /home/$USER_NAME/bigdata/spark/jars/
cp /home/$USER_NAME/bigdata/mysql-connector/mysql-connector-java-5.1.47.jar /home/$USER_NAME/bigdata/kafka/libs/

#sudo cp $unzipped_dir/my.cnf /etc/mysql/my.cnf	
#sudo cp $unzipped_dir/my.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

#sudo /etc/init.d/mysql restart


echo " ------------- Copy MySQL JDBC Driver files Done-----------------"

#---------------------------------------------------------------------------
# copy dataset files from host to the guest VM   
cp  $unzipped_dir/dataset.zip /home/$USER_NAME/

sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/dataset.zip
#=============================================================================

sudo chown -R $USER_NAME:$USER_NAME /app
sudo chmod 777 -R /app/

sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/bigdata
sudo chmod 777 -R /home/$USER_NAME/bigdata
#==============================================================================

sudo su $USER_NAME
cd ~

rm -f ~/.ssh/id_rsa
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/known_hosts
chmod 0600 ~/.ssh/authorized_keys

ssh -o StrictHostKeyChecking=no $USER_NAME@localhost 'sleep 5 && exit'
ssh -o StrictHostKeyChecking=no $USER_NAME@0.0.0.0 'sleep 5 && exit'
#ssh localhost

#===============================================================
echo " ------------- Starting Hadoop Services -----------------"
# Format namenode
/home/$USER_NAME/bigdata/hadoop/bin/hadoop namenode -format

#---------------------------------------------------------------------

sudo chown -R $USER_NAME:$USER_NAME /app
sudo chmod 777 -R /app/

sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/bigdata
#sudo chmod 777 -R /home/$USER_NAME/bigdata
#---------------------------------------------------------------------


# Start dfs
/home/$USER_NAME/bigdata/hadoop/sbin/start-dfs.sh
#Check if namenode, datanode and secondary namenode has started
/home/$USER_NAME/bigdata/java/bin/jps

# Start yarn
/home/$USER_NAME/bigdata/hadoop/sbin/start-yarn.sh
#Check if resource manager & node manager has started
/home/$USER_NAME/bigdata/java/bin/jps

echo " ------------- Hadoop Services Started-----------------"

#------------------------------------------------------------------------------

# Initialize MySQL for Hive 2
echo "Creating Metastore db for Hive "
/home/$USER_NAME/bigdata/hive/bin/hive --service schemaTool -dbType mysql -initSchema
echo "Metastore db creation for Hive completed "
#--------------------------------------------------------------------

echo " ------------- Starting Spark Services -----------------"

# Start Spark Master
/home/$USER_NAME/bigdata/spark/sbin/start-master.sh
# Start Spark Slaves
/home/$USER_NAME/bigdata/spark/sbin/start-slaves.sh

#Check if Hadoop Services and Spark Services started 
/home/$USER_NAME/bigdata/java/bin/jps

echo " ------------- Spark Services Started-----------------"

echo " ------------- Running Sample MapReduce Job-----------------"
# Create a input directory in HDFS
/home/$USER_NAME/bigdata/hadoop/bin/hdfs dfs -mkdir -p /user/$USER_NAME/wordcount/input

# Copy a local file to the input directory
/home/$USER_NAME/bigdata/hadoop/bin/hdfs dfs -copyFromLocal /home/$USER_NAME/bigdata/hadoop/README.txt /user/$USER_NAME/wordcount/input/

# Verify that the file has been copied
/home/$USER_NAME/bigdata/hadoop/bin/hdfs dfs -cat /user/$USER_NAME/wordcount/input/README.txt

# Run the wordcount example bundled with the hadoop binaries
/home/$USER_NAME/bigdata/hadoop/bin/hadoop jar /home/$USER_NAME/bigdata/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.9.2.jar wordcount wordcount/input wordcount/output

# Verify the output
/home/$USER_NAME/bigdata/hadoop/bin/hdfs dfs -cat /user/$USER_NAME/wordcount/output/part*

#Execute a Spark Example
echo "------------RUNNING SPARK EXAMPLE ------------------------------"
/home/$USER_NAME/bigdata/spark/bin/run-example SparkPi 10

# Check whether the Spark shell is running in local mode
#$HOME/bigdata/spark/bin/spark-shell --master local[*]

# Run Spark shell is running in YARN mode
# $HOME/bigdata/spark/bin/spark-shell --master spark://master:7077

sudo chown -R $USER_NAME:$USER_NAME /app
sudo chmod 777 -R /app/

sudo chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/bigdata

cd /home/$USER_NAME
source /home/$USER_NAME/.bashrc

echo " Your environment is ready"
