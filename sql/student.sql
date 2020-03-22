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

comment on table student is 'ѧ����Ϣ��';
comment on column student.student_id is 'ѧ��ID';
comment on column student.salutation is '�ƺ������磬Ůʿ����������ʿ��';
comment on column student.first_name is '��';
comment on column student.last_name is '��';
comment on column student.street_address is '��ַ';
comment on column student.zip is '��������';
comment on column student.phone is '�ֻ�����';
comment on column student.employer is 'ѧ����ҵ�Ĺ�˾����';
comment on column student.registration_date is 'ѧ��ע�᱾��Ŀ������';
comment on column student.created_by is '����С����������ݵ��û�';
comment on column student.created_date is '����С������ݲ��������';
comment on column student.modified_by is '����С���ִ�����һ�θ��µ��û�';
comment on column student.modified_date is '����С������һ�θ��µ�����';

create unique index student_uk_index on student (student_id);
create index student_phone_index on student (phone);


































