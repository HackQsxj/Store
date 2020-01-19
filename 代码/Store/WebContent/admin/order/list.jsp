<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<HTML>
<HEAD>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/Style1.css"
	rel="stylesheet" type="text/css" />
<script language="javascript"
	src="${pageContext.request.contextPath}/js/public.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>

</HEAD>
<body>
	<br>
	<form id="Form1" name="Form1"
		action="${pageContext.request.contextPath}/user/list.jsp"
		method="post">
		<table cellSpacing="1" cellPadding="0" width="100%" align="center"
			bgColor="#f5fafe" border="0">
			<TBODY>
				<tr>
					<td class="ta_01" align="center" bgColor="#afd1f3"><strong>订单列表</strong>
					</TD>
				</tr>

				<c:if test="${empty allOrders }">
					<tr>
						<td>当前未存在该类订单</td>
					</tr>
				</c:if>
				<c:if test="${not empty allOrders }">
					<tr>
						<td class="ta_01" align="center" bgColor="#f5fafe">
							<table cellspacing="0" cellpadding="1" rules="all"
								bordercolor="gray" border="1" id="DataGrid1"
								style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; BORDER-LEFT: gray 1px solid; WIDTH: 100%; WORD-BREAK: break-all; BORDER-BOTTOM: gray 1px solid; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #f5fafe; WORD-WRAP: break-word">
								<tr
									style="FONT-WEIGHT: bold; FONT-SIZE: 12pt; HEIGHT: 25px; BACKGROUND-COLOR: #afd1f3">

									<td align="center" width="5%">序号</td>
									<td align="center" width="15%">订单编号</td>
									<td align="center" width="5%">订单金额</td>
									<td align="center" width="5%">收货人</td>
									<td align="center" width="5%">订单状态</td>
									<td align="center" width="65%">订单详情</td>
								</tr>
								<c:forEach items="${allOrders }" var="o" varStatus="status">
									<tr onmouseover="this.style.backgroundColor = 'white'"
										onmouseout="this.style.backgroundColor = '#F5FAFE';">
										<td style="CURSOR: hand; HEIGHT: 22px" align="center"
											width="5%">${status.count }</td>
										<td style="CURSOR: hand; HEIGHT: 22px" align="center"
											width="15%">${o.oid }</td>
										<td style="CURSOR: hand; HEIGHT: 22px" align="center"
											width="5%">${o.total }</td>
										<td style="CURSOR: hand; HEIGHT: 22px" align="center"
											width="5%">${o.name }</td>
										<td style="CURSOR: hand; HEIGHT: 22px" align="center"
											width="5%"><c:if test="${o.state==1 }">未付款</c:if> <c:if
												test="${o.state==2 }">
												<a href="/Demo16Store/AdminOrderServlet?method=updateOrderByOid&oid=${o.oid }">发货</a>
											</c:if> <c:if test="${o.state==3 }">已发货</c:if> <c:if
												test="${o.state==4 }">订单完成</c:if></td>
										<td align="center" style="HEIGHT: 22px">
											<input type="button" value="订单详情" width="60%" id="${o.oid }" class="myClass" />
											<table  width="100%" border="1px"></table>
										</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
				</c:if>
				<tr align="center">
					<td colspan="7"></td>
				</tr>
			</TBODY>
		</table>
	</form>
</body>
<script type="text/javascript">
	$(function(){
		//页面加载完成后,获取类元素,为其绑定点击事件
		$(".myClass").click(function(){
			//获取当前按钮文字
			var txt = this.value;
			//获取到当前元素的下一个对象
			var $tb = $(this).next();
			if(txt == "订单详情"){
				var id = this.id;
				//向服务端发起Ajax请求
				var url = "/Demo16Store/AdminOrderServlet";
				var obj = {"method":"findOrderByOidWithAjax",
							"id":id
							};
				$.post(url, obj, function(data){
					//alert(data);
					var th = "<tr><td>商品</td><td>名称</td><td>单价</td><td>数量</td></tr>";
					$tb.append(th);
					//利用JQuery遍历响应到客户端的数据
					$.each(data, function(i, obj){
						var td="<tr><td><img src='/Demo16Store/"+obj.product.pimage+"' width='50px' /></td><td>"+obj.product.pname+"</td><td>"+obj.product.shop_price+"</td><td>"+obj.quantity+"</td></tr>";	
						$tb.append(td);
					});
				}, "json");
				this.value="关闭";
			}else{
				this.value="订单详情";
				$tb.html("");
			}		
		});
	});
</script>
</HTML>

