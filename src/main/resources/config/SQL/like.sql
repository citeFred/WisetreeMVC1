create table users(
    userid varchar2(200) primary key not null,
    username varchar2(200) not null
);

create table board(
    boardid varchar2(200) primary key not null,
    title varchar2(200) not null,
    content varchar2(200) not null,
    writer varchar2(200) not null,
    boardlikecnt number(30) default 0,
    foreign key (writer) references users(userid)
);

create table boardlike(
    boardlikeid varchar2(200) primary key not null,
    userid varchar2(200),
    boardid varchar2(200),
    foreign key (userid) references users(userid),
    foreign key (boardid) references board(boardid)
);

drop table users;
drop table board;