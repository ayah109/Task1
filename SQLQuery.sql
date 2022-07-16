

--Student table 
create table student(
student_id int not null primary key, 
student_name varchar(20));
insert into student (student_id, student_name) values (1,'Aya'), (2,'Taleb'), (3, 'Ahmad'), (4, 'Weam'), (5, 'Siham'), (6, 'Israa')select * from student;

--Corses table
create table subjects (
subject_id int,
subject_name varchar(20),
PRIMARY KEY (subject_id));

insert into subjects (subject_id , subject_name) values (1,'arabic'), (2,'english'), (3,'math'), (4,'science'), (5, 'History'), (6, 'relegon')select * from subjects;

--evaluation table 
create table grades (
s_id int ,
sub_id int, 
grade int,
PRIMARY KEY (s_id , sub_id ),
FOREIGN KEY (s_id) REFERENCES student (student_id),
FOREIGN KEY (sub_id) REFERENCES subjects (subject_id)
);select * from grades;insert into grades (s_id, sub_id, grade) values (3,2,65), (4,5,85), (3,1,96),(2,4,83), (1,3,70),(4,5,88),						(2,1,40), (5,2,45), (3,3,90),(5,4,87), (3,5,44),(4,6,79),(1,7,83),(2,8,95),(3,9,77),(2,10,50)						

--first query to find the avareg of each student and the statuse (pass, fail, incomplete)
select s.student_id, s.student_name, AVG(grades.grade) as Student_average, 
status = case (select count(grades.grade)					from grades where grades.grade < 50 and s.student_id = grades.s_id )          when 0  then 'pass'            when 1  then 'incomplete' 		  when 2  then 'incomplete'           else         'fail'        end
from student as s
    INNER JOIN grades 
	ON s.student_id = grades.s_id
	group by grades.s_id ,s.student_id, s.student_name
	order by Student_average desc
    


--second query to find the first 3 highest avg from pass students 
select top 3 s.student_id, s.student_name, AVG(grades.grade) as Student_average, 
status = case  (select count(grades.grade) from grades where grades.grade < 50 and s.student_id = grades.s_id )         when  0  then 'pass'            when 1  then 'incomplete' 		  when 2  then 'incomplete'           else         'fail'         end
from student as s
    INNER JOIN grades  
	on s.student_id = grades.s_id
	group by grades.s_id ,s.student_id, s.student_name
	having (select count(grades.grade) 
			from grades where grades.grade < 50 and s.student_id = grades.s_id ) = 0
	order by Student_average desc
