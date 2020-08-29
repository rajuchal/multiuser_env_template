##  Azure Resource Manager(ARM) Template & Automation Script for Multi-user environment
###  Single Node _Hadoop/Spark/HBase/Kafka/Cassandra/MongoDB_ Cluster with Windows VM Gateway

Template & Automation Script for creating single node _hadoop/spark/kafka/cassanda/mongodb_ cluster in Azure

### Note :- To run this script you should have proper Rights & Permissions to create resources in Azure 

## Connection architecture

**Client Desktop/Laptop --> RDP Connection --> Azure Windows VM --> SSH Connection --> Azure Linux VM**

## Functions of the template & script -
1. Create single instance Windows VM for Client log-in using RDP connection
2. Download SSH clients into Windows VM
3. Create single instance Linux VM for Client log-in using SSH connection from Windows VM
4. Install Hadoop stack, Spark, Kafka, Cassandra, MongoDB into Linux VM

## Installation Guide

1. Open Azure Portal   [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/)

2. Open Power Shell in Aazure Portal
3. Download the Power shell script 

    #### wget https://raw.githubusercontent.com/rajuchal/multiuser_env_template/master/template-script/create-multiuser-env.ps1

4. Download the ARM template file & template parameter file

    #### wget  https://raw.githubusercontent.com/rajuchal/multiuser_env_template/master/template-script/multiuser-multinsg-template.json
    
    #### wget https://raw.githubusercontent.com/rajuchal/multiuser_env_template/master/template-script/multiuser.parameters.json
    #### dir

    ##### Check the template file "multiuser-multinsg-template.json" location
    ##### Check the parameter file "multiuser.parameters.json" location

5. Run the Power shell script

    ##### PS/home/USER_NAME>./create-multiuser-env.ps1
    
    *Example*
        Enter the same project name: lkm_dna_env
        Enter the full path of template file location: ./multiuser-multinsg-template.json
        Enter the full path of parameter file location: multiuser.parameters.json
        Enter the number of Users: 3
        
6. After script execution completed, Connect Windows VM using RDP
7. Check the location "C:\windowsTools" for Windows Tools (SSH Clients & Browser)
   - Unzip MobaXTerm or SmarTTY
   - Connect with Linux VM using SSH connection
   - IP Address for Linux VM - 10.1.2.4
   - Use same User Name & Password of Windows for Linux VM Log-in 

8. Start Hadoop Services in Linux VM
    ##### $ start-dfs.sh
    ##### $ start-yarn.sh

9. Start Spark Services in Linux VM
    ##### $ start-master.sh
    ##### $ start-slaves.sh

10. Start Spark(Scala/Java) Shell  in Linux VM

    ##### $ spark-shell --master spark://localhost:7077

11. Start Spark(Python) Shell  in Linux VM

    ##### $ pyspark --master spark://localhost:7077

12. Start Hive  in Linux VM

    ##### $ hive


:+1: **_Happy Clustering in Azure_** :shipit:
