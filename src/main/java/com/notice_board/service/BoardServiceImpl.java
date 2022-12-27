package com.notice_board.service;

import java.util.List;

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

	@Override
	public List<BoardVO> selectBoardAll() {
		return this.boardMapper.selectBoardAll();
	}

	@Override
	public BoardVO selectBoardByIdx(Integer num) {
		return this.boardMapper.selectBoardByIdx(num);
	}

	@Override
	public int deleteBoard(Integer idx) {
		return this.boardMapper.deleteBoard(idx);
	}


}
