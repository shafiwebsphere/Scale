CREATE DATABASE global;
use global;
CREATE TABLE ec2_launch_data (
    id int AUTO_INCREMENT,
    Instance_id varchar(255),
    Internal_ip varchar(255),
    launch_time  datetime,
    PRIMARY KEY (id)
);
