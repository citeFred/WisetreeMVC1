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
	
	//free_boardWrite로 매핑
	@GetMapping("/write")
	public String boardForm() {
		
		return "free_board/free_boardWrite";
	}
	
	@Inject
	private CommonUtil util;
	
	//글쓰기 기능 관련
	@PostMapping("/write")
	public String boardInsert(Model m, HttpServletRequest req, 
			@RequestParam("mfilename") MultipartFile mfilename, @ModelAttribute free_BoardVO board) {
//		log.info("board == " + board);
		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("/resources/free_board_upload");
		File dir = new File(upDir);
		//파일 저장할 경로 지정 및 폴더 생성
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		//첨부파일이 존재한다면
		if(!mfilename.isEmpty()) {
			String originFname = mfilename.getOriginalFilename();
			long fsize = mfilename.getSize();
//			log.info(originFname + " >>> " + fsize);
			
			UUID uuid = UUID.randomUUID();
			String filename = uuid.toString() + "_" + originFname;
//			log.info("filename == " + filename);
			
			//수정글일 경우
			if(board.getMode().equals("edit")&& board.getOld_filename()!=null) {
				File delF = new File(upDir, board.getOld_filename());
				//파일이 존재한다면 삭제
				if(delF.exists()) {
					boolean b = delF.delete();
//					log.info("old file 삭제여부 == " + b);
				}
			}
			
			//파일 업로드
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
		
		//유효성 검사
		if(board.getName()==null||board.getSubject()==null||board.getPasswd()==null||
				board.getName().trim().isEmpty()||board.getSubject().trim().isEmpty()||board.getPasswd().trim().isEmpty()) {
			return "redirect:write";
		}
		
		//mode에 따른 글쓰기 방향
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
	
	//리스트 기능 관련
	@GetMapping("/list")
	public String boardListPaging(Model m, @ModelAttribute("page") free_PagingVO page, HttpServletRequest req,
			@RequestHeader("User-Agent") String userAgent) {
		String myctx = req.getContextPath();
		
		HttpSession ses = req.getSession();
		
//		log.info("1 page == " + page);
		//게시글 총 개수 가져오기 및 블록 크기 설정
		int totlaCount = this.free_boardService.getTotalCount(page);
		page.setTotalCount(totlaCount);
		page.setPagingBlock(5);
		
		page.init(ses);
		
//		log.info("2.page == " +page);
		//페이지에 게시글 보여주기
		List<free_BoardVO> boardArr = this.free_boardService.selectBoardAllPaging(page);
		
		String loc = "free_board/list";
		String pageNavi = page.getPageNavi(myctx, loc, userAgent);
		
		m.addAttribute("pageNavi", pageNavi);
		m.addAttribute("paging", page);
		m.addAttribute("boardArr", boardArr);
		
		return "free_board/free_boardList2";
	}
	
	//해당 게시글 보기
	@GetMapping("/view/{num}")
	public String boardView(Model m, @PathVariable("num") int num) {
//		log.info("num===" + num);
		//해당 게시글 열면 조회수 증가
		int n = this.free_boardService.updateReadnum(num);
		
		//해당 게시글 열기
		free_BoardVO board = this.free_boardService.selectBoardByIdx(num);
		m.addAttribute("board", board);
		
		return "free_board/free_boardView";
	}
	
	//해당 게시글 삭제
	@PostMapping("/delete")
	public String boardDelete(Model m, @RequestParam(defaultValue = "0") int num,
			@RequestParam(defaultValue = "") String passwd, HttpServletRequest req) {
//		log.info("num == " + num + ",  passwd == " + passwd);
		//유효성 체크
		if(num==0||passwd.isEmpty()) {
			return "redirect:list";
		}
		free_BoardVO vo = this.free_boardService.selectBoardByIdx(num);
		
		//데이터가 존재하지 않는 경우
		if(vo==null) {
			return util.addMsgBack(m, "데이터가 존재하지 않습니다.");
		}
		
		//삭제전 비밀번호 일치 여부
		String dbPwd = vo.getPasswd();
		if(!dbPwd.equals(passwd)) {
			return util.addMsgBack(m, "비밀번호가 틀렸습니다.");
		}
		
		//해당 게시글 삭제
		int n = this.free_boardService.deleteBoard(num);
		ServletContext app = req.getServletContext();
		String upDir = app.getRealPath("/resources/free_board_upload");
//		log.info("upDir == " + upDir);
		
		//첨부 파일 삭제
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
	
	//해당 게시글 수정
	@PostMapping("/edit")
	public String boardEditform(Model m,
			@RequestParam(defaultValue = "0") int num, @RequestParam(defaultValue = "") String passwd) {
		//유효성 체크
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
	
	//답변 글쓰기 기능
	@PostMapping("/rewrite")
	public String boardRewrite(Model m, @ModelAttribute free_BoardVO vo) {
//		log.info("vo == " + vo);
		m.addAttribute("num", vo.getNum());
		m.addAttribute("subject", vo.getSubject());
		
		return "free_board/free_boardRewrite";
	}
	
}
