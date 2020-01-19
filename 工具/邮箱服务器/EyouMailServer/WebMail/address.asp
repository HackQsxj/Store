<% 
	Option Explicit
	Response.Buffer = True
%>

<!-- #include file="language.txt" -->
<!-- #include file="conn.asp" -->
<!-- #include file="encode.asp" -->

<html>
<head>
<title><!--#include file="webmailver.txt" --></title>

<style type = text/css>
	a:link {text-decoration:none; cursor: hand; color:#000000}
	a:visited {text-decoration:none; color:#333333}
	a:hover {text-decoration:underline; color:#000000}
	body,table {font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</style>

<script language=javascript>
<!--
	function CheckAll(v)
	{
		var i;
		for (i=0;i<document.forms[0].elements.length;i++)
		{
			var e = document.forms[0].elements[i];
			e.checked = v;
		}
	}

	function OnReply(mail)
	{
		document.forms("ReplyMail").Subject.value= "";
		document.forms("ReplyMail").Body.value = "" ;
		document.forms("ReplyMail").To.value = mail;
		document.forms("ReplyMail").submit()
	}

	function OnDelete()
	{
		var str, a, i;
		str = new String("");
		for(i = 0; i < document.forms[0].elements.length ; i ++)
		{
			var e = document.forms[0].elements[i];
			if(e.name == 'sel')
			{
				if ( e.checked == true)
				{
		   			a = e.value;
					str = str + a + ";";
				}
			}
		}
		if(str == "")
		{
			alert("<%=IDS_ALERT_NO_SELECTIONADDR%>")
		}
		else
		{
			if(confirm("<%=IDS_ALERT_DELETEADDR%>")==true)
			{
				document.forms[0].indexOfMail.value = str
				document.forms[0].action="addressc.asp";
				document.forms[0].act.value="del";
				document.forms[0].submit();
			}
		}
	}
//-->
</script>

</head>

<body bgcolor="#fffff7">
<table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray  bordercolordark=white>
	<tr bgcolor="#dcdcdc"  valign="left">
	<td width="100%"  height="100%" align="left" valign="top" bgcolor="#fffff7"> 
	<%
		Dim rsConn
		Dim strSql
		Dim nI

		If Session("LoginSuccess") = 1 Then
			Set rsConn = CreateObject("adodb.recordset")
			strSql = "select * from address where account='" & Session("Account") & "' order by name"
			rsConn.open strSql, conn, 1, 2
	%>
		<form action="" method=post align="left">
		<table width="100%">
			<tr>
			<td valign=center width="100%" height="1"><%=IDS_ARE_ADDR%>&nbsp;<%=rsConn.RecordCount%>&nbsp;<%=IDS_ADD_NUMBER%>.</td>
			</tr>
		</table>
		<table width="100%" border="0" cellpadding="4" cellspacing="1" bordercolordark=white bgcolor="#c7dff4">
			<tr valign=middle bgcolor="#ffffff"> 
			<td width="24" align="center"> <font color="#ffffff"><b>
				<input name=chkall  onclick=CheckAll(document.forms[0].chkall[0].checked) type=checkbox value=on>
			</b></font></td>
			<td width="116">
				<div align="center"><font color="#000000"><%=IDS_NAME%></font></div>
			</td>
			<td width="193">
				<div align="center"><font color="#000000"><%=IDS_MAILURL%></font></div>
			</td>
			<td width="111">
				<div align="center"><font color="#000000"><%=IDS_SECTION%></font></div>
			</td>
			<td width="99">
				<div align="center"><font color="#000000"><%=IDS_QQNO%></font></div>
			</td>
			<td width="100%"><font color="#00000">&nbsp;<%=IDS_CONTENT%></font> 
			</td>
			</tr>
	<%
			Dim nCurPage
			Dim nCurNo
			Dim nCurCur
			Dim nAddressCount

			nAddressCount = rsConn.RecordCount
			nCurPage = 1
			nCurNo = 1
			nCurCur = 1

	  		If Request("pages")<>"" Then
				nCurPage=CInt(Request("pages"))
			End If
			nCurNo = (nCurPage-1) * Session("maxlist") + 1

			For nI = 1 To nCurNo - 1
				rsConn.MoveNext
			Next

			Do While ( nCurNo <= nAddressCount ) And ( nCurCur <= Session("maxlist") )
  
	%>
			<tr bgcolor="#eff9fe"> 
			<td width="24" height=1 align=center valign=top><b>
				<Input name=sel type=checkbox value="<%=rsConn("addressid")%>">
			</b></td>
			<td width="116">
				<div align="center"><a href="addressm.asp?addressid=<%=rsConn("addressid")%>"> 
	<%
				If Len(rsConn("name")) > 20 Then
					Response.Write HTMLEncode(Left(rsConn("name"), 20 - 4) & "...")
				Else
        					Response.Write HTMLEncode(rsConn("name"))
				End If
	%>
				</a></div>
			</td>
			<td width="193">
				<div align="center"><a href="javascript:OnReply('<%=rsConn("mail")%>')">
	<%
				If Len(rsConn("name")) > 30 Then
					Response.Write HTMLEncode(Left(rsConn("mail"), 30 - 4) & "...")
				Else
        					Response.Write HTMLEncode(rsConn("mail"))
				End If
	%>
				</a></div>
			</td>
			<td width="111">
				<div align="center"><%=HTMLEncode(rsConn("city"))%></div>
			</td>
			<td width="99">
				<div align="center"><%=rsConn("qq")%></div>
			</td>
			<td> &nbsp;<%=HTMLEncode(rsConn("content"))%></td>
			</tr>
	<%
				rsConn.MoveNext
				nCurCur = nCurCur + 1
				nCurNo = nCurNo + 1
			Loop
	%>
			<tr bgcolor="#ffffff">
			<td height="0"><img height="0" width="24" src="spacer.gif" border=0></td>
			<td><img height="0" width="116" src="spacer.gif" border=0></td>
			<td><img height="0" width="193" src="spacer.gif" border=0></td>
			<td><img height="0" width="111" src="spacer.gif" border=0></td>
			<td><img height="0" width="99" src="spacer.gif" border=0></td>
			<td></td>
			</tr>
		</table>
		<table width="100%">
			<tr>
			<td align=left valign=top width="100%"><b>
				<input name=chkall  onclick=CheckAll(document.forms[0].chkall[1].checked) type=checkbox value=on>
				</b><font color=#cc3366><%=IDS_SELECT_ALL%></font>
				<a href="javascript:OnDelete()"><img src="images/delete.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_DELETE%></a>&nbsp;
				<a href="addressm.asp"><img src="images/add.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_ADDADDR%></a>
			</td>
			</tr>
		</table>
		<input type = hidden value = "-1" name=indexOfMail id=indexOfMail>
		<input name="subpage" type="hidden" id="subpage" value="address">
		<input name="act" type="hidden" value="none">
		</form>
	<%
			rsConn.Close
			Set rsConn = Nothing
		End If
		conn.Close
		Set conn = Nothing
	%>
	</td>
	</tr>
	<%
		If nAddressCount > Session("maxlist") Then
			Dim nPages
			nPages = nAddressCount \ Session("maxlist") + 1
	%>
	<tr bgcolor="#dcdcdc"  valign="left">
	<td valign="top" bgcolor="#fffff7"  height="100%">
	<div align="center"> >>
	<%
		For nI=1 To nPages
	%>&nbsp; 
	<%If nI<> nCurPage Then%>
	<a href="address.asp?pages=<%=nI%>"><%=nI%></a>
	<%Else%>
				<b><%=nI%></b> 	
				
			<%End If%>
	&nbsp;
	<%
		Next
	%><< </div>
	</td>
	</tr>
	<% 
		End If
	%>
</table>

<form action="sendmail.asp" method=Post name="ReplyMail">
	<input type=Hidden name=Subject value="">
	<input type=Hidden name=To value="">
	<input type=Hidden name=Body value="">
</form>
</body>
</html>
