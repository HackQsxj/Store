<%
	Option Explicit
	Response.Buffer = True
%>
<!-- #include file=language.txt -->
<!--#include file="conn.asp" -->
<!-- #include file="encode.asp" -->
<Html>
<Head>
<title><!--#include file="webmailver.txt" --></title>
<style type="text/css">
<!--
body {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
-->
</style>
</Head>
<%
	Dim objPOP3
	Dim rs
	Dim strSql
	Dim nFindDomain
	
	Session("Account") = Request("User")
	If Request("SaveUserPass") = "on" Then
		Response.Cookies("User") = Request("User")
		Response.Cookies("Pass") = Request("Pass")	
		Response.Cookies("SaveUserPass") = "1"
		Response.Cookies("User").Expires = Date+365
		Response.Cookies("Pass").Expires = Date+365
		Response.Cookies("SaveuserPass").Expires = Date+365
	Else
		Response.Cookies("User") = ""
		Response.Cookies("Pass") = ""
		Response.Cookies("SaveUserPass") = ""
	End If
	Session("User") = Request("User") + ":" + Request("REMOTE_ADDR")
	Session("Pass") = Request("Pass")
	Session("Admin") = 0
	Set objPOP3 = CreateObject("CMailCOM.POP3.1")
	objPOP3.Login Session("User"), Session("Pass")
	Session("LoginSuccess") = objPOP3.LoginSuccess
	
	If Session("LoginSuccess") = 1 Then
		nFindDomain = InstrRev(Session("Account"), "@")
		Session("Admin") = objPOP3.Permission
		Session("Domain") = objPOP3.MailDomain  
		set rs=createobject("adodb.recordset")
		strSql = "select * from parameter where account='" & Session("Account") & "'"
		rs.open strSql,Conn,1,2
		If InstrRev(Session("Account"), "@") > 0 Then 
			Session("replyaddr") = Session("Account")
			Session("emailaddress") = Session("Account")
			Session("Domain") = Mid(Session("Account"), InstrRev(Session("Account"), "@") + 1)
		Else
			Session("replyaddr") = Session("Account") & "@" & Session("Domain")
			Session("emailaddress") = Session("Account") & "@" & Session("Domain")
		end if
		if not rs.eof then 
		   Session("maxlist") = rs("maxlist")
		   Session("replyaddr") = rs("replyaddr")
		else
		   Session("maxlist") = 20
		End If
		
		objPOP3.CreateUserPath Session("User")

		if session("maxlist")<0 and session("maxlist")>100 then
			session("maxlist")=20
		end if 
		rs.Close
		set rs = nothing
		Response.Redirect("mail.asp")
	Else
		%>
<font color="#FF0000"><%=IDS_LOGIN_ERROR%>:</font><br> 
<%=HTMLEncode(objPOP3.LastResponse)%>
<p><a href="index.asp"><%=IDS_RE_LOGIN%></a><br>
  <%
	End If
	Set objPOP3 = NoThing
	conn.Close
	set conn = nothing	
%>
</p>
<p>&nbsp;</p><p>&nbsp;</p></Html>