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
<script language="javascript">
function addlist(from, to)
{
	nSelected = document.forms("group").item(from).selectedIndex;
	if(nSelected < 0)
		return;
	op = document.createElement("OPTION");
	op.value = document.forms("group").item(from).options(nSelected).value;
	op.text = document.forms("group").item(from).options(nSelected).text;
	document.forms("group").item(to).add(op);
	document.forms("group").item(to).size = document.forms("group").item(to).length + 1;
	document.forms("group").item(from).remove(nSelected);
}

function submitlist()
{
	document.forms("group").item("addressidlist").value = "";
	for(i = 0; i < document.forms("group").item("memberlist").length; i++)
		document.forms("group").item("addressidlist").value += (document.forms("group").item("memberlist").options(i).value + ";");
}

</script>
</head>
<body bgcolor="#fffff7">
<%
Dim rs, strSQL, arrString, nI

	If (request("operator") = "add" and request("submit") = "增加") Then
		set rs=Server.createobject("adodb.recordset")
		rs.open "groupinfo",Conn,1,3
		rs.addnew
		rs("name")=Trim(request("groupname"))
		rs("account")=Session("account")
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
		strSQL = "select * from groupinfo where id=" & request("id")
		rs.open strSQL, Conn, 1, 3
		rs("name")=Trim(request("groupname"))
		rs("account")=Session("account")
		rs.update
		rs.close
		strSQL = "delete from [group] where groupid=" & request("id")
		conn.execute strSQL,1,0
		rs.open "[group]",Conn,1,3
		nI = 0
		if request("addressidlist") <> "" then
			arrString = Split(request("addressidlist"), ";", -1, 1)
			while len(arrString(nI)) <> 0
				rs.addnew
				rs("addressid")=arrString(nI)
				rs("groupid")=request("id")
				rs.update
				nI = nI + 1
			wend
		end if
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
		nI = 0
		arrString = Split(Request("deletestring"), ";", -1, 1)
	        While Len(arrString(nI)) <> 0 
			strSQL = "delete from groupinfo where id=" & arrString(nI)
			conn.execute strSQL,1,0
			strSQL = "delete from [group] where groupid=" & arrString(nI)
			conn.execute strSQL, 1, 0
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
<form method=post name=group action="groupm.asp">
<table width="100%" height="267" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#99CCFF">
	<tr>
	<td align="left" valign="top" bgcolor="#FFFFF7" width="100%">
	    <table border="0" cellpadding="5" cellspacing="1" bgcolor="#084563" align="center">
          <tr bgcolor="#084587"> 
            <td height="35" colspan="5"><font color="#EFFBFF"><img src="images/add.gif" width="14" height="14" hspace="10" align="absmiddle">添加群组</font></td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="27">&nbsp;</td>
            <td width="80"> 
              <div align="center">群组名称</div>
            </td>
            <td colspan="3" width="350"> 
              <input name="groupname" type="text" value="<%=request("name")%>">
	      <input name="id" type="hidden" value="<%=request("id")%>">
            </td>
          </tr>
          <tr bgcolor="#F7F7F2"> 
            <td colspan="5">&nbsp;</td>
          </tr>
<%if request("operator") = "modify" then%>
	  <tr bgcolor="#EFFBFF">
	  <td colspan="5">
邮件地址列表<br>
<%
		set rs=Server.createobject("adodb.recordset")
		strSQL = "select * from address where account='" & session("account") & "' and address.addressid not in (select group.addressid from [group] where address.addressid=group.addressid and groupid=" & request("id") &")"
		rs.open strSQL, Conn, 1, 2
%>
<select name="addresslist" size="<%=rs.RecordCount+1%>" ondblclick="javascript:addlist('addresslist', 'memberlist')">
<%
		For nI = 1 to rs.RecordCount
%>
            <option value="<%=rs("addressid")%>" >"<%=rs("name")%>" <%=server.htmlencode(rs("mail"))%></option>
<%
			rs.MoveNext
		Next
		rs.close
%>
          </select><br>
成员列表<br>
<%
		strSQL = "select * from address where account='" & session("account") & "' and address.addressid in (select group.addressid from [group] where group.addressid = address.addressid and groupid=" & request("id") &")"
		rs.open strSQL, Conn, 1, 2
%>
          <select name="memberlist" size="<%=rs.RecordCount+1%>" ondblclick="javascript:addlist('memberlist', 'addresslist')">
<%
		For nI = 1 to rs.RecordCount
%>
            <option value="<%=rs("addressid")%>">"<%=rs("name")%>" <%=server.htmlencode(rs("mail"))%></option>
<%
			rs.MoveNext
		Next
		rs.close
		set rs = nothing
		conn.close
		set conn = nothing
%>
          </select>
	  </td>
	</tr>
<%end if%>
          <tr bgcolor="#F7F7F2"> 
            <td colspan="5"> 
              <div align="center"> 
<%if request("operator") = "add" then%>
                <input name="submit" type="submit" value="增加">
<%end if%>
<%if request("operator") = "modify" then%>
                <input name="submit" type="submit" value="修改" onclick="javascript:submitlist()">
<%end if%>
                <input type="reset">
		<input type=hidden name=operator value="<%=request("operator")%>">
	     </div>
            </td>
          </tr>
        </table>
      </td>
	</tr>
</table>
<input type=hidden name="addressidlist" value="">
</form>
</body>
</html>