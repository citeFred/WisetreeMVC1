package com.user.mapper;

import java.util.List;
import com.user.model.NotUserException;
import com.user.model.PagingVO;
import com.user.model.UserVO;

public interface UserMapper {
	int createUser(UserVO user);

	int getUserCount(PagingVO pvo);

	List<UserVO> listUser(UserVO user);

	Integer idCheck(String userid);

	int deleteUser(Integer midx);

	int updateUser(UserVO user);

	UserVO getUser(Integer midx);

	UserVO findUser(UserVO findUser) throws NotUserException;

	UserVO loginCheck(String userid, String pwd) throws NotUserException;
	
	// 회원 번호에 해당하는 회원정보 가져오기
	UserVO selectUserByIdx(Integer idx);   
}
