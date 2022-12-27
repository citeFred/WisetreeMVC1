package com.notice_board.mapper;

import java.util.List;

import com.notice_board.model.BoardVO;

public interface BoardMapper {
	int insertBoard(BoardVO board);
	//게시목록 가져오기
	List<BoardVO> selectBoardAll();

}
