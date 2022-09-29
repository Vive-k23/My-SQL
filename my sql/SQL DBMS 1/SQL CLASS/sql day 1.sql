create table student
(id int,
f_name varchar(15),
l_name varchar(15),
score float,
email varchar(15)
);
desc student;
alter table student add contact_no int;
alter table student drop contact_no;
alter table student add contact_no int after l_name;
alter table student modify score int;
alter table student change score scores float;
alter table student rename column  scores to mark;