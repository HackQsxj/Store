<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>商品列表</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		<!-- 引入自定义css文件 style.css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>

		<style>
			body {
				margin-top: 20px;
				margin: 0 auto;
				width: 100%;
			}
			.carousel-inner .item img {
				width: 100%;
				height: 300px;
			}
		</style>
	</head>

	<body>
		
			<%@include file="/jsp/header.jsp"%>

		<c:if test="${empty pageBean.list}">
        	<div class="row" style="width:1210px;margin:0 auto;">
        		<div class="col-md-12">
        			<h1>暂无商品信息</h1>
        		</div>
        	</div>	
        </c:if>
		
		<c:if test="${not empty pageBean.list}">
		<div class="row" style="width:1210px;margin:0 auto;">
			<div class="col-md-12">
				<ol class="breadcrumb">
					<li><a href="#">首页</a></li>
				</ol>
			</div>
			<c:forEach items="${pageBean.list }" var="product">
				<div class="col-md-2">
					<a href="${pageContext.request.contextPath}/ProductServlet?method=findProductById&pid=${product.pid}">
						<img src="${pageContext.request.contextPath}/${product.pimage}" width="170" height="170" style="display: inline-block;">
					</a>
				<p>
					<a href="${pageContext.request.contextPath}/ProductServlet?method=findProductById&pid=${product.pid}" style='color:green'>
						<c:if test="${fn:length(product.pname) lt 20 }">${product.pname }</c:if>
						<c:if test="${fn:length(product.pname)ge 20 }">${fn:substring(product.pname, 0, 20) }</c:if>
					</a>
				</p>
				<p><font color="#FF0000">商城价：&yen;${product.shop_price }</font></p>
			</div>
			</c:forEach>

		</div>
		<!--分页 -->
		<div style="width:380px;margin:0 auto;margin-top:50px;">
			<ul class="pagination" style="text-align:center; margin-top:10px;">
				<li class="disabled">
					<a href="${pageContext.request.contextPath}/${pageBean.path }&pageNumber=${pageBean.prePageNum}" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
				
				<c:forEach begin="${pageBean.startPage}" end="${pageBean.endPage}" var="pagenum">
    		   			<li ><a href="${pageContext.request.contextPath}/${pageBean.path }&pageNumber=${pagenum}">${pagenum}</a></li>

    			</c:forEach>
				
				<li class="disabled">
					<a href="${pageContext.request.contextPath}/${pageBean.path }&pageNumber=${pageBean.nextPageNum}" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</ul>
		</div>
		<!-- 分页结束=======================        -->
		</c:if>
		
		

		<!--
       		商品浏览记录:
        -->
		<div style="width:1210px;margin:0 auto; padding: 0 9px;border: 1px solid #ddd;border-top: 2px solid #999;height: 246px;">

			<h4 style="width: 50%;float: left;font: 14px/30px " 微软雅黑 ";">浏览记录</h4>
			<div style="width: 50%;float: right;text-align: right;"><a href="">more</a></div>
			<div style="clear: both;"></div>

			<div style="overflow: hidden;">

				<ul style="list-style: none;">
					<li style="width: 150px;height: 216;float: left;margin: 0 8px 0 0;padding: 0 18px 15px;text-align: center;"><img src="${pageContext.request.contextPath}/products/1/cs10001.jpg" width="130px" height="130px" /></li>
				</ul>

			</div>
		</div>
		<%@include file="/jsp/footer.jsp"%>

	</body>

</html>