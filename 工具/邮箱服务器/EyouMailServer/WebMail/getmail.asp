<% 
  Option Explicit
  Response.Buffer = True
  Server.ScriptTimeOut = 1800

%>
<!-- #include file="Language.txt" -->
<!-- #include file="encode.asp" -->
<Html>
<Head>
<title> 
<!--#include file="webmailver.txt" -->
</title>
<LINK href="styles.css" rel=STYLESHEET type=text/css>
<SCRIPT language=JavaScript>
<!--
function OnReply()
	{
		document.forms("ReplyMail").Subject.value= "Re:" + document.all.Subject0.innerText
		document.forms("ReplyMail").Body.value = "From:" + document.all.From0.innerText + "\r\n" + "To:" + document.all.To0.innerText + "\r\n" + "Date:" + document.all.Date0.innerText + "\r\n\r\n" + document.all.Body0.innerText
		document.forms("ReplyMail").To.value = document.all.From0.innerText
		document.forms("ReplyMail").reply.value = "1"
		document.forms("ReplyMail").forward.value = "0"
		document.forms("ReplyMail").submit()
	}
	function OnForward()
	{
		document.forms("ReplyMail").Subject.value= "Fw:" + document.all.Subject0.innerText
		document.forms("ReplyMail").Body.value = "From:" + document.all.From0.innerText + "\r\n" + "To:" + document.all.To0.innerText + "\r\n"  + "Date:" + document.all.Date0.innerText + "\r\n\r\n" + document.all.Body0.innerText
		document.forms("ReplyMail").To.value = ""
		document.forms("ReplyMail").AttachFile.disabled = false;
		document.forms("ReplyMail").reply.value = "0"
		document.forms("ReplyMail").forward.value = "1"
		document.forms("ReplyMail").submit()
	}
	function OnPDelete()
	{
		if(confirm("<%=IDS_ALERT_DELETE%>")==true)
			document.forms("DeleteMail").submit();
	}
	function OnDelete()
	{
		document.forms("MoveMail").ToFolder.value = 4;
		document.forms("MoveMail").submit();
	}
	function OnMove()
	{
		if(confirm("<%=IDS_ALERT_MOVE%>")==true)
		{
			document.forms("MoveMail").ToFolder.value = document.forms("mb").ToFolder.value;
			document.forms("MoveMail").submit();
		}

	}

//-->
</SCRIPT>
<base target="_self">
<style type="text/css">
<!--
.back {
	background-image: url(images/sendmailback.gif);
	background-repeat: no-repeat;
	background-position: right bottom;
}
//-->
</style>
</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000  >
<TABLE width="100%" BORDER=0 CELLPADDING=0 CELLSPACING=0>
  <TR> 
    <TD width="6"> <IMG SRC="images/nav_01.gif" WIDTH=6 HEIGHT=8 ALT=""></TD>
    <TD width="100%" background="images/nav_02.gif"> <IMG SRC="images/nav_02.gif" WIDTH=121 HEIGHT=8 ALT=""></TD>
    <TD width="11"> <IMG SRC="images/nav_03.gif" WIDTH=11 HEIGHT=8 ALT=""></TD>
  </TR>
  <TR> 
    <TD background="images/nav_04.gif">&nbsp; </TD>
    <TD bgcolor="#FFFFFF"> 
      <table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray  bordercolordark=white  >
        <tr bgcolor="#dcdcdc"  valign="left"> 
          <td valign="top" bgcolor="#FFFFFF" width="100%"> 
            <%
	Dim objPOP3
	Dim strBodyTxtURL
	Dim strBodyHtmlURL
	Dim strAttachURL
	Dim strAttachFileName
	Dim nAttachCount
	Dim nMailCount
	Dim nCurMail
	Dim i
	Dim strBody
	Dim strFrom
	Dim strSubject
	Dim strDate
	Dim strTo
	Dim strCc
	Dim arrString
	Dim strUID
	Dim lSize
	Dim strEmailURL
	Dim strHeaderURL
	Dim strAttachForward
	
	strAttachForward = ""
	Set objPOP3= CreateObject("CMailCOM.POP3.1")
	objPOP3.Login Session("User"), Session("Pass")
	Session("LoginSuccess") = objPOP3.LoginSuccess

	If Session("LoginSuccess") = 1 Then 

		objPOP3.GetMailData Request("indexOfMail")
		If Left(objPOP3.LastResponse, 4) = "-ERR" Then
			Response.Write objPOP3.LastResponse
			'Response.Redirect "finbox.asp"
			Response.End
		End If

		
		if not IsNumeric(Request("MailCount")) then response.Redirect "finbox.asp"
		nMailCount = CInt(Request("MailCount"))
		if not IsNumeric(Request("indexOfMail")) then response.Redirect "finbox.asp"
		nCurMail = CInt(Request("indexOfMail"))

		strBody = objPOP3.Body
		strFrom = objPOP3.From
		strTo = objPOP3.To
		strCc = objPOP3.Cc
		strSubject = objPOP3.Subject
		strDate	= objPOP3.Date
		strUID = objPOP3.UID
		lSize = objPOP3.Size
		strEmailURL = objPOP3.EmailURL
		strBodyHtmlURL = objPOP3.BodyHtmlURL
		strHeaderURL = objPOP3.HeaderURL

		strBody = Autolink(strBody)
		strBody = Replace(strBody, vbNewLine, "<Br>")
		strSubject = HTMLEncode(strSubject)
		'strFrom = HTMLEncode(strFrom)
		strTo = HTMLEncode(strTo)
		strCc = HTMLEncode(strCc)

		
		strBodyTxtURL = objPOP3.BodyTxtURL
		If Len(strBodyTxtURL) > 0 Then
			strBodyTxtURL = strBodyTxtURL 
		End If

		strBodyHtmlURL = objPOP3.BodyHtmlURL
		If Len(strBodyHtmlURL) > 0 Then
			strBodyHtmlURL =  strBodyHtmlURL 
		End If

		nAttachCount = objPOP3.AttachCount
