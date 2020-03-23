-- 异常
declare
  v_course_no number := &sv_course_no;
  v_description varchar2(50) := 'No decriptions';
begin
  select description
  into v_description
  from course
  where course_no = v_course_no;
  dbms_output.put_line (v_description);
exception
  when NO_DATA_FOUND  -- Oracle定义的异常编码
    then
      dbms_output.put_line ('Course not found.');
  when TOO_MANY_ROWS
    then
      dbms_output.put_line ('Two many course.');
  when OTHERS
    then
      dbms_output.put_line ('Please input another one course no.');
end;

-- 用户自定义异常
declare 
  v_course_no number := &sv_course_no;
  v_description varchar2(50) := 'No decriptions';
  e_my_neg_num_exception exception; -- 用户自定义异常声明
begin
  if v_course_no < 0
    then
      raise e_my_neg_num_exception; -- 抛出一个异常
  end if;
  select description
  into v_description
  from course
  where course_no = v_course_no;
  dbms_output.put_line (v_description);
exception
  when e_my_neg_num_exception
    then 
      dbms_output.put_line ('Input course no cannot be negative.');
end;


-- 异常传播
-- 异常发生在声明部分或者异常处理部分时，新的异常会向外层抛出，如果外层没有处理该异常的代码，则继续向外层抛，直至主机环境捕获并报错
declare 
  e_my_exception1 exception; -- 用户自定义异常声明
  e_my_exception2 exception; -- 用户自定义异常声明
begin
  begin
    raise e_my_exception1;
    raise e_my_exception2;
  exception
    when e_my_exception1
      then 
        dbms_output.put_line ('Caught my exception: type1');
    when e_my_exception2
      then
        dbms_output.put_line ('Caught my exception: type2');
    raise e_my_exception2;
  end;
exception 
  when e_my_exception2
    then
      dbms_output.put_line ('Outline has caught my exception: type2');
end;


-- raise_application_error
declare 
  v_course_no number := &sv_course_no;
  v_description varchar2(50) := 'No decriptions';
  e_my_neg_num_exception exception; -- 用户自定义异常声明
begin
  if v_course_no < 0
    then
      raise_application_error('-20001', 'Cannot be a negative number.'); -- 告诉异常捕获程序异常码是什么，错误描述什么
  end if;
  select description
  into v_description
  from course
  where course_no = v_course_no;
  dbms_output.put_line (v_description);
end;


-- exception_init
declare 
  v_course_no number := &sv_course_no;
  v_description varchar2(50) := 'No decriptions';
  e_my_neg_num_exception exception; -- 用户自定义异常声明
  pragma exception_init(e_my_neg_num_exception, -20001);
begin
  if v_course_no < 0
    then
      raise e_my_neg_num_exception; -- 告诉异常捕获程序异常码是什么，错误描述什么
  end if;
  select description
  into v_description
  from course
  where course_no = v_course_no;
  dbms_output.put_line (v_description);
exception
  when e_my_neg_num_exception
    then
    dbms_output.put_line ('Outline has caught my exception: type2');
end;


