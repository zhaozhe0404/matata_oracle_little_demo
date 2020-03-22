 

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

comment on table course is '�γ̱�';
comment on column course.course_no is '�γ�Ψһ���';
comment on column course.description is '���γ�ȫ��';
comment on column course.cost is 'ע�᱾�γ̵ķ���';
comment on column course.prerequisite is '���γ̵��Ⱦ��γ�ID��';
comment on column course.created_by is '����С����������ݵ��û�';
comment on column course.created_date is '����С������ݲ��������';
comment on column course.modified_by is '����С���ִ�����һ�θ��µ��û�';
comment on column course.modified_date is '����С������һ�θ��µ�����';


create unique index course_uk_index on course (course_no);
create index course_pre_index on course (prerequisite);
