package com.user.service;

import java.util.List;

import com.user.model.NotUserException;
import com.user.model.PagingVO;
import com.user.model.UserVO;

public interface UserService {
	int createUser(UserVO user);

	int getUserCount(PagingVO pvo);

	List<UserVO> listUser(PagingVO pvo);

	boolean idCheck(String userid);

	int deleteUser(Integer midx);

	int updateUser(UserVO user);

	UserVO getUser(Integer midx);

	UserVO findUser(UserVO findUser) throws NotUserException;

	UserVO loginCheck(String userid, String pwd) throws NotUserException;
}
