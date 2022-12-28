package com.wisetree.test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.user.service.OAuthService;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
@RequestMapping("/oauth")
public class OAuthController {

	@Autowired
	private OAuthService os;
    /**
     * 카카오 callback
     * [GET] /oauth/kakao/callback
     */
    @ResponseBody
    @GetMapping("/kakao")
    public void kakaoCallback(@RequestParam String code) {
        System.out.println(code);
     // 위에서 만든 코드 아래에 코드 추가
     		String access_Token = os.getAccessToken(code);
     		System.out.println("###access_Token#### : " + access_Token);
    }
}
//설정한 localhost:9090/oauth/kakao로 redirect되었고, Query String으로 code를 받는다.


/*
 * 리턴값의 testPage는 아무 페이지로 대체해도 괜찮습니다.
 * 없는 페이지를 넣어도 무방합니다.
 * 404가 떠도 제일 중요한건 #########인증코드 가 잘 출력이 되는지가 중요하므로 너무 신경 안쓰셔도 됩니다.
 */
