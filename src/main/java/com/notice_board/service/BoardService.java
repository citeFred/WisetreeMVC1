package com.notice_board.service;

import java.util.List;

import com.notice_board.model.BoardVO;

public interface BoardService {
	int insertBoard(BoardVO board);
	//게시목록 가져오기
	List<BoardVO> selectBoardAll();

}
