<% 
	Option Explicit
	Response.Buffer = True
%>
<!-- #include file=language.txt -->
<!-- #include file=conn.asp -->
<!-- #include file="encode.asp" -->
<html>
<head>
<title><!--#include file="webmailver.txt" --></title>
<style type = text/css>
	a:link {text-decoration:none; cursor: hand}
	a:visited {text-decoration:none}
	a:hover {text-decoration:underline}
	body,table {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</style>
<script>
<!--
function ischeck(fm)
{
	var i;
	var j;
	comment=new Array(5);
	comment[0]=fm.name;
	comment[1]=fm.mail;
	comment[2]=fm.city;
	comment[3]=fm.qq;
	comment[4]=fm.content;
	strArr=new Array(5);
	strArr[0]="<%=IDS_NAME%>";
	strArr[1]="<%=IDS_MAILURL%>";
	strArr[2]="<%=IDS_SECTION%>";
	strArr[3]="<%=IDS_QQNO%>";
	strArr[4]="<%=IDS_CONTENT%>";

	if(fm.mail.value!="") 
	{
		email=fm.mail.value.split("@");
		if(email.length!=2) 
		{ 
			alert("<%=IDS_ERR_MAILURL%>.");
			return false;
		}
		else
		{
			email2=email[1].split(".");
			if(email2.length<2)
			{
				alert("<%=IDS_ERR_MAILURL%>.");
				return false;
			}
		}
	}
	else
	{
		alert("<%=IDS_ERR_NULLMAIL%>.");
		return false;
	}

	if(fm.name.value =="")
	{
		alert("<%=IDS_ERR_NULLNAME%>.");
		return false;
	}

	for(j=0;j<5;j++)
	{
		var length=comment[j].value.length;
		var char;
		var flag=0;
		for(i=0;i<length;i++)
		{
			char=comment[j].value.substring(i,i+1);
			if(char=="$")
			{
				flag=1;
				break;
			}
			else if(char=="#")
			{
				flag=1;
				break;
			}
			else if(char=="&")
			{
				flag=1;
				break;
			}
			else if(char=="%")
			{
				flag=1;
				break;
			}
			else if(char=="^")
			{
				flag=1;
				break;
			}
			else if(char=="\"")
			{
				flag=1;
				break;
			}
			else if(char=="~")
			{
				flag=1;
				break;
			}
		}

		if(flag==0)
		{
			continue;
		}
		else
		{
			alert(strArr[j]+"<%=IDS_ERR_USE%> $,#,&,%,^,\",~,");
			return false;
		}
	}
}
//-->
</script>
</head>
<%
	Dim i
	Dim arrString

	If Session("LoginSuccess") = 1 Then
		Dim StrName
		Dim StrMail
		Dim StrCity
		Dim StrQq
		Dim Scontent
		Dim StrSql
		Dim rs
		Dim StrActpage
		Dim nAddressID
		StrName = ""
		nAddressID = -1
		If Request("addressid")<>"" Then
			nAddressID = Request("addressid")
		End If 
		If Request("mail")<>"" Then
			StrMail = Request("mail")
			Dim MyString
			StrMail = Replace(StrMail, "&lt;", "<")
			StrMail = Replace(StrMail, "&gt;", ">")
			StrMail = Replace(StrMail, "&quot;", """")
			MyString = Split(StrMail, "<")
			If UBound(MyString)>0 Then
				StrName=MyString(0)
				StrName = Replace(strName, """", "")
				StrMail = "<"+MyString(1)
			End if
			StrMail = Replace(StrMail, "<", "")
			StrMail = Replace(StrMail, ">", "")
			StrMail = HTMLEncode(strMail) 
			StrName = HTMLEncode(strName)
		End If 
		Set rs=Server.createobject("adodb.recordset")
		StrSql = "select * from address where account='" & Session("Account") & "' and addressid=" & nAddressID
		rs.open StrSql,Conn,1,2
		If rs.recordcount = 1 Then 
			StrActpage = IDS_MODI
			nAddressID = rs("addressid")
			StrName = rs("name")
			StrMail = rs("mail")
			StrCity = rs("city")
			StrQq  = rs("qq")
			Scontent= rs("content")		  
		Else
			StrActpage = IDS_ADD
			nAddressID = ""
			StrCity = ""
			StrQq = ""
			Scontent= ""
		End If

		rs.Close
%>
<body bgcolor="#FFFFF7">
<form name="addfm" method="post" action="addressc.asp">
<table width="100%" height="267" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#99CCFF">
	<tr>
	<td align="left" valign="top" bgcolor="#FFFFF7" width="100%">
	<table border="0" cellpadding="5" cellspacing="1" bgcolor="#084563" align="center">
		<tr bgcolor="#084587" style="background-image: url(images/addback.gif);background-repeat:no-repeat;background-position: right;">
		<td height="35" colspan="5"><font color="#EFFBFF"><img src="images/add.gif" width="14" height="14" hspace="10" align="absmiddle"><%=StrActpage%><%=IDS_ADDRESS%></font></td>
		</tr>
		<tr bgcolor="#EFFBFF">
		<td width="27">&nbsp;</td>
		<td width="80">
			<div align="center"><%=IDS_NAME%></div>
		</td>
		<td width="229">
			<input name="name" type="text" value="<%=StrName%>" size="25" maxlength="40">
		</td>
		<td width="83">
			<div align="center"><%=IDS_MAILURL%></div>
		</td>
		<td width="247">
			<input name="mail" type="text" value="<%=StrMail%>" size="25" maxlength="40">
		</td>
		</tr>
		<tr bgcolor="#F7F7F2">
		<td colspan="5">&nbsp;</td>
		</tr>
		<tr bgcolor="#EFFBFF">
		<td width="27">&nbsp;</td>
		<td width="80"> 
			<div align="center"><%=IDS_SECTION%></div>
		</td>
		<td width="229">
		<input name="city" type="text" value="<%=StrCity%>" size="25" maxlength="40">
		</td>
		<td width="83">
			<div align="center"><%=IDS_QQNO%></div>
		</td>
		<td width="247">
			<input name="qq" type="text" value="<%=Strqq%>" size="25" maxlength="40">
		</td>
		</tr>
		<tr bgcolor="#F7F7F7">
		<td colspan="5">&nbsp;</td>
		</tr>
		<tr>
		<td bgcolor="#EFFBFF" width="27">&nbsp;</td>
		<td bgcolor="#EFFBFF" width="80">
			<div align="center"><%=IDS_CONTENT%></div>
		</td>
		<td colspan="3" bgcolor="#EFFBFF">
			<input name="content" type="text" value="<%=Scontent%>" size="60" maxlength="250">
		</td>
		</tr>
		<tr bgcolor="#F7F7F2">
		<td colspan="5">
			<div align="center">
			<input name="Button" type="submit" onClick="return ischeck(document.addfm)" value="<%=IDS_OK%>">
			&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
			<input type="reset">
			<input type="hidden" name="act" value="<%if StrActpage=IDS_MODI then%>modify<%else%>add<%end if%>">
			<input type="hidden" name="addressid" value="<%=nAddressID%>">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
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
<%	  
	End If
	conn.Close
	Set conn = Nothing
%>
</html>