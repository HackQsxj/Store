package com.test.store.web.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import com.mchange.v2.codegen.bean.BeangenUtils;
import com.test.store.domain.Category;
import com.test.store.domain.PageBean;
import com.test.store.domain.Product;
import com.test.store.service.CategoryService;
import com.test.store.service.ProductService;
import com.test.store.service.imp.CategoryServiceImp;
import com.test.store.service.imp.ProductServiceImp;
import com.test.store.utils.UUIDUtils;
import com.test.store.utils.UploadUtils;
import com.test.store.web.base.BaseServlet;

/**
 * Servlet implementation class AdminProductServlet
 */
public class AdminProductServlet extends BaseServlet {
	public String findAllProductsWithPage(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
//		调用业务层查询所有商品
		ProductService pService = new ProductServiceImp();
		PageBean<Product> pageBean = pService.findAllProductsWithPage(pageNumber);
		request.setAttribute("pageBean", pageBean);
//		转发到
		return "/admin/product/list.jsp";
	}
	public String addProductUI(HttpServletRequest request, HttpServletResponse response) throws Exception{
	
//		获取全部分类信息
		CategoryService cService = new CategoryServiceImp();
		List<Category> list = cService.getAllCates();
//		将全部分类信息放入request
		request.setAttribute("allCates", list);
//		转发
		return "/admin/product/add.jsp";
	}
	public String addProduct(HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		try{
			Map<String, String> map = new HashedMap();
//			执行三行语句,获取请求体中的所有数据
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			List<FileItem> list = upload.parseRequest(request);
//			遍历集合
			for (FileItem item : list) {
				if(item.isFormField()){
//					当前FileItem是普通项，将name作为键，获取到的内容作为值，存入map
					map.put(item.getFieldName(), item.getString("utf-8"));
				}else{
//					当前FileItem是上传项
//					获取保存文件的名称
					String oldFileName = item.getName();
					String newFileName = UploadUtils.getUUIDName(oldFileName);
//					获取输入流对象
					InputStream is = item.getInputStream();
//					获取到当前项目下某文件夹的真实路径
					String realPath = getServletContext().getRealPath("/products/3/");
					String dir = UploadUtils.getDir(newFileName);
//					在服务端创建一个空文件
					String path = realPath+dir;
					File newDir = new File(path);
					if(!newDir.exists()){
						newDir.mkdirs();
					}
					File finalFile = new File(newDir, newFileName);
					if(!finalFile.exists()){
						finalFile.createNewFile();
					}
//					创建输出流进行对接
					OutputStream os = new FileOutputStream(finalFile);
					IOUtils.copy(is, os);
//					释放资源
					IOUtils.closeQuietly(is);
					IOUtils.closeQuietly(os);
					
					map.put("pimage", "/products/3/"+dir+"/"+newFileName);
				}
			}
//			使用BeanUtils将map中数据填充到Product上
			Product product = new Product();
			BeanUtils.populate(product, map);
			product.setPid(UUIDUtils.getId());
			product.setPdate(new Date());
			product.setPflag(0);
			
//			调用业务层将数据写入数据库
			ProductService pService = new ProductServiceImp();
			pService.saveProduct(product);
			response.sendRedirect("/Demo16Store/AdminProductServlet?method=findAllProductsWithPage&pageNumber=1");
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
}
