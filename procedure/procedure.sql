
  -- 过程语法
  create or replace procedure discount as
  cursor c_group_discount is
    select distinct s.course_no, c.description
      from section s, enrollment e, course c
     where s.section_id = e.section_id
       and c.course_no = s.course_no
     group by s.course_no, c.description, e.section_id, s.section_id
    having count(*) >= 1;
begin
  for r_group_discount in c_group_discount loop
    update course
       set cost = cost * .95
     where course_no = r_group_discount.course_no;
    dbms_output.put_line('A 5% discount has been given to ' ||
                         r_group_discount.course_no || ' ' ||
                         r_group_discount.description);
  end loop;
end;

-- 输入输出参数
  create or replace procedure print_student(p_stu_id in varchar2, o_name out varchar2) as
begin
  dbms_output.put_line('input parameters: ' || p_stu_id); 
  select a.first_name || a.last_name 
  into o_name 
  from student a 
  where a.student_id = p_stu_id; 
  dbms_output.put_line('output parameters: ' || o_name);
end;
/
-- 执行
declare
  v_student_name student.first_name%type;
begin
  print_student('20112004', v_student_name);
  dbms_output.put_line('output parameters: ' || v_student_name);
end;
/



-- 函数
-- 函数和过程非常相似，也是存储代码
-- 两者最大的区别是，函数的返回值只有一个
-- 而且，函数必须有一个return语句
-- 另外，函数不能单独执行，必须再某些上下文中使用，即不是程序执行入口
create or replace function get_course_desc
(
  v_course_no in course.course_no%type
)
return varchar2
as
  v_description varchar2(50);
begin
  select c.description into v_description
  from course c
  where c.course_no = v_course_no;
  return v_description;
exception
  when no_data_found
    then
      return('no data found.');
  when others
    then
      return ('exception');
end;
/
-- 使用函数
declare
  v_description varchar2(50);
begin
  v_description := get_course_desc(20);
  dbms_output.put_line(v_description);
end;
/

-- 使用函数2
variable v_description varchar2(50)
execute :v_description := get_course_desc(20) -- 不用分号

-- 使用函数3
variable v_description varchar2(50)
call get_course_desc(20) into v_description -- 不用分号

-- 使用函数4
select get_course_desc(20) from dual;

-- 使用函数5
dbms_output.put_line(get_course_desc(20));






















































