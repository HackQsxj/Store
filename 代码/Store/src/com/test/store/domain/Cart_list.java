package com.test.store.domain;

import java.util.ArrayList;
import java.util.List;

public class Cart_list {

//	个数不确定的购物项
	private List<CartItem> list = new ArrayList<>();
//	总计积分
	private double total;
	
//	添加购物到购物车
	public void addCartItemToCart(CartItem cartItem){
//		当点击添加按钮，将购买商品的pid，商品数量发送给服务端
//		当前购物项加入购物车之前，判断是否买过这类商品
		
//		设置变量，默认为false，表名没有购买过商品
		boolean flag = false;
		CartItem old = null;
		for (CartItem cartItem02 : list) {
			if(cartItem02.getProduct().getPid().equals(cartItem.getProduct().getPid())){
				flag = true;
				old = cartItem02;
			}
		}
		
		if(flag == false){
			list.add(cartItem);
		}else{
//			获取到原先数量，相加后再添加到原购物项上
			old.setNum(old.getNum()+cartItem.getNum());
		}
	}
//	移除购物项
//	当用户点击移除购物项，将当前商品的pid发送到服务端
	public void removeCartItem(String pid){
//		遍历list，若存在product对象与pid相等，则删除
		for (CartItem cartItem : list) {
			if(cartItem.getProduct().getPid().equals(pid)){
//				删除当前cartItem
//				直接调用list.remove(cartItem)无法删除，需要进行迭代
				
			}
		}
	}
//	清空购物车
	public void clearCart(){
		
	}
}
