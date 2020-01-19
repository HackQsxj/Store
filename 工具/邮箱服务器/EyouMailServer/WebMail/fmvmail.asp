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
  Dim ToFolder

  Set objPOP3 = CreateObject("CMailCOM.POP3.1")
  objPOP3.Login Session("User"), Session("Pass")
  Session("LoginSuccess") = objPOP3.LoginSuccess
  If Session("LoginSuccess") = 1 Then
	i = 0
	ToFolder = Request.form("tofolder")
	arrString = Split(Request("indexOfMail"), ";", -1, 1)
  	if ToFolder=1 then
    		While Len(arrString(i)) <> 0 
		   objPOP3.MoveToInbox arrstring(i)
       		   sql =  "delete from mailfolder where account= '" & Session("Account") & "' and uid = '" & arrString(i) & "'"
		   conn.execute sql,1,0
		   i = i + 1
	    	Wend
	else
	    	While Len(arrString(i)) <> 0 
       		   sql =  "update mailfolder set folderid='" & ToFolder & "' where account= '" & Session("Account") & "' and uid = '" & arrString(i) & "'"
		   conn.execute sql,1,0
		    i = i + 1
	    	Wend		   
	end if
  End If
  Set objPOP3 = Nothing
  conn.Close
  Set conn = Nothing
  Response.Redirect Request.form("subpage") & ".asp?pages=" & Request("pages")
  Response.End
%>
<title><!--#include file="webmailver.txt" --></title>