<%
	Option Explicit

	Dim objPOP3
	Set objPOP3 = CreateObject("CMailCOM.POP3.1")
	If Session("LoginSuccess") = 1 Then
		objPOP3.Logout(Session("User"))
	End If
	Session("LoginSuccess") = 0
	Session("User") = ""
	Session("Pass") = ""
	Session("Admin") = 0
	Set objPOP3 = NoThing
	Response.Redirect "index.asp" 
%>
<!-- #include file=language.txt -->
<title><!--#include file="webmailver.txt" --></title>