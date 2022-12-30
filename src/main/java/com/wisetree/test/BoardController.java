package com.wisetree.test;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.common.CommonUtil;
import com.free.model.free_BoardVO;
import com.free.model.free_PagingVO;
import com.free.service.free_BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/free_board")
@Log4j
public class BoardController {
	
	@Resource(name="free_boardServiceImpl")
	private free_BoardService free_boardService;
	
	@GetMapping("/write")
	public String boardForm() {
		
		return "free_board/free_boardWrite";
	}
	
	@Inject
	private CommonUtil util;
	
	@PostMapping("/write")
	public String boardInsert(Model m, HttpServletRequest req, 
			@RequestParam("mfilename") MultipartFile mfilename, @ModelAttribute free_BoardVO board) {
//		log.info("board == " + board);
		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("/resources/free_board_upload");
		File dir = new File(upDir);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		if(!mfilename.isEmpty()) {
			String originFname = mfilename.getOriginalFilename();
			long fsize = mfilename.getSize();
//			log.info(originFname + " >>> " + fsize);
			
			UUID uuid = UUID.randomUUID();
			String filename = uuid.toString() + "_" + originFname;
//			log.info("filename == " + filename);
			
			if(board.getMode().equals("edit")&& board.getOld_filename()!=null) {
				File delF = new File(upDir, board.getOld_filename());
				if(delF.exists()) {
					boolean b = delF.delete();
					log.info("old file 삭제여부 == " + b);
				}
			}

			try {
				mfilename.transferTo(new File(upDir, filename));
//				log.info("upDir == " + upDir);
			} catch(Exception e) {
				log.error("board write file upload error "+e);
			}
			
			board.setFilename(filename);
			board.setOriginFilename(originFname);
			board.setFilesize(fsize);
		}
		
		if(board.getName()==null||board.getSubject()==null||board.getPasswd()==null||
				board.getName().trim().isEmpty()||board.getSubject().trim().isEmpty()||board.getPasswd().trim().isEmpty()) {
			return "redirect:write";
		}
		
		int n = 0;
		String str = "", loc = "";
		if("write".equals(board.getMode())) {
			n = this.free_boardService.insertBoard(board);
			
			str = "글쓰기 ";
			
		} else if("rewrite".equals(board.getMode())) {
			n=this.free_boardService.rewriteBoard(board);
			str="답변 글쓰기 ";
		} else if("edit".equals(board.getMode())) {
			n = this.free_boardService.updateBoard(board);
			str="글수정 ";
		}
		str+=(n>0)?"글 작성 완료":"글 작성 실패";
		loc+=(n>0)?"list":"javascript:history.back()";
		
		return util.addMsgLoc(m, str, loc);
	}
	
	@GetMapping("/list")
	public String boardListPaging(Model m, @ModelAttribute("page") free_PagingVO page, HttpServletRequest req,
			@RequestHeader("User-Agent") String userAgent) {
		String myctx = req.getContextPath();
		
		HttpSession ses = req.getSession();
		
//		log.info("1 page == " + page);
		int totlaCount = this.free_boardService.getTotalCount(page);
		page.setTotalCount(totlaCount);
		page.setPagingBlock(5);
		
		page.init(ses);
		
//		log.info("2.page == " +page);
		List<free_BoardVO> boardArr = this.free_boardService.selectBoardAllPaging(page);
		
		String loc = "free_board/list";
		String pageNavi = page.getPageNavi(myctx, loc, userAgent);
		
		m.addAttribute("pageNavi", pageNavi);
		m.addAttribute("paging", page);
		m.addAttribute("boardArr", boardArr);
		
		return "free_board/free_boardList2";
	}
	
	@GetMapping("/view/{num}")
	public String boardView(Model m, @PathVariable("num") int num) {
//		log.info("num===" + num);
		int n = this.free_boardService.updateReadnum(num);
		
		free_BoardVO board = this.free_boardService.selectBoardByIdx(num);
		m.addAttribute("board", board);
		
		return "free_board/free_boardView";
	}
	
	@PostMapping("/delete")
	public String boardDelete(Model m, @RequestParam(defaultValue = "0") int num,
			@RequestParam(defaultValue = "") String passwd, HttpServletRequest req) {
//		log.info("num == " + num + ",  passwd == " + passwd);
		if(num==0||passwd.isEmpty()) {
			return "redirect:list";
		}
		free_BoardVO vo = this.free_boardService.selectBoardByIdx(num);
		if(vo==null) {
			return util.addMsgBack(m, "데이터가 존재하지 않습니다.");
		}
		
		String dbPwd = vo.getPasswd();
		if(!dbPwd.equals(passwd)) {
			return util.addMsgBack(m, "비밀번호가 틀렸습니다.");
		}
		
		int n = this.free_boardService.deleteBoard(num);
		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("/resources/free_board_upload");
//		log.info("upDir == " + upDir);
		
		if(n>0 && vo.getFilename()!=null) {
			File f = new File(upDir, vo.getFilename());
			if(f.exists()) {
				boolean b = f.delete();
				log.info("파일 삭제 여부 : " + b);
			}
		}
		String str = (n>0)?"글 삭제 완료":"글 삭제 실패";
		String loc = (n>0)?"list":"javascript:history.back()";
		
		return util.addMsgLoc(m, str, loc);
	}
	
	@PostMapping("/edit")
	public String boardEditform(Model m,
			@RequestParam(defaultValue = "0") int num, @RequestParam(defaultValue = "") String passwd) {
		if(num==0||passwd.isEmpty()) {
			return "redirect:list";
		}
		
		free_BoardVO vo = this.free_boardService.selectBoardByIdx(num);
		if(vo==null) {
			return util.addMsgBack(m, "no data");
		}
		
		if(!vo.getPasswd().equals(passwd)) {
			return util.addMsgBack(m, "비밀번호가 틀렸습니다.");
		}

		m.addAttribute("board", vo);
		
		return "free_board/free_boardEdit";
	}
	
	@PostMapping("/rewrite")
	public String boardRewrite(Model m, @ModelAttribute free_BoardVO vo) {
//		log.info("vo == " + vo);
		m.addAttribute("num", vo.getNum());
		m.addAttribute("subject", vo.getSubject());
		
		return "free_board/free_boardRewrite";
	}
	
}