%>
            <form name="mb">
              <table width="100%" border="0" bordercolordark=white bordercolor=gray cellspacing="0" >
                <tr valign="middle"> 
                  <td valign="middle" width="100%"> <%=IDS_THERE_ARE_NO%> <%=Request("indexOfMail")%> 
                    <%=IDS_MAIL%>. <br>
                    &nbsp;&nbsp; 
                    <%if nCurMail<nMailCount then %>
                    <a href="getmail.asp?indexOfMail=<%=nCurMail + 1%>&mailcount=<%=nMailCount%>"><%=IDS_MAIL_PRI%></a>&nbsp;&nbsp; 
                    <%End If%>
                    <%if nCurMail>1 then %>
                    <a href="getmail.asp?indexOfMail=<%=nCurMail - 1%>&mailcount=<%=nMailCount%>"><%=IDS_MAIL_NEXT%></a>&nbsp;&nbsp; 
                    <%End If%>
                    <a id=Reply href="javascript:OnReply()"> <img src="images/reply.gif" width="16" height="16" hspace="3" border="0" align="absbottom"><%=IDS_REPLY%></a>&nbsp; 
                    <a href="javascript:OnForward()"><img src="images/forward.gif" width="16" height="16" hspace="3" border="0" align="absbottom"><%=IDS_FORWARD%></a>&nbsp; 
                    <a href="javascript:OnDelete()"><img src="images/rec.gif" width="14" height="14" hspace="3" border="0" align="absbottom"><%=IDS_DELETE%></a>&nbsp; 
	    <a href="javascript:OnPDelete()"><img src="images/delete.gif" width="14" height="14" hspace="3" border="0" align="absbottom"><%=IDS_PDELETE%></a>&nbsp; 
                    <a href="javascript:OnMove()"><img src="images/move.gif" width="14" height="14" hspace="3" border="0" align="absbottom"><%=IDS_MOVE%></a> 
                    <select name="ToFolder" size="1" class="normal-font" id="ToFolder">
                      <option value="2"><%=IDS_OUTBOX%></option>
                      <option value="3" selected><%=IDS_FAVORITE%></option>
                      <option value="4"><%=IDS_TRASHCAN%></option>
                    </select>
                    &nbsp; <a href="javascript:window.print()"><img src="images/print.gif" width="16" height="16" hspace="3" border="0" align="absbottom"><%=IDS_PRINT%></a>&nbsp; 
                    <a href="download.asp?urlOfAttach=<%=strHeaderURL%>" target=_top><img src="images/head.gif" width="16" height="16" hspace="3" border="0" align="absbottom"><%=IDS_HEADER%></a>&nbsp; 
                    <a href="download.asp?urlOfAttach=<%=strEmailURL%>" target=_top><img src="images/origin.gif" width="16" height="16" hspace="3" border="0" align="absbottom"><%=IDS_ORIGINAL_MAIL%></a>(<%=lSize%>bytes)</td>

                </tr>
                <tr> 
                  <td valign = "Top" > 
                    <table width="100%" border="1" bgcolor=white bordercolordark=white bordercolor=gray cellspacing="0" height="370">
                      <tr bgcolor="#F9FFF7"> 
                        <td width="78"><b><font color=#000000	><%=IDS_SENDER%>:</font></b></td>
                        <td width="100%">&nbsp;<span id=From0><%= HTMLEncode(strFrom)%></span>&nbsp;<a href="addressm.asp?mail=<%= Server.URLEncode(strFrom)%>">&lt;<%= IDS_ADDTOADDR%></a>&gt;</td>
                      </tr>
                      <tr bgcolor="#F9FFF7"> 
                        <td><b><font color=#000000><%=IDS_DATE%>:</font></b></td>
                        <td>&nbsp;<span id=Date0><%=strDate%></span></td>
                      </tr>
                      <tr bgcolor="#F9FFF7"> 
                        <td><b><font color="#000000"><%=IDS_RECEIVER%>:</font></b></td>
                        <td>&nbsp;<span id=To0><%=strTo%></span></td>
                      </tr>
                      <% If strCc <> "" Then%>
                      <tr bgcolor="#F9FFF7"> 
                        <td><b><font color="#000000"><%=IDS_CC%>:</font></b></td>
                        <td>&nbsp;<%=strCc%></td>
                      </tr>
                      <% End If%>
                      <tr bgcolor="#F9FFF7"> 
                        <td><b><font color=#000000><%=IDS_SUBJECT%>:</font></b></td>
                        <td>&nbsp;<span id=Subject0><%= strSubject%></span></td>
                      </tr>
                      <%if nAttachCount > 0 then %>
                      <tr bgcolor="#F9FFF7"> 
                        <td><b><font color=#000000><%=IDS_ATTACHEMENT%>:</font></b></td>
                        <td>&nbsp; 
                          <%
				i = 0
				While i < nAttachCount 
					i = i + 1
					objPOP3.GetAttachInfo i
					strAttachURL = objPOP3.AttachURL
					strAttachFileName = objPOP3.AttachFileName
					strAttachForward = strAttachForward + strAttachURL + ";"
					Response.Write "|<a href=""download.asp?urlOfAttach="&strAttachURL&""" target=_top> <img src=""images/print.gif"" width=16 height=16 border=0 align=absbottom>"&strAttachFileName&"</a>|&nbsp;"
				Wend
			%>
                        </td>
                      </tr>
                      <%End If%>
                      <!--			
           	      <%if strBodyHtmlURL <> "" then%>
                      <tr valign="top"> 
                        <td height="225" colspan="2" class="back">
			<iframe src="<%=strEmailURL%>" width=100% height=100%></iframe>
			<br></td>
                      </tr>
		      <%end if%>
-->
                      <tr valign="top"> 
                        <td height="225" colspan="2" class="back"><span id=Body0><%= strBody%></span><br>
                        </td>
                      </tr>
                      <tr valign="top" bgcolor="#FFFFFF"> 
                        <td height="9" colspan="2">&nbsp;<font color=#ffffff> 
                          <%if strBodyHtmlURL <> "" then%>
                          <a id=Reply href="<%=strBodyHtmlURL%>" target=_blank> 
                          <img src="images/html.gif" width="20" height="20" border="0" align="absmiddle"> 
                          <%=IDS_HTML_CONTENT%></a> 
                          <%End If%>
                          </font> </td>
                      </tr>
                      <tr> 
                        <td height="5"><img height="1" width="78" src="spacer.gif"></td>
                        <td></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <%
				If nAttachCount <> 0 Then
			%>
                <tr> 
                  <td valign="middle" colspan="2">&nbsp; </td>
                  <%
				End If
			%>
                </tr>
                <tr> 
                  <td height="3"></td>
                  <td><img height="1" width="5" src="spacer.gif"></td>
                </tr>
              </table>
            </form>
            <form action="sendmail.asp" method=Post name="ReplyMail">
              <input type=Hidden name=Subject value="">
              <input type=Hidden name=To value="">
              <input type=Hidden name=Body value="">
              <input type=Hidden name=AttachFile value="<%=strAttachForward%>" DISABLED>
	<input type=hidden name=uid value="<%=strUID%>">
	<input type=hidden name=folderid value="0">
	<input type=hidden name=reply value="0">
	<input type=hidden name=forward value="0">
            </form>
            <form action="delmail.asp" method=Post name="DeleteMail">
              <input type=Hidden name=indexOfMail value="<%=strUID%>;">
            </form>
            <form action="mvmail.asp" method=Post name="MoveMail">
              <input type=Hidden name=ToFolder value="">
              <input type=Hidden name=indexOfMail value="<%=strUID%>;">
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
    </TD>
    <TD background="images/nav_06.gif">&nbsp; </TD>
  </TR>
  <TR> 
    <TD> <IMG SRC="images/nav_07.gif" WIDTH=6 HEIGHT=9 ALT=""></TD>
    <TD background="images/nav_08.gif"> <IMG SRC="images/nav_08.gif" WIDTH=121 HEIGHT=9 ALT=""></TD>
    <TD> <IMG SRC="images/nav_09.gif" WIDTH=11 HEIGHT=9 ALT=""></TD>
  </TR>
  <tr> 
    <td height="1"><img height="1" width="6" src="spacer.gif"></td>
    <td></td>
    <td><img height="1" width="11" src="spacer.gif"></td>
  </tr>
</TABLE>
</Body>

</Html>
