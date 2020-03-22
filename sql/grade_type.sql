drop table grade_type;
create table grade_type (
    grade_type_code varchar2(2) not null,
    description varchar2(50),
    created_by varchar2(30) not null,
    created_date date not null,
    modified_by varchar2(30) not null,
    modified_date date not null    
);

comment on table grade_type is '成绩类别表';
comment on column grade_type.grade_type_code is '成绩类别编码';
comment on column grade_type.description is '成绩类别描述';
comment on column grade_type.created_by is '审计列——插入数据的用户';
comment on column grade_type.created_date is '审计列——数据插入的日期';
comment on column grade_type.modified_by is '审计列——执行最后一次更新的用户';
comment on column grade_type.modified_date is '审计列——最后一次更新的日期';






























