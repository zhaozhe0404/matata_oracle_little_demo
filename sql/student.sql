create table student (
    student_id number(8,0) not null,
    salutation varchar2(5),
    first_name varchar2(25),
    last_name varchar2(25) not null,
    street_address varchar(50),
    zip varchar2(5) not null,
    phone varchar2(15),
    employer varchar2(50),
    registration_date date not null,
    created_by varchar2(30) not null,
    created_date date not null,
    modified_by varchar2(30) not null,
    modified_date date not null    
);

comment on table student is '学生信息表';
comment on column student.student_id is '学生ID';
comment on column student.salutation is '称呼（例如，女士、先生、博士）';
comment on column student.first_name is '姓';
comment on column student.last_name is '名';
comment on column student.street_address is '地址';
comment on column student.zip is '邮政编码';
comment on column student.phone is '手机号码';
comment on column student.employer is '学生就业的公司名称';
comment on column student.registration_date is '学生注册本项目的日期';
comment on column student.created_by is '审计列——插入数据的用户';
comment on column student.created_date is '审计列——数据插入的日期';
comment on column student.modified_by is '审计列——执行最后一次更新的用户';
comment on column student.modified_date is '审计列——最后一次更新的日期';

create unique index student_uk_index on student (student_id);
create index student_phone_index on student (phone);


































