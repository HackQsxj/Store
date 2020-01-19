<%
	Response.Buffer = True
	Response.ExpiresAbsolute = Now() - 1 
	Response.Expires = 0 
	Response.CacheControl = "no-cache" 
	If Session("LoginSuccess") <> 1 Then 
		Response.Redirect "logout.asp"
		Response.End
	End If
%>
<!--#include file="language.txt" -->
<html>
	<head>
		<title><!--#include file="webmailver.txt" --></title>
	</head>
	<frameset rows="65,*" cols="*" frameborder="no" border="0" framespacing="0">
		<frame src="top.asp" name="top" scrolling="no" noresize >
		<frameset cols="180,90%" frameborder="NO" border="0" framespacing="0">
			<frame src="left.asp" name="left" scrolling="auto" noresize >
			<frame src="mailboxinfo.asp" name="main" scrolling="auto" noresize>
			<!--frame src="finbox.asp" name="main" scrolling="auto" noresize-->
		</frameset>
	</frameset>
	<noframes>
		<body>
		</body>
	</noframes>
</html>
