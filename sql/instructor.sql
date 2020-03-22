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

comment on table instructor is '��ʦ��Ϣ��';
comment on column instructor.instructor_id is '��ʦID';
comment on column instructor.salutation is '�ƺ������磬Ůʿ����������ʿ��';
comment on column instructor.first_name is '��';
comment on column instructor.last_name is '��';
comment on column instructor.street_address is '��ַ';
comment on column instructor.zip is '��������';
comment on column instructor.phone is '�ֻ�����';
comment on column instructor.created_by is '����С����������ݵ��û�';
comment on column instructor.created_date is '����С������ݲ��������';
comment on column instructor.modified_by is '����С���ִ�����һ�θ��µ��û�';
comment on column instructor.modified_date is '����С������һ�θ��µ�����';

create unique index instructor_uk_index on instructor (instructor_id);
create index instructor_phone_index on instructor (phone);


































