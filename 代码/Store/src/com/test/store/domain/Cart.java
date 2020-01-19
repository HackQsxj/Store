package com.test.store.domain;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Cart {

	private Map<String, CartItem> map = new HashMap<>();
	private double total;
	
	public Collection<CartItem> getcartItems(){
		return map.values();
	}
	
//	添加购物车
	public void addCartItemToCart(CartItem cartItem){
		String pid = cartItem.getProduct().getPid();
//		System.out.println("pid="+pid);
		if(map.containsKey(pid)){
			CartItem oldItem = map.get(pid);
			oldItem.setNum(oldItem.getNum()+cartItem.getNum());
		}else{
			map.put(pid, cartItem);
		}
	}
//	删除购物项
	public void removeCartItem(String pid){
		map.remove(pid);
	}
//	清空购物车
	public void clearCart(){
		map.clear();
	}
	
	
	public Map<String, CartItem> getMap() {
		return map;
	}
	public void setMap(Map<String, CartItem> map) {
		this.map = map;
	}
	public double getTotal() {
		total = 0;
//		获取到Map中所有的购物项
		Collection<CartItem> values = map.values();
		for (CartItem cartItem : values) {
			total += cartItem.getSubTotal();
		}
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	
}
