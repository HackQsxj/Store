package com.test.store.service.imp;

import java.util.List;

import com.test.store.dao.ProductDao;
import com.test.store.dao.imp.ProductDaoImp;
import com.test.store.domain.PageBean;
import com.test.store.domain.Product;
import com.test.store.service.ProductService;
import com.test.store.utils.BeanFactory;

public class ProductServiceImp implements ProductService {

	ProductDao dao = (ProductDao) BeanFactory.createObject("ProductDao");
	@Override
	public List<Product> findNews() throws Exception {
		return dao.findNews();
	}

	@Override
	public List<Product> findHots() throws Exception {
		
		return dao.findHots();
	}

	@Override
	public Product findProductById(String pid) throws Exception {
		
		return dao.findProductById(pid);
	}

	@Override
	public PageBean<Product> findByCid(String cid, int pageNumber, int pageSize) throws Exception {
		
//		获得总记录数
		int totalRecord = dao.findTotalRecordByCid(cid);
//		System.out.println("totalRecord="+totalRecord);
		
//		封装数据
		PageBean<Product> pageBean = new PageBean<>(pageNumber, pageSize, totalRecord);
//		分页数据
		List<Product> list = dao.findAllByCid(cid, pageBean.getStartIndex(), pageBean.getPageSize());
//		System.out.println(data.toString());
		
		pageBean.setList(list);
		pageBean.setPath("ProductServlet?method=findByCid&cid="+cid);
		return pageBean;
	}

	@Override
	public void setNullByCid(String cid) throws Exception {
		dao.setNullByCid(cid);
	}

	@Override
	public List<Product> findByCid(String cid) throws Exception {
		return dao.findByCid(cid);
	}

	@Override
	public PageBean<Product> findAllProductsWithPage(int pageNumber) throws Exception {
		
		int totalRecord = dao.findTotalRecord();
//		创建对象
		PageBean<Product> pageBean = new PageBean<>(pageNumber, 5, totalRecord);
		
//		关联集合
		List<Product> list = dao.findAllProductsWithPage(pageBean.getStartIndex(), pageBean.getPageSize());
		pageBean.setList(list);
//		关联path
		pageBean.setPath("/AdminProductServlet?method=findAllProductsWithPage");
		return pageBean;
	}

	@Override
	public void saveProduct(Product product) throws Exception {
		dao.saveProduct(product);
	}


}
