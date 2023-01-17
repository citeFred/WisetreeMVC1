package com.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.user.mapper.UserMapper;
import com.user.model.NotUserException;
import com.user.model.PagingVO;
import com.user.model.UserVO;

//서비스 계층에는 @Service를 붙인다.
@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

	@Autowired //@Resource도 쓴다. 
	private UserMapper userMapper;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@Override
	public int createUser(UserVO user) {
		return this.userMapper.createUser(user);
	}

	@Override
	public int getUserCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<UserVO> listUser(UserVO user) {
		return this.userMapper.listUser(user);
	}

	@Override
	public boolean idCheck(String userid) {
		Integer n=this.userMapper.idCheck(userid);
		if(n==null) {
			return true;
		}
		return false;
	}

	@Override
	public int deleteUser(Integer midx) {
		return this.userMapper.deleteUser(midx);
	}

	@Override
	public int updateUser(UserVO user) {
		return this.userMapper.updateUser(user);
	}

	@Override
	public UserVO getUser(Integer midx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserVO findUser(UserVO findUser) throws NotUserException {
		UserVO user=this.userMapper.findUser(findUser);//제출한 아이디와 DB에 일치하는 아이디확인하는 부분. findUser select문으로 검색함.
		if(user==null) {
			throw new NotUserException("존재하지 않는 아이디 입니다.");
		}
		return user;
	}

	@Override
	public UserVO loginCheck(String userid, String pwd) throws NotUserException {
		UserVO tmpVo=new UserVO();
		tmpVo.setUserid(userid);
		tmpVo.setPwd(pwd);
		
		String rawPw = ""; //실제 pw
        String encodePw = ""; //인코딩된 pw
		
		UserVO user=this.findUser(tmpVo); //제출한 아이디와 DB에 일치하는 아이디가 있는지(윗 메서드에서 DB로 연결됨) 
		//있는 경우 user(VO)를 반환 받아 옴.
		
		if(user!= null) { //아이디가 존재 하는 경우
            rawPw = tmpVo.getPwd();        // 사용자가 제출한 비밀번호
            encodePw = user.getPwd();        // 데이터베이스에 저장한 인코딩된 비밀번호
            if(true == pwEncoder.matches(rawPw, encodePw)) {
            	return user;
            }
		}
		if(user==null) { // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)
			throw new NotUserException("존재하지 않는 아이디 입니다.");
		}
		if(!user.getPwd().equals(pwd)) {
			throw new NotUserException("비밀번호가 틀렸습니다.");
		}
		return user;
	}
	
	// 회원 번호에 해당하는 회원정보 가져오기
	@Override
	public UserVO selectUserByIdx(Integer idx){
		// TODO Auto-generated method stub
		return this.userMapper.selectUserByIdx(idx);
	}
	
	
}
