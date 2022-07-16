--drop database Task_1
create database tt

--Student table 
create table student(
student_id int not null primary key, 
student_name varchar(20));


--Corses table
create table subjects (
subject_id int,
subject_name varchar(20),
PRIMARY KEY (subject_id));

insert into subjects (subject_id , subject_name) values (1,'arabic'), (2,'english'), (3,'math'), (4,'science'), (5, 'History'), (6, 'relegon')

--evaluation table 
create table grades (
s_id int ,
sub_id int, 
grade int,
PRIMARY KEY (s_id , sub_id ),
FOREIGN KEY (s_id) REFERENCES student (student_id),
FOREIGN KEY (sub_id) REFERENCES subjects (subject_id)
);


select s.student_id, s.student_name, AVG(grades.grade) as Student_average, 
status = case (select count(grades.grade)
from student as s
    INNER JOIN grades 
	ON s.student_id = grades.s_id
	group by grades.s_id ,s.student_id, s.student_name
	order by Student_average desc
    


--second query to find the first 3 highest avg from pass students 
select top 3 s.student_id, s.student_name, AVG(grades.grade) as Student_average, 
status = case  (select count(grades.grade) from grades where grades.grade < 50 and s.student_id = grades.s_id )
from student as s
    INNER JOIN grades  
	on s.student_id = grades.s_id
	group by grades.s_id ,s.student_id, s.student_name
	having (select count(grades.grade) 
			from grades where grades.grade < 50 and s.student_id = grades.s_id ) = 0
	order by Student_average desc