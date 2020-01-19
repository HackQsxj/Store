<%
	Option Explicit
	Response.Buffer = True
%>  
<!--#include file="conn.asp" -->
<%
	Dim nI
	Dim arrString
	Dim strSql
	Dim rs

	If Session("LoginSuccess") = 1 Then
		If Request("act")="del" Then
     			nI = 0
	    		arrString = Split(Request("indexOfMail"), ";", -1, 1)
	        		While Len(arrString(nI)) <> 0 
				strSql =  "delete from address where account= '" & Session("Account") & "' and addressid = " & arrString(nI)
				conn.execute strSql,1,0
				nI = nI + 1
			Wend
		ElseIf Request("act")="modify" Then
			Set rs=Server.createobject("adodb.recordset")
			strSql = "select * from address where account='" & Session("Account") & "' and addressid=" & Cint(Request("addressid"))
			rs.open strSql,Conn,1,2

			rs("name") = Request("name")
			rs("mail")	= Request("mail")
			rs("city") = Request("city")
			rs("qq") = Request("qq")
			rs("content") = Request("content")
			rs.Update
			rs.Close
			Set rs = Nothing
		ElseIf Request("act")="add" Then
			Set rs=Server.createobject("adodb.recordset")
			rs.Open "select * from address where account='" & Session("Account") & "'",Conn,1,3
			If  rs.recordcount < 100 Then
				rs.close
				rs.open "address",Conn,1,3
				rs.AddNew
				rs("account") = Session("Account")
				rs("name") = Request("name")
				rs("mail")	= Request("mail")
				rs("city") = Request("city")
				rs("qq") = Request("qq")
				rs("content") = Request("content")
				rs.Update
			End if
			rs.Close
			Set rs = Nothing
		End If
	End If
	conn.Close
	Set conn = Nothing
	Response.Redirect "address.asp"
	Response.End
%>
<title><!--#include file="webmailver.txt" --></title>