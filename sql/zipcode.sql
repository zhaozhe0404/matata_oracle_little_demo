


create table zipcode (
    zip varchar(5) not null,
    city varchar(25),
    state varchar(2),
    created_by varchar2(30) not null,
    created_date date not null,
    modified_by varchar2(30) not null,
    modified_date date not null    
);


comment on table zipcode is '������������';
comment on column zipcode.zip is '����';
comment on column zipcode.city is '����';
comment on column zipcode.state is '�ݼ�д';
comment on column zipcode.created_by is '����С����������ݵ��û�';
comment on column zipcode.created_date is '����С������ݲ��������';
comment on column zipcode.modified_by is '����С���ִ�����һ�θ��µ��û�';
comment on column zipcode.modified_date is '����С������һ�θ��µ�����';
