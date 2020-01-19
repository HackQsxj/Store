<%
  Option Explicit
  Response.Expires = 0
  Response.Buffer = TRUE
  Server.ScriptTimeOut = 1800
  If Session("LoginSuccess")=1 Then
	If Left(Request("urlOfAttach"), 10) = "/maildata/" Then
		If InStr(Request("urlOfAttach"), "..") = 0 And InStr(Request("urlOfAttach"),":") = 0 And InStr(Request("urlOfAttach"),"%") = 0 Then
		  	Dim download
			Set download = Server.CreateObject("CMailCOM.POP3.1")
	  		download.Download Request("urlOfAttach"), Response
		  	Set download = Nothing
			Response.End
		End If
	End If
  End If
%>