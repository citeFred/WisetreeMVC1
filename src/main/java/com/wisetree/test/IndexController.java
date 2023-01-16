package com.wisetree.test;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.notice_board.model.BoardVO;
import com.notice_board.service.BoardService;

@Controller
public class IndexController {
	//뷰 네임을 반환하지 않으면(void) RequestMapping으로 등록한 "/top"==>이 뷰 네임이 된다.
	
	@Inject
	BoardService noticeService;
	@RequestMapping("/top")
	public void top() {
		//"/WEB-INF/views/top.jsp
	}
	
	@RequestMapping("/top2")
	public void top2() {
		//"/WEB-INF/views/top.jsp
	}
	
	@RequestMapping("/foot")
	public void foot() {
		//"/WEB-INF/views/foot.jsp		
	}

	@RequestMapping("/index")
	public void showIndex(Model m) {
		//numbu에 등록된 공지글번호 가져오기
		int num=noticeService.noticeSelect();
		System.out.println("num="+num);
		if(num!=0) {
		BoardVO vo=noticeService.selectBoardByIdx(num);
		m.addAttribute("notice",vo);
		}else {
			m.addAttribute("notice",null);
		}
		//"/WEB-INF/views/index.jsp				
	}
	
	@RequestMapping("/index2")
	public void showIndex2() {
		//"/WEB-INF/views/index.jsp				
	}
	
	@RequestMapping("/carousel2")
	public void carousel2() {
		//"/WEB-INF/views/index.jsp				
	}
	
	
}
