package com.wisetree.test;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RestController;

import com.review.model.ReviewVO;

import lombok.extern.log4j.Log4j;

/*  ----------RESTful API방식----------------------------
 *   - URI + 메서드 방식에 따라 처리 로직을 달리한다.
 *  /reviews/           GET  : 리뷰 목록을 조회
 *  /reviews/{num}      GET  : 특정(num번) 리뷰글을 조회
 *  /user/reviews       POST  : 리뷰 글쓰기 처리
 *  /user/reviews/{num} PUT   : 특정 리뷰글을 수정
 *  /user/reviews/{num} DELETE: 특정 리뷰글을 삭제
 *  
 *  --------------------------------------------------*/

/*  ----------------------------------------------------
 *  POST	POST를 통해 해당 URI를 요청하면 리소스를 생성합니다.
 *  GET		GET를 통해 해당 리소스를 조회합니다. 
 *  		리소스를 조회하고 해당 도큐먼트에 대한 자세한 정보를 가져온다.
 *  PUT		PUT를 통해 해당 리소스를 수정합니다.
 * 	DELETE	DELETE를 통해 리소스를 삭제합니다.
 *  ----------------------------------------------------*/

/*  HTTP메서드          URI                설명
 *  GET                /prdreviews           모든 리뷰를 조회한다
 *  GET                /prdreviews/create    리뷰를 생성하기 위한 Form
 *  POST               /prdreviews           리뷰를 생성한다
 *  GET                /prdreviews/:id       id에 해당하는 리뷰를 조회한다
 *  GET                /prdreviews/:id/edit  id에 해당하는 리뷰를 수정하기 위한 Form
 *  PUT                /prdreviews/:id       id에 해당하는 리뷰를 수정한다
 *  DELETE             /prdreviews/:id       id에 해당하는 리뷰를 삭제한다
 * */

@RestController
@Log4j
public class RESTAPIController {

}
