<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body> 
<%--分页显示的开始 --%>
   
						<td colspan="7">
							第${ pageBean.pageNumber }/${ pageBean.totalPage }页 &nbsp; &nbsp; &nbsp;
							总记录数:${ pageBean.totalRecord }  &nbsp; 每页显示:${ pageBean.pageSize }
							<c:if test="${ pageBean.pageNumber != 1 }">
								<a href="${ pageContext.request.contextPath }/${pageBean.path }&pageNumber=1">首页</a>|
								<a href="${ pageContext.request.contextPath }/${pageBean.path }&pageNumber=${ pageBean.pageNumber - 1}">上一页</a>|
							</c:if>
							&nbsp; &nbsp;
							
							<c:forEach var="i" begin="1" end="${ pageBean.totalPage }">
								<c:if test="${ pageBean.pageNumber == i }">
									[${ i }]
								</c:if>
								<c:if test="${ pageBean.pageNumber != i }">
									<a href="${ pageContext.request.contextPath }/${pageBean.path }&pageNumber=${ i}">[${ i }]</a>
								</c:if>
							</c:forEach>
							
							&nbsp; &nbsp;
							<c:if test="${ pageBean.pageNumber != pageBean.totalPage }">
								<a href="${ pageContext.request.contextPath }/${pageBean.path }&pageNumber=${ pageBean.pageNumber + 1}">下一页</a>|
								<a href="${ pageContext.request.contextPath }/${pageBean.path }&pageNumber=${ pageBean.totalPage}">尾页</a>|
							</c:if>	
						</td>

    	<%--分页显示的结束--%>

</body>
</html>