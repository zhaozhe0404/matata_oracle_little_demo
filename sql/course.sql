 

create table course (
    course_no number(8,0) not null,
    description varchar2(50),
    cost number(9,2),
    prerequisite number(8,0),
    created_by varchar2(30) not null,
    created_date date not null,
    modified_by varchar2(30) not null,
    modified_date date not null
);

comment on table course is '课程表';
comment on column course.course_no is '课程唯一编号';
comment on column course.description is '本课程全名';
comment on column course.cost is '注册本课程的费用';
comment on column course.prerequisite is '本课程的先决课程ID号';
comment on column course.created_by is '审计列——插入数据的用户';
comment on column course.created_date is '审计列——数据插入的日期';
comment on column course.modified_by is '审计列——执行最后一次更新的用户';
comment on column course.modified_date is '审计列——最后一次更新的日期';


create unique index course_uk_index on course (course_no);
create index course_pre_index on course (prerequisite);
