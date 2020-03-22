create table section (
    section_id varchar2(32) not null,
    course_no number(8,0) not null,
    section_no number(3)not null,
    start_date_time date,
    location varchar2(50),
    instructor_id number(8,0) not null,
    capacity number(3,0),
    created_by varchar2(30) not null,
    created_date date not null,
    modified_by varchar2(30) not null,
    modified_date date not null
);

comment on table section is '���ݿγ̽����İ༶���ΰࣩ��';
comment on column section.section_id is '�ΰ�ID';
comment on column section.course_no is '�γ�ID';
comment on column section.section_no is '�ΰ���';
comment on column section.start_date_time is '�ΰ࿪�ε����ں�ʱ��';
comment on column section.location is '����';
comment on column section.instructor_id is '��ʦID';
comment on column section.capacity is '�γ���������ѧ������';
comment on column section.created_by is '����С����������ݵ��û�';
comment on column section.created_date is '����С������ݲ��������';
comment on column section.modified_by is '����С���ִ�����һ�θ��µ��û�';
comment on column section.modified_date is '����С������һ�θ��µ�����';

create unique index section_uk_index on section (section_id);
create index section_no_index on section (section_no);

-- ʹsection_id����
-- ��sequenceʵ�֣�ͬʱ��trigger��������ִ��insert��ʱ����Ҫ��ʾ����section_id
-- �Ƚϣ�
-- ֻ��sequenceû��triggerʱ�������ݣ�insert into section (section_id, section_no, course_no) values (section_sequence.nextval, 11, 23);
-- ������sequenceҲ������triggerʱ�������ݣ�insert into section (section_no, courese_no) values (11, 22);
create sequence section_sequence increment by 1 minvalue 1 maxvalue 999999999 start with 1 nocache;
create or replace trigger section_seq_auto_incr
before insert on section -- ��������������section���в�������ʱ
for each row -- ��ÿһ�в��붼���
  begin
    select to_char(section_sequence.nextval) into :new.section_id from dual; -- ȡ��������һ��ֵ�����뵽section����
  end;
/



































