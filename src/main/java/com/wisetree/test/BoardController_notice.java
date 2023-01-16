package com.wisetree.test;

import java.io.File;
import java.util.List;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;

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
	
	@GetMapping("/deleteNotice")
	public String boardDeleteNotice(Model m,
			HttpServletRequest req,
			@RequestParam(defaultValue = "0") int num) {
		
		int vo=this.boardService.noticeSelect();
		if(vo==0) {
			return util.addMsgBack(m, "공지글이 존재하지 않아요");
		}
		
		//db에서 글 삭제처리
		int n=this.boardService.deleteNotice(); 
		
		String str=(n>0)?"공지 삭제 성공":"삭제 실패";
		String loc=(n>0)?"list":"javascript:history.back()";
		
		return util.addMsgLoc(m, str, loc);
	}
	
	@PostMapping("/noticeCon")
	public String noticeControl(int num, Model m) {
		log.info(num);
		try {
		int n=boardService.noticeControl(num);
		if(n>0)
		return util.addMsgLoc(m, "공지글이 등록되었습니다", "list");
		else
			return util.addMsgLoc(m, "공지글이 등록 실패", "list");
		
		}catch (Exception e) {
			return util.addMsgLoc(m, "공지글번호를 확인하세요", "list");
		}
	}
	
	@GetMapping("/write")
	public String boardWrite() {
		return "notice_board/boardWrite";
	}
	@PostMapping(value = "/write", produces = "application/text;charset=utf-8")
	public String boardInsert(Model m,
			HttpServletRequest req,
			@RequestParam("mfilename") MultipartFile mfilename,
			@ModelAttribute BoardVO board) {
		
		//파일 업로드 처리
		//업로드  디렉토리 절대경로 얻기
		ServletContext app=req.getServletContext();
		String upDir=app.getRealPath("/resources/notice_board_upload");
		File dir=new File(upDir);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		if(!mfilename.isEmpty()) {
			//첨부파일명과 파일크기 확인
			String originFname=mfilename.getOriginalFilename();
			long fsize=mfilename.getSize();
			log.info(originFname+">>>"+fsize);
			
			//동일한 파일명이 서버에 있을 경우 랜덤 처리
			UUID uuid=UUID.randomUUID();
			String filename=uuid.toString()+"-"+originFname;
			log.info("filename==="+filename);
		
		
			//업로드 처리
			try {
				mfilename.transferTo(new File(upDir,filename));
				log.info("upDir==="+upDir);
			} catch (Exception e) {
				log.error("board w e"+e);
			}
			
			//BoardVO객체에 filename, originFilename,filesize세팅
			board.setFilename(filename);
			board.setOriginFilename(originFname);
			board.setFilesize(fsize);
		}
		
		//유효성 체크 (subject, name, passwd)==> reditect "write"
		if(board.getName()==null||board.getSubject()==null||board.getPasswd()==null||
				board.getName().trim().isEmpty()||board.getSubject().trim().isEmpty()||board.getPasswd().trim().isEmpty()) {
			return "redirect:write";
		}
		
		
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
		
		int noticeCon=this.boardService.noticeSelect();
		m.addAttribute("noticeCon",noticeCon);
		return "notice_board/boardView";
	}
	
	@PostMapping("/delete")
	public String boardDelete(Model m,
			HttpServletRequest req,
			@RequestParam(defaultValue = "0") int num,
			@RequestParam(defaultValue = "") String passwd) {
		
		if(num==0||passwd.isEmpty()) {
			return "redirect:list";
		}
		
		BoardVO vo=this.boardService.selectBoardByIdx(num);
		if(vo==null) {
			return util.addMsgBack(m, "해당글은 존재하지 않아요");
		}
		
		String dbPwd=vo.getPasswd();
		if(!dbPwd.equals(passwd)) {
			return util.addMsgBack(m, "비밀번호가 일치하지 않아요");
			
		}
		
		//db에서 글 삭제처리
		int n=this.boardService.deleteBoard(num);
		
		//업로드 디렉토리 절대경로 얻기
		ServletContext app=req.getServletContext();
		String upDir=app.getRealPath("/resources/notice_board_upload");
		log.info("upDir==="+upDir);
		
		//서버에 업로드한 첨부파일이 있다면 서버에서 삭제처리
		if(n>0 && vo.getFilename()!=null) {
			File f=new File(upDir,vo.getFilename());
			if(f.exists()) {
				boolean b=f.delete();
				log.info("파일 삭제 여부: "+b);
			}
		}
		String str=(n>0)?"글 삭제 성공":"삭제 실패";
		String loc=(n>0)?"list":"javascript:history.back()";
		
		
		return util.addMsgLoc(m, str, loc);
	}
	
	@PostMapping("/edit")
	public String boardEditform(Model m,
			@RequestParam(defaultValue = "0") int num,
			@RequestParam(defaultValue = "") String passwd
			) {
		//글번호,비번 유효성 체크 ==> list
		if(num==0||passwd.isEmpty()) {
			return "redirect:list";
		}
		//글번호로 해당 글 가져오기
		BoardVO vo=this.boardService.selectBoardByIdx(num);
		//글번호로 유효성 체크
		if(vo==null) {
			return util.addMsgBack(m, "해당 글은 없어요");
		}
		
		//비번체크->일치하지 않으면 "불일치" backd이동
		if(!vo.getPasswd().equals(passwd)) {
			return util.addMsgBack(m, "비밀번호가 일치하지 않아요");
		}
		
		//Model에 해당 글 저장 "board"
		m.addAttribute("board",vo);
		
		return "notice_board/boardEdit";
	}
	
	@PostMapping(value = "/update",  produces = "application/text;charset=utf-8")
	public String boardEditform(Model m,
			HttpServletRequest req,
			@RequestParam("mfilename") MultipartFile mfilename,
			@ModelAttribute BoardVO board
			) {
		
		
		
		//업로드 디렉토리 절대경로 얻기
		ServletContext app=req.getServletContext();
		String upDir=app.getRealPath("/resources/notice_board_upload");
		
		//이전에 첨부한 파일이 있다면 삭제 처리
		if(board.getOld_filename()!=null) {
			File delF=new File(upDir, board.getOld_filename());
			if(delF.exists()) {
				boolean b=delF.delete();
				log.info("old file삭제여부: "+b);
			}
		}
		
		//파일 업로드 처리
		File dir=new File(upDir);
		if(!dir.exists()) {
			dir.mkdirs();
		}
				
		if(!mfilename.isEmpty()) {
			//첨부파일명과 파일크기 확인
			String originFname=mfilename.getOriginalFilename();
			long fsize=mfilename.getSize();
			log.info(originFname+">>>"+fsize);				
			//동일한 파일명이 서버에 있을 경우 랜덤 처리
			UUID uuid=UUID.randomUUID();
			String filename=uuid.toString()+"-"+originFname;
			log.info("filename==="+filename);
				
				
			//업로드 처리
			try {
				mfilename.transferTo(new File(upDir,filename));
				log.info("upDir==="+upDir);
			} catch (Exception e) {
				log.error("board w e"+e);
			}
					
			//BoardVO객체에 filename, originFilename,filesize세팅
			board.setFilename(filename);
			board.setOriginFilename(originFname);
			board.setFilesize(fsize);
		}
		
		//글번호로 해당 글 가져오기
		int vo=this.boardService.updateBoard(board);
		
		//Model에 해당 글 저장 "board"
		m.addAttribute("board",vo);
		
		return "redirect:/notice_board/list";
	}

}
