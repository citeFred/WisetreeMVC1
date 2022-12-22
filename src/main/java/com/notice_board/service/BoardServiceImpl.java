package com.notice_board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.notice_board.mapper.BoardMapper;
import com.notice_board.model.BoardVO;

@Service("boardServiceImpl")
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper boardMapper;

	@Override
	public int insertBoard(BoardVO board) {
		return this.boardMapper.insertBoard(board);
	}


}
