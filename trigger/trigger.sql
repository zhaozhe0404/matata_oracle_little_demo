-- 1. trigger是什么
-- 一种pl/sql块，当某种事件触发时隐式执行这个pl/sql块。那哪些事件触发时会执行呢？
-- DML语句：insert update delete三种
-- DDL语句：create alter
-- 系统事件：如启动或关闭数据库，做日志记录
-- 用户事件：如注销或者登录

-- 当trigger被DML/DDL语句块触发时，trigger中所有操作都会和刚才的语句块一起成为事务的一部分
-- 所以当DML/DDL被回滚时，trigger中的所有操作被回滚
-- 比如我现在有个update语句，
update course set cost = cost*0.95 where course_no = '10';
-- 同时，有个trigger，update时触发，用于记录update语句插入的时间
create or replace trigger course_audit 
  after update or delete on course;
begin
  insert into audit_trail (table_name, operation_type, operation_user);
end;

-- 2. 当update语句发生异常回滚，audit_trail表也回滚，
-- 这不是我们想看到的，日志表应该记录这个update语句所做的操作，即使失败了
-- 我们说trigger中的子事务受父事务影响回滚了，
-- 如何避免呢？
-- 使用自治事务
create or replace trigger course_audit 
  after update or delete on course;
  pragma autonomous_transaction; -- 编译指示，表示trigger中是自治事务
begin
  insert into audit_trail (table_name, operation_type, operation_user);
  commit; -- 增加事务提交
end;


-- 3. 行触发器 
-- DML/DDL执行多少行，就触发多少次
create or replace trigger row_trigger_student
  before insert or delete on student
  for each row
declare
  v_student_name char(50);
begin
  v_student_name := 
  case
    when inserting then 'insert a student ' || :NEW.first_name || :NEW.last_name
    when deleting then 'delete a student ' || :OLD.first_name || :OLD.last_name
  end;
  dbms_output.put_line(v_student_name);
  
end;
insert into student(student_id, salutation, first_name, last_name, zip, phone, employer, registration_date, created_date, created_by, modified_date, modified_by)
values (211101, 'sir', 'zhao', 'zhe', '4001', '13222', 'pingan', sysdate, sysdate, 'zhaozhe', sysdate, 'zhaozhe');
delete from student where student_id = '211101';


-- 4. 语句触发器
-- 完成一次事务触发一次
-- 下面例子：只允许在每月10日允许学生注册课程
create or replace trigger enroll_limit
  before insert on enrollment -- 注意：语句级触发器没有for each row，什么都没有
declare
  v_day varchar2(20);
begin
  select to_char(sysdate, 'dd') into v_day from dual;
  if trim(v_day)<>'10'
    then
      raise_application_error('-20001', 'Cannot enrolling');
  end if;
end;
insert into enrollment (student_id, section_id, enroll_date, created_date, created_by, modified_date, modified_by)
values ('1', '10', sysdate, sysdate, 'zhaozhe', sysdate, 'zhaozhe');


-- 5. instead of触发器
-- 插入视图的条件:  
-- 1.如果视图是基于一个基础表产生的,那么这就称为非连接视图,所有的非连接视图都是可以更新的,也就是说可以在该视图上进行
--   INSERT,UPDATE,DELETE的操作.  
-- 2.如果是连接视图,那就要遵守基本更新准则了.
--   现在我只对INSERT准则做一下说明:在INSERT语句中不能显式或隐式的引用到任何非码保留基础表中的字段,
--   如果在定义视图中使用了WITH CHECK OPTION子句,那就不能对视图执行INSERT操作.  
--   注:码保留表,非码保留表的解释:   
--      在DEPT中,DEPT_NO是主码,EMP中,EMP_NO是主码  
--      然后建立连接视图:  
  create view emp_dept as  
  select emp.emp_no,emp.emp_name,emp.dept_no,dept.name  
  from emp,dept  
  where emp.dept_no=dept.dept_no
--      这个视图中,EMP_NO仍然充当主码,所以EMP为码保留表,而DEPT中的DEPT_NO就不是主码了,所以为非码保留表.  

-- 多张表关联后需要向视图插入数据，建议使用instead of触发器 
  create trigger [触发器名] on [视图名]
  instead of insert 
  as begin--声明变量；
  --从inserted表中查出所有列的数据，分别赋给声明好的变量；
  --用上面的数据向第一张表插入数据
  --用上面的数据向第二张表插入数据
  end
-- 此外通过user_updatable_columns表能够查询到该表或者视图是否可更新。





-- 6. 变异表

-- 场景描述：
-- 如果插入或者更新子类别，父类别的总销量必须级联更新
-- 比如 如果更新了0111 类别销量加1 那么 父类别0100 的销量必须也加上1
-- Test trigger :

create or replace trigger sales_amount_refresh
  after insert on sales
  for each row
  when (new.amount_sold>0)
declare
begin
  update sales
     set amount_sold = amount_sold + :new.amount_sold
   where substr(:new.prod_code, 0, length(rtrim(prod_code, '0'))) =
         rtrim(prod_code, '0') ;

end ;


-- 会产生变异表的问题

/* Test sql :

SQL> insert into sales values ('0111',1) ; 
insert into sales values ('0111',1) 

ORA-04091: table DEXTER.SALES is mutating, trigger/function may not see it

ORA-06512: at "DEXTER.SALES_AMOUNT_REFRESH", line 4

ORA-04088: error during execution of trigger 'DEXTER.SALES_AMOUNT_REFRESH'

*/


--解决办法1：可以使用自制事务来解决，但是有bug，即无法回滚
create or replace trigger sales_amount_refresh

  after insert on sales
  for each row
  when (new.amount_sold>0)
declare
  pragma autonomous_transaction ;
begin
  update sales
     set amount_sold = amount_sold + :new.amount_sold
   where substr(:new.prod_code, 0, length(rtrim(prod_code, '0'))) =
         rtrim(prod_code, '0') ;
  commit ;

end ;

-- 自治事务里面的语句不会回滚


-- 解决办法2 

-- 使用package的集合变量记录需要变更的信息，然后使用statement级别的trigger 执行update操作，package中的变量只在session中有效
-- 只需要创建一个package 头即可

create or replace package pkg_vars is
  type c_t is table of number index by varchar2(4);
  refresh_sales_list c_t ;
end ;

/

-- 修改行级触发器为

create or replace trigger sales_amount_refresh
  after insert on sales
  for each row
  when (new.amount_sold> 0)

declare

begin
  if length(rtrim (:new.prod_code, '0'))> 2 then
    pkg_vars.refresh_sales_list(:new.prod_code) := :new.amount_sold ;
  end if ;
end ;

/

-- 新增语句级触发器

create or replace trigger sales_amount_refresh_statement
  after insert on sales
declare
  ind varchar2(4);
begin
  ind := pkg_vars.refresh_sales_list.first ;
  WHILE ind IS NOT NULL LOOP
    update sales
     set amount_sold
 = amount_sold + pkg_vars.refresh_sales_list(ind)
   where substr(ind, 0 , length( rtrim(prod_code, '0' )))
 =
         rtrim(prod_code, '0' ) and length(rtrim (prod_code, '0'))= 2 ;
    ind := pkg_vars.refresh_sales_list.NEXT(ind);
  END LOOP;
  pkg_vars.refresh_sales_list.delete ;
end ;



-- 7. 复合触发器































































