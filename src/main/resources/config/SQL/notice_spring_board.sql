drop table notice_spring_board;

create table notice_spring_board(
    num number(8) primary key,
    name varchar2(30) not null,
    passwd varchar2(20) not null,
    subject varchar2(200) not null,
   content varchar2(2000),
   wdate date default sysdate,
   readnum number(8) default 0,
   filename varchar2(500),
   orininFilename varchar2(500),
   filesize number(8),
   refer number(8),
   lev number(8),
   sunbun number(8)
);

drop sequence notice_spring_board_seq;
create sequence notice_spring_board_seq
start with 1
increment by 1
nocache;


-----------------------------------------------

공지글 설정을 위한 테이블 생성_확정

drop table numbu;

create table numbu(
    num number(8) primary key,
    noticeNum number(8) REFERENCES notice_spring_board(num)
    
);

drop sequence numbu_seq;

create sequence numbu_seq
start with 1
increment by 1
nocache;

Insert into MULTI1.numbu (num,noticeNum) values (numbu_seq.nextval,1);

commit;