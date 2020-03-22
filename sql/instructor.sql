create table instructor (
    instructor_id number(8,0) not null,
    salutation varchar2(5),
    first_name varchar2(25),
    last_name varchar2(25) not null,
    street_address varchar(50),
    zip varchar2(5) not null,
    phone varchar2(15),
    created_by varchar2(30) not null,
    created_date date not null,
    modified_by varchar2(30) not null,
    modified_date date not null    
);

comment on table instructor is '教师信息表';
comment on column instructor.instructor_id is '教师ID';
comment on column instructor.salutation is '称呼（例如，女士、先生、博士）';
comment on column instructor.first_name is '姓';
comment on column instructor.last_name is '名';
comment on column instructor.street_address is '地址';
comment on column instructor.zip is '邮政编码';
comment on column instructor.phone is '手机号码';
comment on column instructor.created_by is '审计列——插入数据的用户';
comment on column instructor.created_date is '审计列——数据插入的日期';
comment on column instructor.modified_by is '审计列——执行最后一次更新的用户';
comment on column instructor.modified_date is '审计列——最后一次更新的日期';

create unique index instructor_uk_index on instructor (instructor_id);
create index instructor_phone_index on instructor (phone);


































