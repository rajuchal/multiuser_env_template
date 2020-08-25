#  Azure Resource Manager(ARM) Template & Automation Script for 
#  Single Node Hadoop/Spark/Kafka/Cassandra Cluster with Windows VM Gateway
Template & Automation Script for creating single node hadoop/spark/kafka/cassanda/mongodb cluster in Azure

# Installation Guide

DOWNLOAD THE POWER SHELL SCRIPT
-------------------------------

PS /home/USER_NAME/testscript> wget https://raw.githubusercontent.com/rajuchal/cloud_env_template/master/create-single-env.ps1

DOWNLOAD THE ARM TEMPLATE FILE
-------------------------------
PS /home/USER_NAME/testscript> wget  https://raw.githubusercontent.com/rajuchal/cloud_env_template/master/single-env-template.json

PS /home/USER_NAME/testscript> dir


Directory: /home/USER_NAME/testscript

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-----           8/24/2020 11:56 AM          82309 create-single-env.ps1
-----           8/24/2020 11:57 AM         312983 single-env-template.json


Template Location - /home/USER_NAME/testscript/single-env-template.json


RUN THE SCRIPT
--------------------

PS /home/<USER NAME>/testscript> ./create-single-env.ps1

Enter the same project name: lkm_dna_env
Enter the administrator User name: azureuser
Enter the administrator password: *************
Enter the full path of template file location: /home/<USER NAME>/testscript/single-env-template.json

Check the location for Windows Tools (SSH Clients & Browser)
------------------------------------------------------------
C:\windowsTools

Unzip MobaXTerm or SmarTTY
Connect with Linux VM using SSH connection
IP Address for Linux VM - 10.1.2.4
Use same User Name & Password of Windows for Linux VM Log-in 

Start Hadoop Services in Linux VM
----------------------------------
$ start-dfs.sh
$ start-yarn.sh

Start Spark Services in Linux VM
----------------------------------
$ start-master.sh
$ start-slaves.sh

Start Spark(Scala/Java) Shell  in Linux VM
--------------------------------------------
$ spark-shell --master spark://localhost:7077

Start Spark(Python) Shell  in Linux VM
------------------------------------------
$ pyspark --master spark://localhost:7077

Start Hive  in Linux VM
----------------------------------------------
$ hive


# Happy Clustering


