package com.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
	public List<UserVO> listUser(PagingVO pvo) {
		return this.userMapper.listUser(pvo);
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
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public UserVO getUser(Integer midx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserVO findUser(UserVO findUser) throws NotUserException {
		UserVO user=this.userMapper.findUser(findUser);
		if(user==null) {
			throw new NotUserException("존재하지 않는 아이디 입니다.");
		}
		return user;
	}

	@Override
	public UserVO loginCheck(String userid, String pwd) throws NotUserException {
		UserVO tmpVo=new UserVO();
		tmpVo.setUserid(userid);
		
		UserVO user=this.findUser(tmpVo);
		if(user==null) {
			throw new NotUserException("존재하지 않는 아이디 입니다.");
		}
		if(!user.getPwd().equals(pwd)) {
			throw new NotUserException("비밀번호가 틀렸습니다.");
		}
		return user;
	}

}
