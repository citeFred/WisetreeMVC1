package com.free.model;

import javax.servlet.http.HttpSession;

import lombok.Data;

//페이징 처리 및 검색 기능 모듈화해서 재사용할 수 있도록 하기

@Data
public class free_PagingVO {
	
	//페이징 처리 관련 프로퍼티
	private int cpage;
	private int pageSize = 5;
	private int totalCount;
	private int pageCount;
	
	//DB에서 레코드 끊어오기 위한 프로퍼티
	private int start;
	private int end;
	
	//페이징 블럭 처리 위한 프로퍼티
	private int pagingBlock=5;
	private int prevBlock;
	private int nextBlock;
	
	//검색 관련
	private String findType;
	private String findKeyword;
	
	//페이징 처리 연산 수행하는 메서드
	public void init(HttpSession ses) {
		if(ses!=null) {
			ses.setAttribute("pageSize", pageSize);
		}
		pageCount =(totalCount - 1)/pageSize + 1;
		if(cpage<1) {
			cpage=1;
		}
		if(cpage>pageCount) {
			cpage=pageCount;
		}
		
		start = (cpage-1)*pageSize;
		end = start + (pageSize+1);
		prevBlock = (cpage - 1)/pagingBlock * pagingBlock;
		nextBlock = prevBlock + (pagingBlock + 1);
		
	}
	
	public String getPageNavi(String myctx, String loc, String userAgent) {
		//myctx : 컨텍스트명, loc : 경로, userAgent : 브라우저 종류 파악하기 위한 문자열
		//검색 관련 -----------
		
		String link = myctx + "/" + loc;
		String qStr="?pageSize=" + pageSize;
		link+=qStr;
		String str = "";
		StringBuilder buf = new StringBuilder();
		buf.append("<ul class='pagination justify-content-center'>");
		if(prevBlock>0) {
			buf.append("<li class='page-item'>")
				.append("<a class='page-link' href='"+link+"&cpage="+prevBlock+"'>")
				.append("Prev")
				.append("</a>")
				.append("</li>");
		}
		
		for(int i=prevBlock+1;i<=nextBlock-1 && i<=pageCount;i++) {
			String css = (i==cpage)?"active":"";
			
			buf.append("<li class='page-item "+css+"'>");
			buf.append("<a class='page-link' href='"+link+"&cpage="+i+"'>");
			buf.append(i);
			buf.append("</a>");
			buf.append("</li>");
		}
		
		if(nextBlock<=pageCount) {
			buf.append("<li class='page-item'>")
				.append("<a class='page-link' href='"+link+"&cpage="+nextBlock+"'>")
				.append("Next")
				.append("</a>")
				.append("</li>");
		}
		
		buf.append("</ul>");
		str = buf.toString();
		//System.out.println(str);
		
		return str;
	}
	
}
