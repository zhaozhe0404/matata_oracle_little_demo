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

comment on table enrollment is 'ѧ����ΰ��ϵ��';
comment on column enrollment.student_id is 'ѧ��ID';
comment on column enrollment.section_id is '�ΰ�ID';
comment on column enrollment.enroll_date is 'ע������';
comment on column enrollment.final_grade is '�ɼ�';
comment on column enrollment.created_by is '����С����������ݵ��û�';
comment on column enrollment.created_date is '����С������ݲ��������';
comment on column enrollment.modified_by is '����С���ִ�����һ�θ��µ��û�';
comment on column enrollment.modified_date is '����С������һ�θ��µ�����';

create index enrollment_stud_index on enrollment (student_id);
create index enrollment_sect_index on enrollment (section_id);

































