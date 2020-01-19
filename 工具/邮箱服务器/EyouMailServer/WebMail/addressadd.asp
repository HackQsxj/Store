<% 
	Option Explicit
	Response.Buffer = True
%>

<!-- #include file="encode.asp" -->
<!-- #include file=language.txt -->
<!-- #include file=conn.asp -->

<html>
<head>
<title><!--#include file="webmailver.txt" --></title>
<style type = text/css>
	a:link {text-decoration:none; cursor: hand}
	a:visited {text-decoration:none}
	a:hover {text-decoration:underline}
	body,table {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</style>
<script language="javascript">
<!--
function Update(where)
{
	var e1,e2,e3;
	e1 = "";
	e2 = "";
	e3 =  "";
	if ((where == 'to')||(where=='all'))
		e1 = window.opener.document.sm.To.value;
	if ((where == 'cc')||(where=='all'))
		e2 = window.opener.document.sm.Cc.value;
	if ((where == 'bcc')||(where=='all'))
		e3 = window.opener.document.sm.Bcc.value;

	for (var i = 0; i < document.addr.elements.length; i++)
	{
		var e = document.addr.elements[i];
		if ((e.name.indexOf('to:')==0) && (e.checked) && (e1.indexOf(e.value)==-1))
		{
			if (e1) e1 += ";";
			e1 += e.value;
		}
		if ((e.name.indexOf('cc:')==0) && (e.checked) && (e2.indexOf(e.value) == -1))
		{
			if (e2)	e2 += ";";
			e2 += e.value;
		}
		if ((e.name.indexOf('bcc:')==0) && (e.checked) && (e3.indexOf(e.value) == -1))
		{
			if (e3)	e3 += ";";
			e3 += e.value;
		}

	}

	if ((where == 'to')||(where == 'all'))
		window.opener.document.sm.To.value = e1;
	if ((where == 'cc')||(where == 'all'))
		window.opener.document.sm.Cc.value = e2;
	if ((where == 'bcc')||(where == 'all'))
		window.opener.document.sm.Bcc.value = e3;
    window.close();
}
//-->
</script>
</head>
<body bgColor=#ECF8FF alink=#333333 vlink=#000000 link=#000000>
<table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray  bordercolordark=white>
	<tr bgcolor="#dcdcdc"  valign="left">
	<td width="100%"  height="100%" align="left" valign="top" bgcolor="#EFFBFF"> 
<%
	Dim rs
	Dim strSql
	Dim nI

	If Session("LoginSuccess")= 1 Then
		set rs=createobject("adodb.recordset")
		strSql="select * from address where account='" & Session("Account") & "' order by name"
		rs.open strSql,Conn,1,2
%>
		<form name="addr" method="post" action="javascript:Update('all')" >
		<table width="100%" >
			<tr>
			<td valign=center height="1" width="100%">
				<font color="#EFFBFF"><img src="images/add.gif" width="14" height="14" hspace="10" align="absmiddle"></font><%=IDS_ARE_ADDR%>&nbsp;<%=rs.recordcount%>&nbsp;<%=IDS_ADD_NUMBER%>.
				<%=IDS_ADDR_TOTAL%>&nbsp;100&nbsp;<%=IDS_ADD_NUMBER%>
			</td>
			</tr>
		</table>
		<table width="100%" border="0" cellpadding="4" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor=#084563>
			<tr valign=middle bgcolor="#084584">
			<td width="36" align="center" ><font color="#FFFFFF"><span ><%=IDS_RECEIVER%></span></font></td>
			<td width="34" align="center" ><font color="#FFFFFF"><span ><%=IDS_CC%></span></font></td>
			<td width="34" align="center" ><font color="#FFFFFF"><%=IDS_BCC%></font></td>
			<td width="141">
				<div align="center"><font color="#FFFFFF"><%=IDS_NAME%></font></div>
			</td>
			<td width="100%">
				<div align="center"><font color="#FFFFFF"><%=IDS_MAILURL%></font></div>
			</td>
			</tr>
<%
		Dim nCurPage
		Dim nCurNo
		Dim nCurCur
		Dim nAddressCount
		
		nAddressCount = RS.recordcount
		nCurPage = 1
		nCurNo = 1
		nCurCur = 1
		
  		If Request.QueryString("pages")<>"" Then
			nCurpage=cint(Request.QueryString("pages"))
		End If
		nCurNo = (nCurPage-1) * session("maxlist") + 1
		For nI = 1 To nCurNo - 1
			rs.movenext
		Next
		
		Do While (nCurNo <= nAddressCount) And (nCurCur<=Session("maxlist"))
%>
			<tr bgcolor="#F7F7F7">
			<td width="36" align=center valign=top> 
				<div align="center">
				<input name="to:<%=rs("name")%>" type=checkbox  value="<%=rs("mail")%>">
				</div>
			</td>
			<td width="34" align=center valign=top>
				<div align="center">
				<input name="cc:<%=rs("name")%>" type=checkbox  value="<%=rs("mail")%>">
				</div>
			</td>
			<td width="34" height=1 align=center valign=top>
				<div align="center">
				<input name="bcc:<%=rs("name")%>" type=checkbox  value="<%=rs("mail")%>">
				</div>
			</td>
			<td width="141">
				<div align="center">
<%
			If Len(rs("name")) > 20 Then
				Response.Write HTMLEncode(Left(rs("name"), 20 - 4) & "...")
			Else
        				Response.Write HTMLEncode(rs("name"))
			End If
%>
				</div>
			</td>
			<td> 
				<div align="center">
<%
			If Len(rs("mail")) > 20 Then
				Response.Write HTMLEncode(Left(rs("mail"), 20 - 4) & "...")
			Else
        				Response.Write HTMLEncode(rs("mail"))
			End If
%>
				</div>
			</td>
			</tr>
<%
			rs.movenext
			nCurCur = nCurCur + 1
			nCurNo = nCurNo + 1 
	    	Loop
%>
			<tr  bgcolor="#FFFFFF"> 
			<td height="0"><img height="0" width="36" src="spacer.gif"></td>
			<td><img height="0" width="34" src="spacer.gif"></td>
			<td><img height="0" width="34" src="spacer.gif"></td>
			<td><img height="0" width="141" src="spacer.gif"></td>
			<td></td>
			</tr>
		</table>
		<table width="100%">
			<tr> 
			<td align=left valign=middle width="100%">
				<div align="center">
				<input type="submit" onClick="javascript:Update('all')" value="<%=IDS_ok%>">
				&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 
				<input type="reset">
				</div>
			</td>
			</tr>
		</table>
		</form>
<%
		rs.Close
		Set rs = Nothing
	End If
	conn.Close
	Set conn = Nothing
%>
	</td>
	</tr>
<%
	If nAddressCount>session("maxlist") Then
		Dim nPages
		nPages = nAddressCount \ Session("maxlist")+1
%>
<% 
	End If
%>
</table>
     
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr  valign="left" >
	<td valign="top"  height="100%" width="100%">
		<div align="center">>>
<%
	For nI=1 To nPages 
%>&nbsp; 
	<%If nI<> nCurPage Then%>
	<a href="addressadd.asp?pages=<%=nI%>"><%=nI%></a>
	<%Else%>
				<b><%=nI%></b> 	
				
			<%End If%>
	&nbsp;&nbsp;
<%
	Next
%><< &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
	</td>
	</tr>
</table>
</body>
</html>

