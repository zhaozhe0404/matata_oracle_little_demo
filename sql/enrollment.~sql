create table enrollment (
    student_id number(8,0) not null,
    section_id varchar2(32) not null,
    enroll_date date not null,
    final_grade number(3,0),
    created_by varchar2(30) not null,
    created_date date not null,
    modified_by varchar2(30) not null,
    modified_date date not null    
);

comment on table enrollment is '学生与课班关系表';
comment on column enrollment.student_id is '学生ID';
comment on column enrollment.section_id is '课班ID';
comment on column enrollment.enroll_date is '注册日期';
comment on column enrollment.final_grade is '成绩';
comment on column enrollment.created_by is '审计列——插入数据的用户';
comment on column enrollment.created_date is '审计列——数据插入的日期';
comment on column enrollment.modified_by is '审计列——执行最后一次更新的用户';
comment on column enrollment.modified_date is '审计列——最后一次更新的日期';

create index enrollment_stud_index on enrollment (student_id);
create index enrollment_sect_index on enrollment (section_id);

































