-- 游标：可以使用游标直接操作从数据库读取到内存中的数据，就是发送到客户端之前在内存中预处理一番
-- 显式游标的使用步骤：
-- 1）声明（declare）游标。这将游标初始化到内存中。
-- 2）打开（open）游标。之前声明的游标现在可以被打开，内存被分配。
-- 3）读取（fetch）游标。之前声明和打开的游标现在可以检索数据，这是读取游标的过程。
-- 4）关闭（close）游标。以前声明、打开和读取的游标现在必须被关闭，以释放分配的内存。


declare
  -- 定义游标
  cursor cur_stu is
     select * from student order by student_id;
  -- 定义记录变量，用于记录游标获取的数据，上面游标定义了单行多列的记录
  rv_cur_stu cur_stu%rowtype;
begin
  DBMS_OUTPUT.ENABLE(buffer_size => null);
  open cur_stu; -- 打开游标
  loop
    fetch cur_stu
      into rv_cur_stu; -- 游标循环获取记录，写入自定义的记录变量
  exit when cur_stu%NOTFOUND;
  dbms_output.put_line('学号：' || rv_cur_stu.student_id || ',姓名：' || rv_cur_stu.first_name || rv_cur_stu.last_name);
  end loop;
  close cur_stu; -- 关闭游标
end;
-- ORA-20000: ORU-10027: buffer overflow, limit of 2000 bytes
-- 这是因为在过程中用到了dbms_output.put_line()在服务器端输出信息，而serveroutput的size默认定义为2000bytes。 
-- 修改一下size应该就可以了 
-- set serveroutput on size 30000
-- 或者 在begin后面加上   DBMS_OUTPUT.ENABLE(buffer_size => null); --表示输出buffer不受限制


-- 游标的属性
-- notfound, found, isopen, rowcount(游标读取了多少行)
declare
  cursor cur_stu is
     select * from student order by student_id;
  rv_cur_stu cur_stu%rowtype;
begin
  open cur_stu; -- 打开游标
  loop
    fetch cur_stu
      into rv_cur_stu; 
  exit when cur_stu%notfound;
  dbms_output.put_line('学号：' || rv_cur_stu.student_id || ',姓名：' || rv_cur_stu.first_name || rv_cur_stu.last_name);
  end loop;
  raise_application_error('-20001', 'My exception');
exception
  when others
  then
    dbms_output.put_line('exception');
    if cur_stu%isopen
    then
      close cur_stu;
    end if;

end;


-- 将所有有八名以上学生的课程的注册费用减半
insert into enrollment (student_id, section_id, enroll_date, created_by, created_date, modified_by, modified_date)
values (455, 1, sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into enrollment (student_id, section_id, enroll_date, created_by, created_date, modified_by, modified_date)
values (456, 1, sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into enrollment (student_id, section_id, enroll_date, created_by, created_date, modified_by, modified_date)
values (457, 1, sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into enrollment (student_id, section_id, enroll_date, created_by, created_date, modified_by, modified_date)
values (455, 2, sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into enrollment (student_id, section_id, enroll_date, created_by, created_date, modified_by, modified_date)
values (456, 2, sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into enrollment (student_id, section_id, enroll_date, created_by, created_date, modified_by, modified_date)
values (457, 2, sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into enrollment (student_id, section_id, enroll_date, created_by, created_date, modified_by, modified_date)
values (458, 2, sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into enrollment (student_id, section_id, enroll_date, created_by, created_date, modified_by, modified_date)
values (458, 3, sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into student (student_id, first_name, last_name, registration_date, zip, created_by, created_date, modified_by, modified_date)
values (455, 'zhang', 'san', sysdate, 3002, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into student (student_id, first_name, last_name, registration_date, zip, created_by, created_date, modified_by, modified_date)
values (456, 'li', 'si', sysdate, 3002, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into student (student_id, first_name, last_name, registration_date, zip, created_by, created_date, modified_by, modified_date)
values (457, 'wang', 'wu', sysdate, 3002, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into student (student_id, first_name, last_name, registration_date, zip, created_by, created_date, modified_by, modified_date)
values (458, 'zhang', 'wu', sysdate, 3002, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into section (course_no, section_no, instructor_id, created_by, created_date, modified_by, modified_date)
values (1, 307, 9001, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into section (course_no, section_no, instructor_id, created_by, created_date, modified_by, modified_date)
values (1, 707, 9002, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
insert into section (course_no, section_no, instructor_id, created_by, created_date, modified_by, modified_date)
values (2, 308, 8997, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
update course set cost = 100;
update section set course_no = 10 where section_id = 1;
update section set course_no = 10 where section_id = 1;
update section set course_no = 20 where section_id = 2;
select * from enrollment;
select * from section;
-- 1. 选出大于2名以上学生的课程
select b.course_no
from enrollment a, section b
where a.section_id = b.section_id
group by a.section_id, b.course_no
having count(*) > 2;
-- 2. 更新课程注册费用
update course set cost = cost*0.95;

declare
  cursor cur_update_fee is select b.course_no
      from enrollment a, section b
      where a.section_id = b.section_id
      group by a.section_id, b.course_no
      having count(*) > 2;
begin
  for v_fee in cur_update_fee
  loop
    update course set cost = cost * 0.95 where course_no = v_fee.course_no;
    dbms_output.put_line(v_fee.course_no);
  end loop;
  commit;
end;



