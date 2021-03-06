﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>XXX网络商城</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		
	</head>

	<body>
		<div class="container-fluid">

			<!--
            	描述：菜单栏
            -->
			<div class="container-fluid">
				<div class="col-md-4">
					<img src="${pageContext.request.contextPath}/img/logo2.png" />
				</div>
				<div class="col-md-5">
					<img src="${pageContext.request.contextPath}/img/header.png" />
				</div>
				<div class="col-md-3" style="padding-top:20px">
					<ol class="list-inline">
						<c:if test="${empty loginUser}">
							<li><a href="${pageContext.request.contextPath}/jsp/login.jsp">登录</a></li>
							<li><a href="${pageContext.request.contextPath}/jsp/register.jsp">注册</a></li>
						</c:if>
						<c:if test="${not empty loginUser}">
						<li>欢迎${loginUser.name }</li>
						<li><a href="${pageContext.request.contextPath}/UserServlet?method=logout">退出</a></li>
						<li><a href="${pageContext.request.contextPath}/jsp/cart.jsp">购物车</a></li>
						<li><a href="${pageContext.request.contextPath}/OrderServlet?method=findMyOrdersWithPage&pageNumber=1">我的订单</a></li>
						</c:if>						
					</ol>
				</div>
			</div>
			<!--
            	描述：导航条
            -->
			<div class="container-fluid">
				<nav class="navbar navbar-inverse">
					<div class="container-fluid">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
							<a class="navbar-brand" href="#">首页</a>
						</div>

						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav" id="myUL">
								<%-- <c:forEach items="${allCates }" var="c">
									<li><a href="#">${c.cname }</a></li>
								</c:forEach> --%>
							</ul>
							<form class="navbar-form navbar-right" role="search">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Search">
								</div>
								<button type="submit" class="btn btn-default">Submit</button>
							</form>

						</div>
						<!-- /.navbar-collapse -->
					</div>
					<!-- /.container-fluid -->
				</nav>
			</div>
		</div>
	</body>
	<script type="text/javascript">
			$(function(){
				/* 当页面加载完后，向服务端发起Ajax请求，服务端经过处理
					将所有分类信息以JSON格式的数据返回，客户端获取到所有分类
					绑定在页面的显示分类区域
				*/
				var url = "/Demo16Store/CategoryServlet";
				var obj = {"method":"findAllCates"};
				$.post(url, obj, function(data){
					/* alert(data); */
					//获取到服务端响应回来的数据，经过观察data中存放的是一个JSON格式数组，遍历数组动态显示分类区域
					
					$.each(data, function(i, obj){
						var li = "<li><a href='${pageContext.request.contextPath}/ProductServlet?method=findByCid&pageNumber=1&cid="+obj.cid+"'>"+obj.cname+"</a></li>";
						$("#myUL").append(li);
					});
				}, "json");
			});
		</script>
</html>