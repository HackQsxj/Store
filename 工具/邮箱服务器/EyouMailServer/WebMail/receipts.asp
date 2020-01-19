<% 
  Option Explicit
  Response.Buffer = True
%>
<!-- #include file=language.txt -->
<!-- #include file=conn.asp -->
<!-- #include file="encode.asp" -->
<Html>
<Head>
<title><!--#include file="webmailver.txt" --></title>
<Style Type = text/css>
a:link {text-decoration:none; cursor: hand}
a:visited {text-decoration:none}
a:hover {text-decoration:underline}
body,table {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</Style>
<base target="_self">
</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000  >
<table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray  bordercolordark=white  >
  <tr bgcolor="#dcdcdc"  valign="left"> 
    <td width="100%"  height="100%" align="left" valign="top" bgcolor="#FFFFF7"> 
      <%
	Dim rs
	Dim strSql
	Dim nI

	If Session("LoginSuccess")= 1 Then
 
	set rs=createobject("adodb.recordset")
	strSql="select * from receipts where messageid='" & request("messageid") & "' order by id DESC"
	rs.open strSql,Conn,1,2
	 
%>
      <FORM action="" method=post align="left">
        <Table width="100%" >
          <Tr > 
            <TD vAlign=center width="100%" height="1">共有&nbsp;<%=RS.recordcount%> 
              个收件人. </TD>
          </Tr>
        </Table>
        <table width="100%" border="0" cellpadding="4" cellspacing="1" bordercolordark=white bgcolor=#400000>
          <TR vAlign=middle bgcolor="#990000"> 
            <TD width="19"><font color="#FFFFFF">&nbsp;</font></TD>
            <td ><font color="#FFFFFF">收件人</font></td>
            <TD ><font color="#FFFFFF">主题</font></TD>
            <TD ><font color="#FFFFFF">日期</font></TD>
            <TD ><font color="#FFFFFF">大小</font></TD>
          </TR>
          <%
		dim nCurPage
		dim nCurNo
		dim nCurCur
		dim nMailCount
		
		nMailCount = RS.recordcount
		nCurPage = 1
		nCurNo = 1
		nCurCur = 1
		
  		if Request.QueryString("pages")<>"" then
		    if not IsNumeric(Request.QueryString("pages")) then response.Redirect "ftrash.asp"
            			nCurpage=cint(Request.QueryString("pages"))
    		    end if
		nCurNo = (nCurPage-1) * session("maxlist") + 1
		
		For nI = 1 To nCurNo - 1
		  RS.movenext
		  if RS.eof then response.Redirect "ftrash.asp"
		Next
		
		do while (nCurNo <= nMailCount) and (nCurCur<=Session("maxlist"))
  
%>
          <TR bgcolor="#FFFFFF"> 
            <Td> 
              <%if RS("mailIsread") mod 2 = 1 then %>
              <%if RS("mailIsread") = 3 then%>
              <img src="images/reply.gif" width="16" height="16"> 
              <%else%>
              <%if RS("mailIsread") = 5 then%>
              <img src="images/forward.gif" width="16" height="16"> 
              <%else%>
              <img src="images/oldmail.gif" width="16" height="16"> 
              <%end if%>
              <%end if%>
              <%else 
		if RS("mailIsread")  = 0 then %>
              <img src="images/newmail.gif"> 
              <%else%>
              &nbsp; 
              <%end if
              end if%>
            </Td>
            <td> 
              <%if RS("mailIsread") = 0 then %>
              <b><%=HTMLEncode(RS("account"))%> </b> 
              <%else%>
              <%=HTMLEncode(RS("account"))%> 
              <%end if%>
            </td>
            <Td> <font color=red> 
              <%=HTMLEncode(request("subject"))%>(<%if RS("mailIsread") = 0 then %><b>未读</b><%else%>已读<%end if%>)
              </font> </Td>
		<td><%=HTMLEncode(request("maildate"))%></td>
		<td><%=HTMLEncode(request("mailsize"))%></td>
          </Tr>
          <%
		RS.movenext
        		nCurCur = nCurCur + 1
		nCurNo = nCurNo + 1 
	    loop
%>
          
        </Table>
        <TABLE width="100%" >
          <TBODY> 
          <TR> 
            <TD align=LEFT height=1 vAlign=top width="100%"> <b > </b></TD>
          </TR>
          </TBODY> 
        </TABLE>
        </Form>
      <%
	rs.Close
	set rs = nothing
	End If
	conn.Close
	set conn = nothing
%>
    </td>
  </tr>
  <%
    if nMailCount>session("maxlist") then
	
	Dim nPages
	
	nPages = nMailcount \ Session("maxlist")
	If nPages * Session("maxlist") <> nMailcount Then
		nPages = nPages + 1
	End If
	
%>
  <tr bgcolor="#dcdcdc"  valign="left"> 
    <td valign="top" bgcolor="#FFFFFF"  height="100%"> 
      <div align="center">>> 
        <%    for nI=1 to nPages %>
        &nbsp; 
        <%if nI<> nCurPage then %>
        <a href="ftrash.asp?pages=<%=nI%>"><%=nI%></a> 
        <% else %>
        <b><%=nI%></b> 
        <%end if%>
        &nbsp; 
        <% next %>
        << </div>
    </td>
  </tr>
  <% 
	end if
%>
</table>
</Body>
</Html>
