package com.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.mapper.CartMapper;
import com.shop.mapper.ItemMapper;
import com.shop.model.CartVO;
import com.shop.model.ItemVO;
@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	ItemMapper itemMapper;
	
	@Autowired
	CartMapper cartMapper;
	
	@Override
	public List<ItemVO> selectByOption(int op_num) {
		return this.itemMapper.selectByOption(op_num);
	}

	@Override
	public ItemVO selectByitemNum(int itemNum) {
		return this.itemMapper.selectByitemNum(itemNum);
	}

	@Override
	public int register(ItemVO Item) {
		return this.itemMapper.register(Item);
	}

	@Override
	public Integer findCartNoByitemNo(CartVO cvo) {
		return this.cartMapper.findCartNoByitemNo(cvo);
	}

	@Override
	public int updateCartCount(CartVO cvo) {
		return this.cartMapper.updateCartCount(cvo);
	}

	@Override
	public int addCart(CartVO cvo) {
		return this.cartMapper.addCart(cvo);
	}

	@Override
	public List<CartVO> seeCartBasket(int idx_fk) {
		return this.cartMapper.seeCartBasket(idx_fk);
	}

	@Override
	public int deleteCart(int cartNo) {
		return this.cartMapper.deleteCart(cartNo);
	}

	@Override
	public CartVO getCartTotalSum(int idx_fk) {
		return this.cartMapper.getCartTotalSum(idx_fk);
	}

	@Override
	public void delOrder(int mnum_fk, int pidx) {
		// TODO Auto-generated method stub

	}
	
	@Override
	public List<ItemVO> selectByPspec(String pspec){
		return this.itemMapper.selectByPspec(pspec);
	}

}
