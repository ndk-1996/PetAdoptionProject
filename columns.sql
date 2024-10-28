
table breed 
+-------------------+--------------+------+-----+---------+-------+
| Field             | Type         | Null | Key | Default | Extra |
+-------------------+--------------+------+-----+---------+-------+
| breedname         | varchar(200) | NO   | PRI | NULL    |       |
| breedcost         | bigint(20)   | YES  |     | NULL    |       |
| breedgender       | varchar(20)  | NO   |     | NULL    |       |
| country_of_origin | varchar(200) | YES  |     | NULL    |       |
+-------------------+--------------+------+-----+---------+-------+


table user
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| userid     | varchar(100) | NO   | PRI | NULL    |       |
| name       | varchar(100) | NO   |     | NULL    |       |
| userpasswd | varchar(100) | NO   |     | NULL    |       |
| address    | varchar(200) | NO   |     | NULL    |       |
| pnumber    | bigint(20)   | YES  |     | NULL    |       |
| gender     | varchar(20)  | NO   |     | NULL    |       |
| doj        | date         | NO   |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+



table vet
+---------+--------------+------+-----+---------+-------+
| Field   | Type         | Null | Key | Default | Extra |
+---------+--------------+------+-----+---------+-------+
| vetid   | varchar(100) | NO   | PRI | NULL    |       |
| name    | varchar(100) | NO   |     | NULL    |       |
| address | varchar(200) | NO   |     | NULL    |       |
| pnumber | bigint(20)   | YES  |     | NULL    |       |
| gender  | varchar(20)  | NO   |     | NULL    |       |
| npets   | bigint(20)   | YES  |     | NULL    |       |
+---------+--------------+------+-----+---------+-------+


table shelter
+-------------+--------------+------+-----+---------+-------+
| Field       | Type         | Null | Key | Default | Extra |
+-------------+--------------+------+-----+---------+-------+
| shelterid   | varchar(100) | NO   | PRI | NULL    |       |
| sheltername | varchar(100) | NO   |     | NULL    |       |
| address     | varchar(200) | NO   |     | NULL    |       |
| pnumber     | bigint(20)   | YES  |     | NULL    |       |
| npets       | bigint(20)   | YES  |     | NULL    |       |
+-------------+--------------+------+-----+---------+-------+


table pet
+------------------------+--------------+------+-----+---------+-------+
| Field                  | Type         | Null | Key | Default | Extra |
+------------------------+--------------+------+-----+---------+-------+
| petid                  | varchar(100) | NO   | PRI | NULL    |       |
| petname                | varchar(100) | YES  |     | NULL    |       |
| pettype                | char(1)      | NO   |     | NULL    |       |
| gender                 | varchar(100) | NO   |     | NULL    |       |
| userid                 | varchar(100) | YES  | MUL | NULL    |       |
| vetid                  | varchar(100) | YES  | MUL | NULL    |       |
| breedname              | varchar(200) | NO   | MUL | NULL    |       |
| shelterid              | varchar(100) | NO   | MUL | NULL    |       |
| pet_adopted_or_donated | char(1)      | YES  |     | NULL    |       |
| doa_or_d               | date         | YES  |     | NULL    |       |
| imgsource              | varchar(200) | YES  |     | NULL    |       |
| height                 | bigint(20)   | YES  |     | NULL    |       |
| weight                 | bigint(20)   | YES  |     | NULL    |       |
+------------------------+--------------+------+-----+---------+-------+


table staff
+----------+--------------+------+-----+---------+-------+
| Field    | Type         | Null | Key | Default | Extra |
+----------+--------------+------+-----+---------+-------+
| suserid  | varchar(100) | NO   | PRI | NULL    |       |
| spasswd  | varchar(100) | NO   |     | NULL    |       |
| sname    | varchar(100) | NO   |     | NULL    |       |
| spnumber | bigint(20)   | YES  |     | NULL    |       |
| saddress | varchar(200) | NO   |     | NULL    |       |
| sgender  | varchar(10)  | NO   |     | NULL    |       |
+----------+--------------+------+-----+---------+-------+





