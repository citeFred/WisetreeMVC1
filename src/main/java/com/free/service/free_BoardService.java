package com.free.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.free.model.free_BoardVO;
import com.free.model.free_PagingVO;

public interface free_BoardService {
	
	int insertBoard(free_BoardVO board);
	List<free_BoardVO> selectBoardAll(Map<String,Integer> map);
	List<free_BoardVO> selectBoardAllPaging(free_PagingVO paging);
	   
	List<free_BoardVO> findBoard(free_PagingVO paging);
	   
	int getTotalCount();
	int getTotalCount(free_PagingVO paging);

	free_BoardVO selectBoardByIdx(Integer idx);   
	int updateReadnum(Integer idx);
	   
	String selectPwd(Integer idx);
	int deleteBoard(Integer idx);
	int updateBoard(free_BoardVO board);

	int rewriteBoard(free_BoardVO board);
	free_BoardVO selectRefLevSunbun(int idx);
	int updateSunbun(free_BoardVO parent);
	
}
