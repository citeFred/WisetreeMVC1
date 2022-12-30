DROP INDEX PK_UPCATEGORY;

/* 상위카테고리 */
DROP TABLE UPCATEGORY 
	CASCADE CONSTRAINTS;

/* 상위카테고리 */
CREATE TABLE UPCATEGORY (
	UPCG_CODE NUMBER(8) NOT NULL, /* 상위카테고리코드 */
	UPCG_NAME VARCHAR2(30) NOT NULL /* 상위카테고리명 */
);

COMMENT ON TABLE UPCATEGORY IS '상위카테고리';

COMMENT ON COLUMN UPCATEGORY.UPCG_CODE IS '상위카테고리코드';

COMMENT ON COLUMN UPCATEGORY.UPCG_NAME IS '상위카테고리명';

CREATE UNIQUE INDEX PK_UPCATEGORY
	ON UPCATEGORY (
		UPCG_CODE ASC
	);

ALTER TABLE UPCATEGORY
	ADD
		CONSTRAINT PK_UPCATEGORY
		PRIMARY KEY (
			UPCG_CODE
		);
----------------------------------------------
DROP INDEX PK_DOWNCATEGORY;

/* 하위카테고리 */
DROP TABLE DOWNCATEGORY 
	CASCADE CONSTRAINTS;

/* 하위카테고리 */
CREATE TABLE DOWNCATEGORY (
	DOWNCG_CODE NUMBER(8) NOT NULL, /* 하위카테고리코드 */
	UPCG_CODE NUMBER(8) NOT NULL, /* 상위카테고리코드 */
	DOWNCG_NAME VARCHAR2(30) /* 하위카테고리명 */
);

COMMENT ON TABLE DOWNCATEGORY IS '하위카테고리';

COMMENT ON COLUMN DOWNCATEGORY.DOWNCG_CODE IS '하위카테고리코드';

COMMENT ON COLUMN DOWNCATEGORY.UPCG_CODE IS '상위카테고리코드';

COMMENT ON COLUMN DOWNCATEGORY.DOWNCG_NAME IS '하위카테고리명';

CREATE UNIQUE INDEX PK_DOWNCATEGORY
	ON DOWNCATEGORY (
		DOWNCG_CODE ASC,
		UPCG_CODE ASC
	);

ALTER TABLE DOWNCATEGORY
	ADD
		CONSTRAINT PK_DOWNCATEGORY
		PRIMARY KEY (
			DOWNCG_CODE,
			UPCG_CODE
		);

ALTER TABLE DOWNCATEGORY
	ADD
		CONSTRAINT FK_UPCATEGORY_TO_DOWNCATEGORY
		FOREIGN KEY (
			UPCG_CODE
		)
		REFERENCES UPCATEGORY (
			UPCG_CODE
		);


create sequence upcategory_seq nocache;
create sequence downcategory_seq nocache;

insert into UPCATEGORY values(UPCATEGORY_seq.nextval,'전자제품');
insert into UPCATEGORY values(UPCATEGORY_seq.nextval,'생활용품');
insert into UPCATEGORY values(UPCATEGORY_seq.nextval,'의류');

commit;

select*from UPCATEGORY;

insert into downcategory(upcg_code,downcg_code, downcg_name) values(1, downcategory_seq.nextval,'주방가전');
insert into downcategory(upcg_code,downcg_code, downcg_name) values(1, downcategory_seq.nextval,'생활가전');

insert into downcategory(upcg_code,downcg_code, downcg_name) values(2, downcategory_seq.nextval,'휴지');
insert into downcategory(upcg_code,downcg_code, downcg_name) values(2, downcategory_seq.nextval,'세제');

insert into downcategory(upcg_code,downcg_code, downcg_name) values(3, downcategory_seq.nextval,'남성의류');
insert into downcategory(upcg_code,downcg_code, downcg_name) values(3, downcategory_seq.nextval,'여성의류');
commit;

select*from downcategory;