# Globalscale

1. Database creation 

mysqldb.tf

In this file 4 resources will get created
  a.Database creation
  b.Database security group and rules to allow 3306 port 
  c.Database and table creation , used null block for this
  d.Datasource resource for encrypting database password 

Steps for encryption of the database password 
        i. Make directory -  mkdir secrets

        ii. Create rds.json file under the created folder
        echo "{ \"password\": \"global123\" }" >> secrets/rds.json

        iii.include the below datasource in the database tf file 
        data "external" "rds" {
        program  = [ "cat", ".secrets/rds.json"]
        }

        resource "aws_db_instance" "default" {
        password   = "${data.external.rds.result.password}"
        }

        iv. Execute the below command in unix and give password 
        gpg -o secrets/rds.json.gpg \
        --batch \
        --symmetric \
        --openpgp \
        --cipher-algo AES256 \
        --s2k-cipher-algo AES256 \
        --s2k-digest-algo SHA512 \
        --s2k-mode 3 \
        --s2k-count 65011712 \
        --armor \
        --emit-version \
        secrets/rds.json
	  
        v. Encrypted password as below
	  cat secrets/rds.json.gpg
        -----BEGIN PGP MESSAGE-----
        Version: GnuPG/MacGPG2 v2

        jA0ECQMKrGbmVhBpU7L/0lkBkpKcI8nXpiWDGKV7qdBDOt2Gb4qGvCu9aUkYdhcH
        cwRsCBFyqDQRIfQSTmc1NFfr/3HJyADQKOBoftnCC1TGYYOL7AhexGhl0NaemqH8
        zl1GOz3b1QHETg==
        =Gyon
        -----END PGP MESSAGE-----
2.S3.tf
   Bucket resource will get create and file  /root/production/table.sql  will get upload in the bucket
   This file has insert statement to insert data in the database

3.autoscaling.tf
    This file have 3 resources
    
    a.launch_configuration
    b.autoscaling_group
    c.aws_security_group 
    
      In launch configuration execute_db.sh  file included as user_data , in this script it will extract date , instance_id and private ip address
      second thing, it will copy a file from S3 bucket ,this file has insert statement  and values get replaced in the statement , and this values will get updated             in the table
      
 Iamroles.tf
 
       To attach S3 readonly access to autoscaling , there are 4 resources availble in the file
       i. IAM_instance_profile
       ii.Role
       iii.policy
       iv.policy attachement
