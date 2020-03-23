-- commit/rollback/savepoint
-- 1. commit作用
--    （1） 所有通过该事务完成的工作都将被持久化
--    （2） 其他用户可以看到该事务完成的工作结果
--    （3） 由该事务持有的锁会被释放
--     example: 用户scott插入一条student记录，用户system立即查询，发现数据库中没有数据
--              用户scott插入一条student记录，立即commit，用户system再查询，发现数据库中有了这条记录
-- 用户scott：
insert into student(student_id, salutation, first_name, last_name, street_address, zip, phone, employer, registration_date, created_by, created_date, modified_by, modified_date)
values(20112001, 'sir', 'zhang', 'san', 'shenzhen futian', '43074', '130406199230', 'zhongguo pingan', sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
-- 用户system：
select * from student where student_id = '20112001';

-- 用户scott
insert into student(student_id, salutation, first_name, last_name, street_address, zip, phone, employer, registration_date, created_by, created_date, modified_by, modified_date)
values(20112002, 'sir', 'li', 'si', 'shenzhen futian', '43074', '1304061234230', 'zhongguo pingan', sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
commit;
-- 用户system：
select * from student where student_id = '20112002';

-- 补充：
-- 隐式提交
--   （1） DDL语句
--   （2） DCL语句
--   （3） 用户正常退出数据库，而缺少显式的COMMIT或者ROLLBACK。
-- 自动回退
--   （1） 用户异常退出数据库
--   （2） 系统强行关闭

-- 2. rollback作用
--    （1） 该事务所有的工作都被撤销
--    （2） 该事务获得的锁都会被释放
-- 3. savepoint作用
--    （1） savepoint之后的所有工作都被撤销
--    （2） savepoint之后获取的所有锁都会被释放
begin
  insert into student(student_id, salutation, first_name, last_name, street_address, zip, phone, employer, registration_date, created_by, created_date, modified_by, modified_date)
  values(20112003, 'sir', 'li', 'si', 'shenzhen futian', '43074', '1304061234230', 'zhongguo pingan', sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
  savepoint a;
  insert into student(student_id, salutation, first_name, last_name, street_address, zip, phone, employer, registration_date, created_by, created_date, modified_by, modified_date)
  values(20112004, 'sir', 'li', 'si', 'shenzhen futian', '43074', '1304061234230', 'zhongguo pingan', sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
  savepoint b;
  insert into student(student_id, salutation, first_name, last_name, street_address, zip, phone, employer, registration_date, created_by, created_date, modified_by, modified_date)
  values(20112005, 'sir', 'li', 'si', 'shenzhen futian', '43074', '1304061234230', 'zhongguo pingan', sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
  savepoint c;
  rollback to b;
  commit;
end;
select * from student where student_id in (20112003, 20112004, 20112005);

-- 一个pl/sql块中可以含多个事务
declare
  v_Counter NUMBER;
begin
  v_counter := 20112010;
  for i IN 1..100
  loop
    v_counter := v_counter+1;
    insert into student(student_id, salutation, first_name, last_name, street_address, zip, phone, employer, registration_date, created_by, created_date, modified_by, modified_date)
    values(v_counter, 'sir', 'li', 'si', 'shenzhen futian', '43074', '1304061234230', 'zhongguo pingan', sysdate, 'zhaozhe', sysdate, 'zhaozhe', sysdate);
    if v_counter/10 = 0
    then
      commit;
    end if;
  end loop;
end;

commit;

