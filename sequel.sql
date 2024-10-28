 create table user
    -> (
    -> userid varchar(100) primary key,
    -> name varchar(100) not null,
    -> userpasswd varchar(100) not null,
    -> address varchar(200) not null,
    -> pnumber bigint,
    -> usertype char(1) not null,
    -> gender varchar(20) not null,
    -> doj date not null
    -> );

 create table vet
    -> (
    -> vetid varchar(100) primary key,
    -> name varchar(100) not null,
    -> address varchar(200) not null,
    -> pnumber bigint,
    -> gender varchar(20) not null,
    -> npets bigint,
    -> );

create table breed
    -> (
    -> breedname varchar(200) primary key,
    -> breedgender varchar(20) not null,
    -> breedcost bigint
    -> );

create table shelter
    -> (
    -> shelterid varchar(100) primary key,
    -> sheltername varchar(100) not null,
    -> address varchar(200) not null,
    -> pnumber bigint,
    -> npets bigint
    -> );

create table pet
    -> (
    -> petid varchar(100) primary key,
    -> petname varchar(100),
    -> pettype char(1) not null,
    -> gender varchar(100) not null,
    -> country_of_origin varchar(100),
    -> adopted_by varchar(100),
    -> donated_by varchar(100),
    -> vetid varchar(100),
    -> breedname varchar(200) not null,
    -> shelterid varchar(100) not null,
    -> pet_adopted_or_donated char(1),
    -> doa_or_d date,
    -> foreign key (adopted_by) references user (userid) on delete cascade,
    -> foreign key (donated_by) references user (userid) on delete cascade,
    -> foreign key (vetid) references vet (vetid) on delete cascade,
    -> foreign key (breedname) references breed (breedname) on delete cascade,
    -> foreign key (shelterid) references shelter (shelterid) on delete cascade
    -> );

create table staff
    -> (
    -> suserid varchar(100) primary key,
    -> spasswd varchar(100) not null,
    -> sname varchar(100) not null,
    -> spnumber bigint,
    -> saddress varchar(200) not null,
    -> sgender varchar(10) not null
    -> );





