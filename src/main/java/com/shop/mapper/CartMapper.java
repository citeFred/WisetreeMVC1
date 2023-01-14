package com.shop.mapper;

import java.util.List;

import com.shop.model.CartVO;

public interface CartMapper {

	Integer findCartNoByitemNo(CartVO cvo);
	int updateCartCount(CartVO cvo);
	int addCart(CartVO cvo);
	
	List<CartVO> seeCartBasket(int idx_fk);
	int deleteCart(int cartNum);
	int getCartTotalSum(int idx_fk);
	


}
