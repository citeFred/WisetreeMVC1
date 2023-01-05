package com.free.model;

import java.sql.Date;

import lombok.Data;

@Data
public class free_BoardVO {
	
	private String mode; //mode가 write과 같으면 insertBoard, rewrite과 같으면 rewriteBoard, edit과 같으면 updateBoard
						//즉 같은 글쓰기 버튼이지만 가는 곳이 다름
	private int num; //게시글 번호
	private String name; //게시글 내 이름
	private String passwd; //게시글 내 비밀번호
	private String subject; //게시글 제목
	private String content; //게시글 내용
	private Date wdate; //게시글 작성일자
	private int readnum; //게시글 조회수
	private String filename; //게시글 첨부파일
	private String originFilename; //게시글 첨부파일 원본명
	private String old_filename; //게시글 첨부파일 
	private long filesize; //게시글 첨부파일 크기
	private int refer; //답변 글쓰기에 참조할 게시글 번호
	private int lev; //답변 글쓰기를 위한 레벨(게시글마다의 단계 표현)
	private int sunbun; //답변 글쓰기를 위한 순번
	
}
