DROP INDEX PK_member;

/* 회원 */
DROP TABLE member 
	CASCADE CONSTRAINTS;

/* 회원 */
CREATE TABLE member (
	idx  NUMBER(8) NOT NULL, /* 회원번호 */
	name VARCHAR2(30) NOT NULL, /* 이름 */
	userid VARCHAR2(20) NOT NULL, /* 아이디 */
	pwd VARCHAR2(16) NOT NULL, /* 비밀번호 */
	hp1 CHAR(3) NOT NULL, /* 연락처1 */
	hp2 CHAR(4) NOT NULL, /* 연락처2 */
	hp3 CHAR(4) NOT NULL, /* 연락처3 */
	post CHAR(5), /* 우편번호 */
	addr1 VARCHAR2(100), /* 주소1 */
	addr2 VARCHAR2(100), /* 주소2 */
	indate DATE, /* 가입일 */
	mileage NUMBER(8), /* 적립금 */
	status NUMBER(2) /* 회원상태 */
);

COMMENT ON TABLE member IS '회원';

COMMENT ON COLUMN member.idx  IS '회원번호';

COMMENT ON COLUMN member.name IS '이름';

COMMENT ON COLUMN member.userid IS '아이디';

COMMENT ON COLUMN member.pwd IS '비밀번호';

COMMENT ON COLUMN member.hp1 IS '연락처1';

COMMENT ON COLUMN member.hp2 IS '연락처2';

COMMENT ON COLUMN member.hp3 IS '연락처3';

COMMENT ON COLUMN member.post IS '우편번호';

COMMENT ON COLUMN member.addr1 IS '주소1';

COMMENT ON COLUMN member.addr2 IS '주소2';

COMMENT ON COLUMN member.indate IS '가입일';

COMMENT ON COLUMN member.mileage IS '적립금';

COMMENT ON COLUMN member.status IS '회원상태';

CREATE UNIQUE INDEX PK_member
	ON member (
		idx  ASC
	);

ALTER TABLE member
	ADD
		CONSTRAINT PK_member
		PRIMARY KEY (
			idx 
		);

desc member;        