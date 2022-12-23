
create table item(
    pidx number(8) primary key,
    down_Code number(8),
    up_Code number(8),
    ptname varchar2(50) not null,
    ptimage1 varchar2(50),
    ptimage2 varchar2(50),
    ptimage3 varchar2(50),
    price number(8) not null,
    saleprice number(8),
    count number(8),
    point number(8),
    quality varchar2(20),
    pinfo varchar2(1000),
    pbrand varchar2(50),
    pindate date
); 
insert into item(ptname,pbrand,quality,count,price,pinfo,point)
values(#{ptname},#{pbrand},#{quality},#{count},#{price},#{pinfo},#{point})
commit;

select * from item;

create sequence item_seq nocache;

create table upoption(
    up_Code number(8) not null,
    up_Name varchar2(30) not null
);

commit;

create table downoption(
    down_Code number(8) not null,
    up_Code number(8) not null,
    down_Name varchar2(30)
);

commit;
