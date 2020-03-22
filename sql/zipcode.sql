


create table zipcode (
    zip varchar(5) not null,
    city varchar(25),
    state varchar(2),
    created_by varchar2(30) not null,
    created_date date not null,
    modified_by varchar2(30) not null,
    modified_date date not null    
);


comment on table zipcode is '行政区划编码';
comment on column zipcode.zip is '编码';
comment on column zipcode.city is '城市';
comment on column zipcode.state is '州简写';
comment on column zipcode.created_by is '审计列——插入数据的用户';
comment on column zipcode.created_date is '审计列——数据插入的日期';
comment on column zipcode.modified_by is '审计列——执行最后一次更新的用户';
comment on column zipcode.modified_date is '审计列——最后一次更新的日期';
