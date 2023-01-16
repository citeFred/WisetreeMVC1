package com.notice_board.mapper;

import java.util.List;

import com.notice_board.model.BoardVO;

public interface BoardMapper {
	int insertBoard(BoardVO board);
	//게시목록 가져오기
	List<BoardVO> selectBoardAll();
	
	// 글번호에 해당하는 글 가져오기
	BoardVO selectBoardByIdx(Integer idx);
	
	// 글번호에 해당하는 글 삭제
	int deleteBoard(Integer idx);
	
	// 글번호에 해당하는 글 수정
	int updateBoard(BoardVO board);
	
	//
	int noticeControl(int num);
	// int 0 Integer null but 둘다 숫자형
	Integer noticeSelect();
	int noticeCount();
	int noticeInsert(int num);
	
	//
	int deleteNotice();
}
