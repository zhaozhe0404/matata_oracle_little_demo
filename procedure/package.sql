


-- ������
-- 1. ������ͷ��˵��
create or replace package manage_students
as 
  procedure find_sname -- ���̣�����id��ѯ����
    (i_student_id in student.student_id%type,
     o_first_name out student.first_name%type,
     o_last_name out student.last_name%type);
  function id_is_good -- �������ж������id�Ƿ�Ϸ�
    (i_student_id in student.student_id%type)
    return boolean;
end manage_students;

-- 2. ��������
create or replace package body manage_students
as
  procedure find_sname -- ���̣�����id��ѯ����
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
  
  function id_is_good -- �������ж������id�Ƿ�Ϸ� 
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

-- ���ð�
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





























































