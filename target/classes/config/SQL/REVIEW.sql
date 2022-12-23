drop table review;
create table review(
    num number(8) primary key,
    userid varchar2(30) references member(userid),
    content varchar2(500) not null,
    score number(1) not null,
    filename varchar2(100) default 'noimage.png',
    wdate date default sysdate,
<<<<<<< HEAD
    pnum_fk number(8) references product(pnum)
);

drop sequence review_seq;
create sequence review_seq nocache;
=======
    pnum_fk number(8) references item(pidx)
);


drop sequence review_seq;
create sequence review_seq nocache;

>>>>>>> 5151d986498978559cc11216d4d10399f57876be
