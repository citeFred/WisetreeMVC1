package com.wisetree.test;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;



import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/notice_board")
@Log4j
public class BoardController_notice {
	
	@GetMapping("/write")
	public String boardWrite() {
		return "notice_board/boardWrite";
	}
	
	
	@GetMapping("/list")
	public String boardListPaging() {
			
		return "notice_board/boardList";
	}//----------------------------------------

}
