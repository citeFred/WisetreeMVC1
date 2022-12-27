package com.wisetree.test;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.common.CommonUtil;
import com.notice_board.model.BoardVO;
import com.notice_board.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/notice_board")
@Log4j
public class BoardController_notice {
	
	@Resource(name="boardServiceImpl")
	private BoardService boardService;
	
	@Inject
	private CommonUtil util;
	
	@GetMapping("/write")
	public String boardWrite() {
		return "notice_board/boardWrite";
	}
	@PostMapping("write")
	public String boardInsert(Model m,
			@ModelAttribute BoardVO board) {
		
		//boardService의 insertBoard()호출하기
		int n=0;
		String str="",loc="";
		n=this.boardService.insertBoard(board);
		str+=(n>0)?"성공":"실패";
		loc=(n>0)?"list":"javascript:history.back()";
		
		
		
		return util.addMsgLoc(m, str, loc);
		
	}
	
	
	@GetMapping("/list")
	public String boardList(Model m) {
		
		
	
		
		 
		//"boardArr"
		List<BoardVO> boardArr=this.boardService.selectBoardAll();
		m.addAttribute("boardArr",boardArr);
		return "notice_board/boardList";
	}//----------------------------------------
	
	@GetMapping("view/{num}")
	public String boardView(Model m,@PathVariable("num") int num) {
		log.info("num=="+num);
		
		BoardVO board=this.boardService.selectBoardByIdx(num);
		m.addAttribute("board",board);
		
		return "notice_board/boardView";
	}
	
	@PostMapping("/delete")
	public String boardDelete(Model m,
//			HttpServletRequest req,
			@RequestParam(defaultValue = "0") int num) {
		
//		BoardVO vo=this.boardService.selectBoardByIdx(num);
		int n=this.boardService.deleteBoard(num);
		
		String str=(n>0)?"글 삭제 성공":"삭제 실패";
		String loc=(n>0)?"list":"javascript:history.back()";
		
		
		return util.addMsgLoc(m, str, loc);
	}

}
