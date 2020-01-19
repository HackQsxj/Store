<% 
	Option Explicit
	Response.Buffer = True
%>

<!-- #include file="language.txt" -->
<!-- #include file="conn.asp" -->
<html>
<head>
<title><!--#include file="webmailver.txt" --></title>

<style type = text/css>
	a:link {text-decoration:none; cursor: hand; color:#000000}
	a:visited {text-decoration:none; color:#333333}
	a:hover {text-decoration:underline; color:#000000}
	body,table {font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</style>
</head>
<body bgcolor="#fffff7">
<%
Dim rs, strSQL

	If (request("operator") = "add" and request("submit") = "增加") Then
		set rs=Server.createobject("adodb.recordset")
		rs.open "departmentinfo",Conn,1,3
		rs.addnew
		rs("name")=Trim(request("departname"))
		rs.update
		rs.Close
		set rs = nothing
		conn.close
		set conn = nothing
%>
<input type=button value="确定" onclick="javascript:window.location.replace('address.asp')">
<%	
		response.end
	End If

	If (request("operator") = "modify" and request("submit") = "修改") Then
		set rs=Server.createobject("adodb.recordset")
		strSQL = "select * from departmentinfo where id=" & request("id")
		rs.open strSQL, Conn, 1, 3
		rs("name")=Trim(request("departname"))
		rs.update
		rs.close
		set rs = nothing
		conn.close
		set conn = nothing
%>
<input type=button value="确定" onclick="javascript:window.location.replace('address.asp')">
<%
		response.end
	End If

	If request("operator") = "delete" Then
		Dim arrString, nI
		nI = 0
		arrString = Split(Request("deletestring"), ";", -1, 1)
	        While Len(arrString(nI)) <> 0 
			strSql =  "delete from departmentinfo where id=" & arrString(nI)
			conn.execute strSql,1,0
			nI = nI + 1
		Wend
		conn.close
		set conn = nothing
%>
<input type=button value="确定" onclick="javascript:window.location.replace('address.asp')">
<%
		response.end
	End If
%>
<form method=post name=department action="departmentm.asp">
<table width="100%" height="267" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#99CCFF">
	<tr>
	<td align="left" valign="top" bgcolor="#FFFFF7" width="100%">
	    <table border="0" cellpadding="5" cellspacing="1" bgcolor="#084563" align="center">
          <tr bgcolor="#084587"> 
            <td height="35" colspan="5"><font color="#EFFBFF"><img src="images/add.gif" width="14" height="14" hspace="10" align="absmiddle">添加部门</font></td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="27">&nbsp;</td>
            <td width="80"> 
              <div align="center">部门名称</div>
            </td>
            <td colspan="3" width="350"> 
              <input name="departname" type="text" value="<%=request("name")%>">
	      <input name="id" type="hidden" value="<%=request("id")%>">
            </td>
          </tr>
          <tr bgcolor="#F7F7F2"> 
            <td colspan="5">&nbsp;</td>
          </tr>
          <tr bgcolor="#F7F7F2"> 
            <td colspan="5"> 
              <div align="center"> 
<%if request("operator") = "add" then%>
                <input name="submit" type="submit" value="增加">
<%end if%>
<%if request("operator") = "modify" then%>
                <input name="submit" type="submit" value="修改">
<%end if%>
                <input type="reset">
		<input type=hidden name=operator value="<%=request("operator")%>">
	     </div>
            </td>
          </tr>
        </table>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	</td>
	</tr>
</table>
</form>
</body>
</html>