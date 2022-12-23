drop table cart;

create table cart(
    cartNum number(8) primary key,
    idx_fk number(8) references member (idx) on delete cascade,
    pnum_fk number(8) references product (pnum) on delete cascade,
    oqty number(8) not null,
    indate date default sysdate,
    constraint cart_oqty_ck check (oqty >0 and oqty <51)
);

drop sequence cart_seq;

create sequence cart_seq nocache;


select * from cart;

select * from cart_seq;