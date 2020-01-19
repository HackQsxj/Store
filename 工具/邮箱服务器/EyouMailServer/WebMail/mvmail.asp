<%
  Option Explicit
  Response.Buffer = True
%>  
<!--#include file="conn.asp" -->
<!-- #include file="encode.asp" -->
<%
  Dim objPOP3
  Dim i
  Dim arrString
  Dim sql
  Dim rs
  Dim id
  Dim strUID
  Dim strSubject
  Dim strFrom
  Dim strDate
  Dim strTo
  Dim lSize
  Dim bRead
  Dim bReply
  Dim bForward


  Set objPOP3 = CreateObject("CMailCOM.POP3.1")
  objPOP3.Login Session("User"), Session("Pass")
  Session("LoginSuccess") = objPOP3.LoginSuccess
  If Session("LoginSuccess") = 1 Then
	  set rs=Server.createobject("adodb.recordset")
  	  rs.open "mailfolder",Conn,1,3
	  i = 0
  	  arrString = Split(Request("indexOfMail"), ";", -1, 1)
	  While Len(arrString(i)) <> 0 
		strUID = arrString(i)
		
		objPOP3.MoveToFolder strUID

		If Left(objPOP3.LastResponse, 4) = "-ERR" Then
			Response.Redirect "finbox.asp?pages=" & Request("pages")
			Response.End
		End If
		i = i + 1
	Wend
	Set objPOP3 = NoThing
	Set objPOP3 = CreateObject("CMailCOM.POP3.1")
	objPOP3.Login Session("User"), Session("Pass")
	i = 0
	 While Len(arrString(i)) <> 0 
		strUID = arrString(i)

		objPOP3.GetMailInfoEx strUID
		
		If Left(objPOP3.LastResponse, 4) = "-ERR" Then
			Response.Redirect "finbox.asp?pages=" & Request("pages")
			Response.End
		End If

		strSubject = objPOP3.Subject
		strSubject = HTMLEncode(strSubject)
		If Len(strSubject) = 0	Then
			strSubject = "(nosubject)"
		End If

		strFrom	   = objPOP3.From
		strFrom = HTMLEncode(strFrom)
		If Len(strFrom)	= 0 	Then
			strFrom = "(noaddr)"
		End If
		strDate	   = objPOP3.Date
		If Len(strDate)	= 0	Then
			strDate = "(nodate)"
		End If
		lSize = objPOP3.Size
     		bRead = objPOP3.IsRead	  
		bReply = objPOP3.IsReply
		bForward = objPOP3.IsForward
    		rs.addnew
		rs("account")=Session("Account")
		rs("uid")=strUID
		RS("folderid")=Request.Form("toFolder")
		rs("subject") =strSubject
		rs("mailfrom")=strFrom
		rs("maildate")=strDate
		rs("mailsize")=lSize
		If (bReply = 1) Then 
			bRead = bRead mod 2 + (bRead - bRead mod 4) / 4 * 4 + 2 
		End If
		If (bForward = 1) Then 
			bRead = bRead mod 4 + 4 
		End If
    		rs("mailIsread")=bRead
		rs.update

		i = i + 1
	wend
	rs.Close
    	set rs = nothing
  End If
  Set objPOP3 = NoThing
  conn.Close
  set conn = nothing
  Response.Redirect "finbox.asp?pages=" & Request("pages")
  Response.End
%>
<title><!--#include file="webmailver.txt" --></title>