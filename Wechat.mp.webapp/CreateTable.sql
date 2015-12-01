prompt PL/SQL Developer import file
prompt Created on 2015年11月27日 by huanghe
set feedback off
set define off
prompt Dropping CARINFO...
drop table CARINFO cascade constraints;
prompt Dropping MASTER...
drop table MASTER cascade constraints;
prompt Dropping SCHEDULE...
drop table SCHEDULE cascade constraints;
prompt Dropping USERLIST...
drop table USERLIST cascade constraints;
prompt Creating CARINFO...
create table CARINFO
(
  car_id        VARCHAR2(2) not null,
  car_name      VARCHAR2(50),
  person_cnt    NUMBER not null,
  license_plate VARCHAR2(10),
  driver        VARCHAR2(2),
  makuser       VARCHAR2(4),
  makdt         TIMESTAMP(6),
  upduser       VARCHAR2(4),
  upddt         TIMESTAMP(6),
  status        VARCHAR2(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating MASTER...
create table MASTER
(
  id     VARCHAR2(2) not null,
  status VARCHAR2(4) not null,
  num    VARCHAR2(20)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MASTER
  add constraint KEY primary key (ID, STATUS)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating SCHEDULE...
create table SCHEDULE
(
  eq            NUMBER not null,
  plan_car      VARCHAR2(2) not null,
  plan_user     VARCHAR2(4) not null,
  from_location VARCHAR2(100) not null,
  from_time     TIMESTAMP(6) not null,
  to_location   VARCHAR2(100),
  to_time       TIMESTAMP(6),
  makuser       VARCHAR2(20),
  makdt         TIMESTAMP(6),
  upduser       VARCHAR2(20),
  upddt         TIMESTAMP(6),
  status        VARCHAR2(2),
  remark        VARCHAR2(2000)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
comment on column SCHEDULE.eq
  is '連番';
comment on column SCHEDULE.plan_car
  is '予約車両';
comment on column SCHEDULE.plan_user
  is '予約者';
comment on column SCHEDULE.from_location
  is '発車地点';
comment on column SCHEDULE.from_time
  is '発車時間';
comment on column SCHEDULE.to_location
  is 'お届け地点';
comment on column SCHEDULE.to_time
  is 'お届け時間';
comment on column SCHEDULE.makuser
  is '作成者';
comment on column SCHEDULE.makdt
  is '作成時間';
comment on column SCHEDULE.upduser
  is '更新者';
comment on column SCHEDULE.upddt
  is '更新時間';
comment on column SCHEDULE.status
  is '状態';

prompt Creating USERLIST...
create table USERLIST
(
  user_id     VARCHAR2(5) not null,
  user_name   VARCHAR2(50),
  distinction VARCHAR2(2),
  department  VARCHAR2(10),
  position    VARCHAR2(20),
  tel         VARCHAR2(20),
  work_years  VARCHAR2(2),
  makuser     VARCHAR2(5),
  makdt       TIMESTAMP(6),
  upduser     VARCHAR2(5),
  upddt       TIMESTAMP(6),
  status      VARCHAR2(2)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_USERLIST on USERLIST (USER_ID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Disabling triggers for CARINFO...
alter table CARINFO disable all triggers;
prompt Disabling triggers for MASTER...
alter table MASTER disable all triggers;
prompt Disabling triggers for SCHEDULE...
alter table SCHEDULE disable all triggers;
prompt Disabling triggers for USERLIST...
alter table USERLIST disable all triggers;
prompt Loading CARINFO...
insert into CARINFO (car_id, car_name, person_cnt, license_plate, driver, makuser, makdt, upduser, upddt, status)
values ('18', 'TOYOTA', 5, 'A351165854', '01', 'root', to_timestamp('19-11-2015 14:18:12.223000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('19-11-2015 14:18:12.223000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1');
insert into CARINFO (car_id, car_name, person_cnt, license_plate, driver, makuser, makdt, upduser, upddt, status)
values ('19', 'GL8', 99, 'D15624', '01', 'root', to_timestamp('19-11-2015 14:19:24.254000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('19-11-2015 14:19:24.254000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1');
insert into CARINFO (car_id, car_name, person_cnt, license_plate, driver, makuser, makdt, upduser, upddt, status)
values ('20', 'HONDA', 5, 'ASD4565', '01', 'root', to_timestamp('19-11-2015 14:22:46.101000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('19-11-2015 14:22:46.101000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1');
insert into CARINFO (car_id, car_name, person_cnt, license_plate, driver, makuser, makdt, upduser, upddt, status)
values ('16', 'A380', 5, 'A326541', '01', 'root', to_timestamp('19-11-2015 14:15:54.710000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('19-11-2015 14:15:54.710000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1');
insert into CARINFO (car_id, car_name, person_cnt, license_plate, driver, makuser, makdt, upduser, upddt, status)
values ('17', 'KMR', 99, 'A548563', '01', 'root', to_timestamp('19-11-2015 14:16:20.257000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('19-11-2015 14:16:20.257000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1');
insert into CARINFO (car_id, car_name, person_cnt, license_plate, driver, makuser, makdt, upduser, upddt, status)
values ('21', 'A3621', 99, 'A3651', '01', 'root', to_timestamp('19-11-2015 14:23:42.723000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('19-11-2015 14:23:42.723000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1');
commit;
prompt 6 records loaded
prompt Loading MASTER...
insert into MASTER (id, status, num)
values ('01', '1', '空闲');
insert into MASTER (id, status, num)
values ('01', '2', '出行中');
insert into MASTER (id, status, num)
values ('01', '3', '报废');
insert into MASTER (id, status, num)
values ('02', '1', '在职');
insert into MASTER (id, status, num)
values ('02', '2', '离职');
insert into MASTER (id, status, num)
values ('03', '1', '等待审批');
insert into MASTER (id, status, num)
values ('03', '2', '审批通过');
insert into MASTER (id, status, num)
values ('03', '3', '审批不通过');
insert into MASTER (id, status, num)
values ('03', '4', '取消');
commit;
prompt 9 records loaded
prompt Loading SCHEDULE...
insert into SCHEDULE (eq, plan_car, plan_user, from_location, from_time, to_location, to_time, makuser, makdt, upduser, upddt, status, remark)
values (28, '17', 'root', '广州', to_timestamp('24-11-2015 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '深圳', to_timestamp('24-11-2015 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('23-11-2015 15:31:57.248000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('23-11-2015 15:38:53.140000', 'dd-mm-yyyy hh24:mi:ss.ff'), '4', '接客户');
insert into SCHEDULE (eq, plan_car, plan_user, from_location, from_time, to_location, to_time, makuser, makdt, upduser, upddt, status, remark)
values (29, '20', 'root', '广州', to_timestamp('25-12-2015 12:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '深圳', to_timestamp('25-12-2015 14:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('23-11-2015 15:39:38.907000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'root', to_timestamp('23-11-2015 15:39:54.997000', 'dd-mm-yyyy hh24:mi:ss.ff'), '1', 'TEST');
commit;
prompt 2 records loaded
prompt Loading USERLIST...
insert into USERLIST (user_id, user_name, distinction, department, position, tel, work_years, makuser, makdt, upduser, upddt, status)
values ('01', '李XXX', '02', '管理部', '1', '1383838438', '2', null, null, null, null, '01');
insert into USERLIST (user_id, user_name, distinction, department, position, tel, work_years, makuser, makdt, upduser, upddt, status)
values ('root', '普通用户', '03', '管理部', '2', '138XXXX3838', '2', null, null, null, null, '01');
commit;
prompt 2 records loaded
prompt Enabling triggers for CARINFO...
alter table CARINFO enable all triggers;
prompt Enabling triggers for MASTER...
alter table MASTER enable all triggers;
prompt Enabling triggers for SCHEDULE...
alter table SCHEDULE enable all triggers;
prompt Enabling triggers for USERLIST...
alter table USERLIST enable all triggers;
set feedback on
set define on
prompt Done.
