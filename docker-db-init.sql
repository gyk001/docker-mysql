
set names utf8;

create table TB_Test
(
   PID            varchar(40) not null comment '主键',
   NAME              varchar(30) comment '英文姓名',
   BIRTH           datetime default NULL comment '出生日期'
);

alter table TB_Test comment '测试信息表';

alter table TB_Test
   add primary key (PID);
