drop table grade_type;
create table grade_type (
    grade_type_code varchar2(2) not null,
    description varchar2(50),
    created_by varchar2(30) not null,
    created_date date not null,
    modified_by varchar2(30) not null,
    modified_date date not null    
);

comment on table grade_type is '�ɼ�����';
comment on column grade_type.grade_type_code is '�ɼ�������';
comment on column grade_type.description is '�ɼ��������';
comment on column grade_type.created_by is '����С����������ݵ��û�';
comment on column grade_type.created_date is '����С������ݲ��������';
comment on column grade_type.modified_by is '����С���ִ�����һ�θ��µ��û�';
comment on column grade_type.modified_date is '����С������һ�θ��µ�����';






























