package com.free.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.free.model.free_BoardVO;
import com.free.model.free_PagingVO;

public interface free_BoardService {
	int insertBoard(free_BoardVO board);
	// 게시목록 가져오기
	List<free_BoardVO> selectBoardAll(Map<String,Integer> map);
	List<free_BoardVO> selectBoardAllPaging(free_PagingVO paging);
	   
	// 검색목록 가져오기
	List<free_BoardVO> findBoard(free_PagingVO paging);
	   
	int getTotalCount();//총 게시글 수 가져오기
	int getTotalCount(free_PagingVO paging);//검색한 총 게시글 수 가져오기

	// 글번호에 해당하는 글 가져오기
	free_BoardVO selectBoardByIdx(Integer idx);   
	// 조회수 증가하기
	int updateReadnum(Integer idx);
	   
	String selectPwd(Integer idx);
	int deleteBoard(Integer idx);
	int updateBoard(free_BoardVO board);

	// 답변형(계층형) 게시판에서 답변글 달기
	int rewriteBoard(free_BoardVO board); //[답변형]
	free_BoardVO selectRefLevSunbun(int idx);//[답변형]
	int updateSunbun(free_BoardVO parent);//[답변형]
}
