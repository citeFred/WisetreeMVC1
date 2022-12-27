package com.free.model;

import javax.servlet.http.HttpSession;

import lombok.Data;

@Data
public class free_PagingVO {
	
	private int cpage;
	private int pageSize = 5;
	private int totalCount;
	private int pageCount;
	
	private int start;
	private int end;
	
	private int pagingBlock=5;
	private int prevBlock;
	private int nextBlock;
	
	private String findType;
	private String findKeyword;
	
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
