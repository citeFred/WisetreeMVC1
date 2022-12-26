package com.free.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.free.mapper.free_BoardMapper;
import com.free.model.free_BoardVO;
import com.free.model.free_PagingVO;

@Service("free_boardServiceImpl")
public class free_BoardServiceImpl implements free_BoardService {
	
	@Autowired
	private free_BoardMapper free_boardMapper;

	@Override
	public int insertBoard(free_BoardVO board) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.insertBoard(board);
	}

	@Override
	public List<free_BoardVO> selectBoardAll(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.selectBoardAll(map);
	}

	@Override
	public List<free_BoardVO> selectBoardAllPaging(free_PagingVO paging) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.selectBoardAllPaging(paging);
	}

	@Override
	public List<free_BoardVO> findBoard(free_PagingVO paging) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getTotalCount(free_PagingVO paging) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.getTotalCount(paging);
	}

	@Override
	public free_BoardVO selectBoardByIdx(Integer num) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.selectBoardByIdx(num);
	}

	@Override
	public int updateReadnum(Integer idx) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.updateReadnum(idx);
	}

	@Override
	public String selectPwd(Integer idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deleteBoard(Integer idx) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.deleteBoard(idx);
	}

	@Override
	public int updateBoard(free_BoardVO board) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.updateBoard(board);
	}

	@Override
	public int rewriteBoard(free_BoardVO board) {
		//1 부모글의 글번호로 부모글의 refer, lev, sunbun 가져오기
		free_BoardVO parent = this.selectRefLevSunbun(board.getNum());
		
		//2 기존에 달린 답변글들이 있으면 내 답변글 insert하기 전에 기존의 답변글들의 순번을 하나씩 증가시키기 >> update문
		int n = this.updateSunbun(parent);
		
		//3 내가 쓴 답변 글을 insert >> insert문
		board.setRefer(parent.getRefer());
		board.setLev(parent.getLev() + 1);
		board.setSunbun(parent.getSunbun() + 1);
		
		return this.free_boardMapper.rewriteBoard(board);
	}

	@Override
	public free_BoardVO selectRefLevSunbun(int idx) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.selectRefLevSunbun(idx);
	}

	@Override
	public int updateSunbun(free_BoardVO parent) {
		// TODO Auto-generated method stub
		return this.free_boardMapper.updateSunbun(parent);
	}

}
