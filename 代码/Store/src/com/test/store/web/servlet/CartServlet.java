package com.test.store.web.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.store.domain.Cart;
import com.test.store.domain.CartItem;
import com.test.store.domain.Product;
import com.test.store.service.ProductService;
import com.test.store.service.imp.ProductServiceImp;
import com.test.store.web.base.BaseServlet;

/**
 * Servlet implementation class CartServlet
 */
public class CartServlet extends BaseServlet {
	public String addCartItemToCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 从session中获取购物车
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		if (null == cart) {
			// 若获取不到，创建购物车对象
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
		}

		// 获取商品id和数量
		String pid = request.getParameter("pid");
		int num = Integer.parseInt(request.getParameter("quantity"));
//		System.out.println("pid="+pid+"num="+num);
		// 通过pid查询商品对象
		ProductService pService = new ProductServiceImp();
		Product product = pService.findProductById(pid);
//		System.out.println(product.toString());
		// 获取到待购买的购物项
		CartItem cartItem = new CartItem();
		cartItem.setNum(num);
		cartItem.setProduct(product);
//		添加购物项到购物车
		cart.addCartItemToCart(cartItem);
//		重定向到cart.jsp
		response.sendRedirect("/Demo16Store/jsp/cart.jsp");
		return null;
	}
	public String removeCartItem(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pid = request.getParameter("pid");
		System.out.println("pid = "+pid);
// 		从session中获取购物车
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		cart.removeCartItem(pid);
		response.sendRedirect("/Demo16Store/jsp/cart.jsp");
		return null;
	}
	public String clearCart(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		从session中获取购物车
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		cart.clearCart();
		response.sendRedirect("/Demo16Store/jsp/cart.jsp");
		return null;
	}
}
