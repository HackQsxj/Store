<% 
	Option Explicit
	Response.Buffer = True
%>

<!-- #include file="language.txt" -->
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
			alert("<%=IDS_ALERT_NO_SELECTION_ACCOUNT%>")
		}
		else
		{
			if(confirm("<%=IDS_ALERT_DELETE_ACCOUNT%>")==true)
			{
				document.forms[1].userlist.value = str
				document.forms[1].action="adminm.asp";
				document.forms[1].add.value="-1";
				document.forms[1].submit();
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
		Dim objAdmin
		Dim nAccountCount
		If Session("LoginSuccess") = 1 And Session("Admin") <> 0 Then
			Set objAdmin = CreateObject("CMailCOM.Admin.1")
			objAdmin.AuthLogin Session("User"), Session("Pass")
			If Left(objAdmin.LastResponse, 3) <> "+OK" Then
				Response.Write objAdmin.LastResponse
				Response.End
			End If

			objAdmin.Open Session("Domain"), "AccountListInfo"
			If Left(objAdmin.LastResponse, 3) <> "+OK" Then
				Response.Write objAdmin.LastResponse
				Response.End
			End If
			nAccountCount = objAdmin.Count
			
%>
		<form align="left">
		<table width="100%">
			<tr>
			<td valign=center width="100%" height="1"><%=IDS_TOTAL_USER%>&nbsp;<%=nAccountCount%>&nbsp;<%=IDS_USERS%>.</td>
			</tr>
		</table>
		<table width="100%" border="0" cellpadding="4" cellspacing="1" bordercolordark=white bgcolor="#c7dff4">
			<tr valign=middle bgcolor="#ffffff"> 
			<td align="center"> <font color="#ffffff"><b> 
				<input name=chkall  onclick=CheckAll(document.forms[0].chkall[0].checked) type=checkbox value=on>
			</b></font> </td>
			<td > 
				<div align="center"><font color="#000000"><%=IDS_ACCOUNT%></font></div>
			</td>
			<td > 
				<div align="center"><font color="#000000"><%=IDS_NAME%></font></div>
			</td>
			<td > 
				<div align="center"><font color="#000000"><%=IDS_USED_SPACE%></font></div>
			</td>
			<td > 
				<div align="center"><font color="#000000"><%=IDS_TOTAL_CONTENT%></font></div>
			</td>
			<td> 
				<div align="center"><font color="#000000"><%=IDS_MAIL_COUNT%></font></div>
			</td>
			<td > <font color="#00000">&nbsp;<%=IDS_LAST_VISITED_TIME%></font> </td>
			<td> <font color="#00000">&nbsp;<%=IDS_ENABLED_ACCOUNT%></font> </td>
			<td width="100%"> <font color="#00000">&nbsp;<%=IDS_COMMENT%></font> </td>
			</td>
			</tr>
<%
			Dim nCurPage
			Dim nCurNo
			Dim nCurCur

			nCurPage = 1
			nCurNo = 1
			nCurCur = 1

	  		If Request("pages")<>"" Then
				nCurPage=CInt(Request("pages"))
			End If
			nCurNo = (nCurPage-1) * Session("maxlist") + 1
			
			
			Dim objAccount
			Set objAccount = CreateObject("CMailCOM.Admin.1")
			objAccount.AuthLogin Session("User"), Session("Pass")
			Do While ( nCurNo <= nAccountCount ) And ( nCurCur <= Session("maxlist") )
				Dim strAccount, strUserName, strUsed, strSize, strUnlimited, strMesg, strTime, strEnable, strComm
				objAdmin.GetData nCurNo
				strAccount = objAdmin.Value("Account")
				objAccount.Open strAccount, "AccountInfo"
				strUserName = objAccount.Value("UserName")
				strUsed = objAccount.Value("Used")
				strSize = objAccount.Value("Size")
				strUnlimited = objAccount.Value("MaxSize")
				strMesg = objAccount.Value("MailCount")
				strTime = objAccount.Value("LastVisitedTime")
				strEnable = objAccount.Value("Enable")
				strComm = objAccount.Value("Comment")
%>
			<tr bgcolor="#eff9fe"> 
			<td height=1 align=center valign=top> <b> 
				<input name=sel type=checkbox value="<%=strAccount%>">
			</b></td>
			<td> 
				<div align="center"><a href="adminm.asp?Account=<%=strAccount%>&Add=0"> 
				<u><%=strAccount%></u> </a></div>
			</td>
			<td> 
				<div align="center"><%=strUserName%></div>
			</td>
			<td> 
				<div align="center"><%=strUsed%></div>
			</td>
			<td> 
				<div align="center"><%If CInt(strUnlimited) = 0 Then%><%=strSize%><%Else%><%=IDS_UNLIMITED%><%End If%></div>
			</td>
			<td> 
				<div align="center"><%=strMesg%></div>
			</td>
			<td> &nbsp;<%=strTime%> </td>
			<td> &nbsp;<%If strEnable = "1" Then Response.Write(IDS_ENABLED) Else Response.Write(IDS_DISABLED) %> </td>
			<td> &nbsp;<%=strComm%> </td>
			</tr>
<%
				nCurCur = nCurCur + 1
				nCurNo = nCurNo + 1
			Loop
%>
         
			<tr bgcolor=#ffffff> 
			<td height="9"><img height="1" width="25" src="spacer.gif"></td>
			<td><img height="1" width="86" src="spacer.gif"></td>
			<td><img height="1" width="91" src="spacer.gif"></td>
			<td><img height="1" width="51" src="spacer.gif"></td>
			<td><img height="1" width="45" src="spacer.gif"></td>
			<td><img height="1" width="45" src="spacer.gif"></td>
			<td><img height="1" width="155" src="spacer.gif"></td>
			<td><img height="1" width="51" src="spacer.gif"></td>
			<td></td>
			</tr>
		</table>
		<table width="100%">
			<tr> 
			<td align=left valign=top width="100%"> <b> 
				<input name=chkall  onclick=CheckAll(document.forms[0].chkall[1].checked) type=checkbox value=on>
				</b> <font color=#cc3366><%=IDS_SELECT_ALL%></font> <a href="javascript:OnDelete()"> 
				<img src="images/delete.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_DELETE%></a>&nbsp; 
				<a href="adminm.asp?Add=1"><img src="images/add.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_ADD_ACCOUNT%></a> 
			</td>
			</tr>
		</table>
		</form>
		<form active="adminm.asp" method="post">
			<input name="userlist" type="hidden" value="">
			<input name="add" type="hidden" value="0">
		</form>
<%
			objAdmin.Close
			Set objAdmin = Nothing
		End If
%>
		</td>
		</tr>
<%
		If nAccountCount > Session("maxlist") Then
			Dim nPages
			nPages = nAccountCount \ Session("maxlist") + 1
%>
		<tr bgcolor="#dcdcdc"  valign="left">
		<td valign="top" bgcolor="#fffff7"  height="100%"> 
			<div align="center"> >> 
<% 
		For nI=1 To nPages 
%>&nbsp; 
<%
			If nI<> nCurPage Then 
%>
			<a href="admin.asp?pages=<%=nI%>"><%=nI%></a>
<%
			Else
				Response.Write nI
			End If
%>&nbsp;
<%
		Next
%><< 
			</div>
		</td>
		</tr>
<%
	End if
%>
	</table>
</body>
</html>