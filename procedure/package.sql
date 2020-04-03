


-- 创建包
-- 1. 创建包头部说明
create or replace package manage_students
as 
  procedure find_sname -- 过程：根据id查询姓名
    (i_student_id in student.student_id%type,
     o_first_name out student.first_name%type,
     o_last_name out student.last_name%type);
  function id_is_good -- 函数：判断输入的id是否合法
    (i_student_id in student.student_id%type)
    return boolean;
end manage_students;

-- 2. 创建包体
create or replace package body manage_students
as
  procedure find_sname -- 过程：根据id查询姓名
    (i_student_id in student.student_id%type,
     o_first_name out student.first_name%type,
     o_last_name out student.last_name%type)
  is
    v_student_id student.student_id%type;
  begin
    select first_name, last_name
    into o_first_name, o_last_name
    from student
    where student_id = i_student_id;
  exception
    when others
      then dbms_output.put_line('Error in finding student_id: ' || v_student_id);
  end find_sname;
  
  function id_is_good -- 函数：判断输入的id是否合法 
    (i_student_id in student.student_id%type)
    return boolean
  is
    v_id_cnt number;
  begin
    select count(*)
    into v_id_cnt
    from student
    where student_id = i_student_id;
    return 1 = v_id_cnt;
  exception
    when others
      then
        return false;
  end id_is_good;

end manage_students;

-- 调用包
set serveroutput on size 3000;
declare
  v_first_name student.first_name%type;
  v_last_name student.last_name%type;
begin
  if manage_students.id_is_good(&&v_id)
    then
      manage_students.find_sname(&&v_id, v_first_name, v_last_name);
      dbms_output.put_line('Student id: ' || &&v_id || ' is ' || v_first_name || v_last_name);
  else
    dbms_output.put_line('Student id: ' || &&v_id || ' is not in the database.');
  end if;
end;





























































