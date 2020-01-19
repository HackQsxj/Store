<%
  Option Explicit
  Response.Buffer = True
  Dim objPOP3
  Dim i
  Dim arrString

  Set objPOP3 = CreateObject("CMailCOM.POP3.1")
  objPOP3.Login Session("User"), Session("Pass")
  Session("LoginSuccess") = objPOP3.LoginSuccess
  If Session("LoginSuccess") = 1 Then
	i = 0
	arrString = Split(Request("indexOfMail"), ";", -1, 1)
	While Len(arrString(i)) <> 0 
		objPOP3.DeleteMailByUID arrString(i)
		i = i + 1
	Wend
  End If
  Set objPOP3 = NoThing
  Response.Redirect "finbox.asp?pages=" & Request("pages")
  Response.End
%>
<title><!--#include file="webmailver.txt" --></title>