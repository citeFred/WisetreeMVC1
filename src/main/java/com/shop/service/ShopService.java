package com.shop.service;

import java.util.List;

import com.shop.model.CartVO;
import com.shop.model.ItemVO;

public interface ShopService {

	/*상품정보*/

	public List<ItemVO> selectByPspec(String pspec);
	public List<ItemVO> selectByOption(int op_num);
	
	public ItemVO selectByitemNum(int itemNum);
	
	int register(ItemVO Item);
//장바구니 정보

	Integer findCartNoByitemNo(CartVO cvo);
	int updateCartCount(CartVO cvo);
	int addCart(CartVO cvo);
	
	List<CartVO> seeCartBasket(int idx_fk);
	int deleteCart(int cartNo);
	CartVO getCartTotalSum(int idx_fk);
	
	public void delOrder(int mnum_fk, int pidx);
}