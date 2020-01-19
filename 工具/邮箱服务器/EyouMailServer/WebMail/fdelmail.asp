<%
  Option Explicit
  Response.Buffer = True
%>  
<!--#include file="conn.asp" -->
<%
	Dim objPOP3
	Dim i
	Dim sql
	Dim arrString

	Set objPOP3 = CreateObject("CMailCOM.POP3.1")
	objPOP3.Login Session("User"), Session("Pass")
	Session("LoginSuccess") = objPOP3.LoginSuccess
	If Session("LoginSuccess") = 1 Then
		i = 0
		arrString = Split(Request("indexOfMail"), ";", -1, 1)
		While Len(arrString(i)) <> 0 
		     	objPOP3.DeleteMailEx  arrstring(i)
    			sql =  "delete from mailfolder where account= '" & Session("Account") & "' and uid = '" & arrString(i) & "'"
			conn.execute sql,1,0
			i = i + 1
		Wend
	End If

	Set objPOP3 = NoThing
	conn.Close
	Set conn = Nothing

	If Request.form("subpage")<>"" Then
		Response.Redirect Request.form("subpage") & ".asp" & "?pages=" & Request("pages")
	Else
		Response.Redirect "finbox.asp?pages=" & Request("pages")
	End If
	Response.End
%>
<title><!--#include file="webmailver.txt" --></title>