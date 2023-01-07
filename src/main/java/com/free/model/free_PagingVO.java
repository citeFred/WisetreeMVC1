package com.free.model;

import javax.servlet.http.HttpSession;

import lombok.Data;

@Data
public class free_PagingVO {
	
	//페이지 처리 관련
	private int cpage; //현재 페이지
	private int pageSize = 5; //페이지에 보여지는 page의 크기
	private int totalCount; //총 개수
	private int pageCount; //페이지 수
	
	//데이터베이스에서 앞뒤로 끊기위해 가져온
	private int start;
	private int end;
	
	//블록 처리
	private int pagingBlock=5;  //하단 블록의 개수 설정
	private int prevBlock; //이전 블록
	private int nextBlock; //이후 블록
	
	//검색 조건
	private String findType; //검색 조건 입력
	private String findKeyword; //검색어 입력
	
	//페이징 처리 연산하는 기능
	public void init(HttpSession ses) {
		if(ses!=null) {
			ses.setAttribute("pageSize", pageSize);
		}
		
		//한 페이지에 나오는 페이지의 개수
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
	
	//하단의 블록에서 페이지 컨트롤 하는 기능
	public String getPageNavi(String myctx, String loc, String userAgent) {
		//myctx : 컨텍스트명, userAgent : 브라우저 종류 파악하기 위한 문자열
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
		
		return str;
	}
	
}
