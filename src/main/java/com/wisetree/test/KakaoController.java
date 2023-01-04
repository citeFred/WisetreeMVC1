package com.wisetree.test;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.user.model.KakaoVO;
import com.user.model.UserVO;
import com.user.service.KakaoService;

import lombok.extern.log4j.Log4j;
@Log4j
@Controller
public class KakaoController {
	
	//HttpSession 클래스 주입.
	@Autowired
	private HttpSession session;
	
	@Autowired
	private KakaoService ms;
	

//	@ResponseBody //ModelAndView로 반환 할 때 ResponseBody(반환 내용이 HTML에 들어가게 됨==필요없음) 가 없어야한다. //; charset=UTF-8을 추가하여 한글 깨짐 현상 제거
    @GetMapping(value="member/kakaologin", produces="application/json; charset=UTF-8")
    public ModelAndView kakaoLogin(@RequestParam(value="code", required= false)String code,
    		@ModelAttribute("user") KakaoVO user)
    throws Exception{
        System.out.println(code);
        
     // 위에서 만든 코드 아래에 코드 추가
     		String access_Token = ms.getAccessToken(code);
     		System.out.println("###access_Token#### : " + access_Token);
     		
    		// 위에서 만든 코드 아래에 코드 추가
    		KakaoVO k_loginUser = ms.getUserInfo(access_Token);
    		System.out.println("###access_Token#### : " + access_Token);
//    		System.out.println("###nickname#### : " + loginUser.get("nickname"));
//    		System.out.println("###email#### : " + loginUser.get("email"));
    		
    		
    		// 아래 코드가 추가되는 내용
    		session.invalidate();
  
    		// 위 코드는 session객체에 담긴 정보를 초기화 하는 코드.
//    		session.setAttribute("k_loginUser", k_loginUser.getK_name());
//    		session.setAttribute("k_loginUser", k_loginUser.getK_email());
    		// 위 2개의 코드는 닉네임과 이메일을 session객체에 담는 코드
    		session.setAttribute("k_loginUser", k_loginUser);
    		session.setAttribute("k_loginUser.status", "0");
    		// jsp에서 ${sessionScope.kakaoN} 이런 형식으로 사용할 수 있다.
    		log.info("kakao User===="+k_loginUser);
    		//ModelAndView를 통해 Model(Access Token을 얻은 session의 로그인 유저를 보관 상태)
    		//와 지정 View를 동시에 반환 할 수 있다. 
    	    ModelAndView mav=new ModelAndView("redirect:/index");
    	    // 리턴값은 용도에 맞게 변경..?
    		return mav;
    	}
   
}
//설정한 localhost:9090/oauth/kakao로 redirect되었고, Query String으로 code를 받는다.


/*
 * 리턴값의 testPage는 아무 페이지로 대체해도 괜찮습니다.
 * 없는 페이지를 넣어도 무방합니다.
 * 404가 떠도 제일 중요한건 #########인증코드 가 잘 출력이 되는지가 중요하므로 너무 신경 안쓰셔도 됩니다.
 */
