package com.test.store.service.imp;

import java.util.List;

import com.test.store.dao.CategoryDao;
import com.test.store.dao.imp.CategoryDaoImp;
import com.test.store.domain.Category;
import com.test.store.service.CategoryService;
import com.test.store.utils.BeanFactory;
import com.test.store.utils.JedisUtils;

import redis.clients.jedis.Jedis;

public class CategoryServiceImp implements CategoryService {

	CategoryDao dao = (CategoryDao) BeanFactory.createObject("CategoryDao");
	@Override
	public List<Category> getAllCates() throws Exception {
		List<Category> list = dao.getAllCates();
		return list;
	}

	@Override
	public void addCategory(Category c) throws Exception {
		dao.addCategory(c);
//		更新Redis
		Jedis jedis = JedisUtils.getJedis();
		jedis.del("allCates");
		JedisUtils.closeJedis(jedis);
	}

	@Override
	public void delCategory(String cid) throws Exception {
		dao.delCategory(cid);
//		更新Redis
		Jedis jedis = JedisUtils.getJedis();
		jedis.del("allCates");
		JedisUtils.closeJedis(jedis);
	}

	@Override
	public void updateCategory(String cid, String cname) throws Exception {
		dao.updateCategory(cid, cname);
//		更新Redis
		Jedis jedis = JedisUtils.getJedis();
		jedis.del("allCates");
		JedisUtils.closeJedis(jedis);
	}

}
