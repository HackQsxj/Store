<% 
  Option Explicit
  Response.Buffer = True
%>

<!-- #include file=language.txt -->
<!-- #include file=conn.asp -->
<Html>
<Head>
<title> 
<!-- #include file=webmailver.txt -->
</title>
<Style Type = text/css>
a:link {text-decoration:none; cursor: hand}
a:visited {text-decoration:none}
a:hover {text-decoration:underline}
body, table {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</Style>

<SCRIPT language=JavaScript>
<!--
		function OnReturn()
		{
			window.location.replace("mailoptions.asp")
		}
		function OnFinbox()
		{
			window.location.replace("finbox.asp")
		}		
//-->
</SCRIPT>

</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000 >
<table border="0"  bordercolordark=white bordercolor=gray cellspacing="0" height="100%" width="100%" >
  <tr bgcolor="#dcdcdc">
    <td colspan="4" valign="top" bgcolor="#FFFFF7"> 
<%
	Dim ObjPOP3,nMailBoxSize,nMailBoxSizeUsed,nInboxRead,nMailCount		
	
	Set objPOP3 = CreateObject("CMailCOM.POP3.1")
	objPOP3.Login Session("User"), Session("Pass")
	Session("LoginSuccess") = objPOP3.LoginSuccess
	
	If Session("LoginSuccess")= 1 Then
		objPOP3.GetMailBoxInfo
		nMailBoxSize = objPOP3.MailBoxSize
		nMailBoxSizeUsed = objPOP3.MailBoxSizeUsed
		nInboxRead = objPOP3.InboxRead
		nMailCount = objPOP3.MailCount
%>
      <form action="setpersoninfo.asp" method=Post>
        <p>
          <input type=Hidden name=Modify	value="0">
        </p>
        <table width="80%" border="0" align="center" cellpadding="0" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor="gray">
          <tr bgcolor="#C6DFF7"> 
            <td height="30" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/setup.gif" width="16" height="16" align="absmiddle"><span ><font color=#000000><b>&nbsp;<%=IDS_MAILBOX_STAT%> 
              </b></font></span> </td>
          </tr>

          <tr bgcolor="#FFFFF7"> 
            <td width=100 height="30"><b>&nbsp;&nbsp;<%=IDS_TOTAL_CONTENT%></b></td>
            <td >&nbsp;&nbsp;
<%
	If nMailBoxSize = -1 Then
		Response.Write IDS_UNLIMITED
	Else
		Response.Write nMailBoxSize
		Response.Write "M"
	End If
%></td>
          </tr>

          <tr bgcolor="#EEEDDF"> 
            <td height="30"><b>&nbsp;&nbsp;<%=IDS_USED_SPACE%></b></td>
            <td bgcolor="#EEEDDF">
<%If nMailBoxSize <> -1 Then %>
<br>
	            &nbsp;&nbsp;<img border="1" src="images/position.gif" width="<%=Int(100*nMailBoxSizeUsed/(nMailBoxSize*1024+0.0001))%>" height="10"><img border="1" src="images/space.gif" width="<%=100-Int(100*nMailBoxSizeUsed/(nMailBoxSize*1024+0.0001))%>" height="10"><br>
<%End If%>
	            &nbsp;&nbsp;<%=IDS_YOU_HAVE_USED%> <%=nMailBoxSizeUsed%> K 
<%If nMailBoxSize <> -1 Then%>
(<%=Int(100*nMailBoxSizeUsed/(nMailBoxSize*1024+0.0001))%>%)
<%End If
DIM rs, strSql, mailcount(5), mailsize(5)
set rs=createobject("adodb.recordset")
strSql = "select count(*), sum(mailsize) from mailfolder where account='" & Session("Account") & "' and folderid='2'"
rs.open strSql,Conn,1,2
mailcount(2) = rs(0)
if(rs(1)) then mailsize(2) = rs(1) else mailsize(2) = 0
rs.close
strSql = "select count(*), sum(mailsize) from mailfolder where account='" & Session("Account") & "' and folderid='3'"
rs.open strSql,Conn,1,2
mailcount(3) = rs(0)
if(rs(1)) then mailsize(3) = rs(1) else mailsize(3) = 0
rs.close
strSql = "select count(*), sum(mailsize) from mailfolder where account='" & Session("Account") & "' and folderid='4'"
rs.open strSql,Conn,1,2
mailcount(4) = rs(0)
if(rs(1)) then mailsize(4) = rs(1) else mailsize(4) = 0
rs.close
strSql = "select count(*), sum(mailsize) from mailfolder where account='" & Session("Account") & "' and folderid='5'"
rs.open strSql,Conn,1,2
mailcount(5) = rs(0)
if(rs(1)) then mailsize(5) = rs(1) else mailsize(5) = 0
rs.close
conn.close
%>
<br>
            </td>
          </tr>
          
          <tr bgcolor="#FFFFF7"> 
            <td height="30"><b>&nbsp;&nbsp;<%=IDS_INBOX%><b></td>
            <td >&nbsp;&nbsp;<%=IDS_TOTAL_MESSAGE%> <%=nMailCount%>, <%=IDS_UNREAD%> <%=nMailCount-nInboxRead%>.</td>
          </tr>
          <tr bgcolor="#FFFFF7"> 
            <td height="30"><b>&nbsp;&nbsp;<%=IDS_OUTBOX%><b></td>
            <td >&nbsp;&nbsp;<%=IDS_TOTAL_MESSAGE%> <%=mailcount(2)%>, <%=IDS_HAVE_USED%> <%=int(mailsize(2) / 1024)%> K. </td>
          </tr>
          <tr bgcolor="#FFFFF7"> 
            <td height="30"><b>&nbsp;&nbsp;<%=IDS_DRAFTS%><b></td>
            <td >&nbsp;&nbsp;<%=IDS_TOTAL_MESSAGE%> <%=mailcount(5)%>, <%=IDS_HAVE_USED%> <%=int(mailsize(5) / 1024 + 0.01)%> K. </td>
          </tr>
          <tr bgcolor="#FFFFF7"> 
            <td height="30"><b>&nbsp;&nbsp;<%=IDS_FAVORITE%><b></td>
            <td >&nbsp;&nbsp;<%=IDS_TOTAL_MESSAGE%> <%=mailcount(3)%>, <%=IDS_HAVE_USED%> <%=int(mailsize(3) / 1024)%> K. </td>
          </tr>
          <tr bgcolor="#FFFFF7"> 
            <td height="30"><b>&nbsp;&nbsp;<%=IDS_TRASHCAN%><b></td>
            <td >&nbsp;&nbsp;<%=IDS_TOTAL_MESSAGE%> <%=mailcount(4)%>, <%=IDS_HAVE_USED%> <%=int(mailsize(4) / 1024 + 0.01)%> K. </td>
          </tr>

                    
          <tr bgcolor="#C6DFF7"> 
            <td height="43" colspan="2"> 
              <div align="center">
                <input type=button src="button-modify.gif" alt="Modify" height=21 width=61 border=0 onClick="OnFinbox()" value="<%=IDS_CHECK_MAIL%>" name="button2">
                <input type=button src="button-modify.gif" alt="Go back" height=21 width=61 border=0 onClick="OnReturn()" value=" <%=IDS_RETURN%> " name="button">
              </div>
		<br>
		<font color=red></font>

            </td>
          </tr>
        </table>

        </div>
      </form>
<% 
	Else
		Response.Write objPOP3.LastResponse
	End If
	Set objPOP3 = Nothing
%>
     </td>
     </tr>
  </table>
</Body>
</Html>