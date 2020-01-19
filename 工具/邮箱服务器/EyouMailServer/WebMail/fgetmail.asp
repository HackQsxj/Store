<% 
  Option Explicit
  Response.Buffer = True
  Server.ScriptTimeOut = 1800
%>
<!-- #include file="language.txt" -->
<!-- #include file="conn.asp" -->
<!-- #include file="encode.asp" -->
<html>
<head>
<title><!--#include file="webmailver.txt" --></title>
<style Type = text/css>
	a:link {text-decoration:none; cursor: hand}
	a:visited {text-decoration:none}
	a:hover {text-decoration:underline}
	body,table {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</style>
<script language=JavaScript>
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
	function OnDelete()
	{
		document.forms("MoveMail").ToFolder.value="4";
		document.forms("MoveMail").submit();
	}

	function OnPDelete()
	{
	if(confirm("<%=IDS_ALERT_PDELETE%>")==true)
		document.forms("DeleteMail").submit();
	}

	function OnMove()
	{
		document.forms("MoveMail").ToFolder.value = document.forms("mb").ToFolder.value;
		if(document.forms("MoveMail").ToFolder.value != -1)
		{
		if(confirm("<%=IDS_ALERT_MOVE%>")==true)
		{
			document.forms("MoveMail").submit();
		}
		}
	}
//-->
</script>
<style type="text/css">
<!--
.back {
	background-image: url(images/sendmailback.gif);
	background-repeat: no-repeat;
	background-position: right bottom;
}
-->
</style>
</head>
<body bgcolor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000>
<table width="100%" border=0 cellpadding=0 cellspacing=0>
  <tr> 
    <td width="6"><img src="images/nav_01.gif" width=6 height=8 alt=""></td>
    <td width="100%" background="images/nav_02.gif"> <img src="images/nav_02.gif" width=121 height=8 alt=""></td>
    <td width="11"><img src="images/nav_03.gif" width=11 height=8 alt=""></td>
  </tr>
  <tr> 
    <td background="images/nav_04.gif">&nbsp; </td>
    <td bgcolor="#FDFFFA"> 
      <table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray  bordercolordark=white>
        <tr bgcolor="#dcdcdc"  valign="left">
          <td valign="top" bgcolor="#FFFFFF" width="100%"  height="100%"> <form name="mb">
            <%
	Dim objPOP3
	Dim strBodyTxtURL
	Dim strBodyHtmlURL
	Dim strAttachURL
	Dim strAttachFileName
	Dim nAttachCount
	Dim nFolderId
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
	Dim strSql
	Dim i
	Dim strAttachForward

	strAttachForward = ""

	Set objPOP3= CreateObject("CMailCOM.POP3.1")
	objPOP3.Login Session("User"), Session("Pass")
	Session("LoginSuccess") = objPOP3.LoginSuccess

	If Session("LoginSuccess") = 1 Then 

		objPOP3.GetMailDataEx Request("indexOfMail")
		If Left(objPOP3.LastResponse, 4) = "-ERR" Then
			Response.Redirect Request("subpage") & ".asp"
			Response.End
		End If

		
		If Request("subpage")="foutbox" Then
			nFolderId = 2
			response.Write IDS_OUTBOX & " " & IDS_MAIL
		ElseIf Request("subpage")="ffavorite" Then
    	   		nFolderId = 3
			response.Write IDS_FAVORITE & " " & IDS_MAIL
		ElseIf Request("subpage")="ftrash" Then
			nFolderId = 4
			response.Write IDS_TRASHCAN & " " & IDS_MAIL
		ElseIf Request("subpage")="fdrafts" Then
			nFolderId = 5
		
			strBody = HTMLEncode(objPOP3.Body)
			strFrom = HTMLEncode(objPOP3.From)
			strTo = HTMLEncode(objPOP3.To)
			strCc = HTMLEncode(objPOP3.Cc)
			strSubject = HTMLEncode(objPOP3.Subject)
			strDate	= objPOP3.Date
			strUID = objPOP3.UID
			lSize = objPOP3.Size
			strEmailURL = objPOP3.EmailURL
			strBodyHtmlURL = objPOP3.BodyHtmlURL
			strHeaderURL = objPOP3.HeaderURL
			nAttachCount = objPOP3.AttachCount
			i = 0
			While i < nAttachCount 
				i = i + 1
				objPOP3.GetAttachInfo i
				strAttachURL = objPOP3.AttachURL
				strAttachForward = strAttachForward + strAttachURL + ";"
			Wend
%>
			</form><form action="sendmail.asp" method=post name="EditDraft">
		              <input type=Hidden name=Subject value="<%=strSubject%>">
		              <input type=Hidden name=To value="<%=strTo%>">
		              <input type=Hidden name=Body value="<%=strBody%>">
		              <input type=Hidden name=AttachFile value="<%=strAttachForward%>">
		              <input type=hidden name=uid value="<%=strUID%>">
			<input type=hidden name=folderid value="1">
			<input type=hidden name=reply value="0">
			<input type=hidden name=forward value="0">
			<input type=hidden name=draft value="1">
		            </form>
			<script language=javascript>
			document.forms("EditDraft").submit();
			</script>

<%
			Response.End
		Else
			response.Redirect "finbox.asp"
		End if

		Dim bReply, bForward

		bReply = objPOP3.IsReply
		bForward = objPOP3.IsForward
		strSql =  "update mailfolder set mailIsread='1' where account= '" & Session("Account") & "' and uid = '" & Request("indexOfMail") & "'"
		if(bReply = 1) Then
			strSql =  "update mailfolder set mailIsread='3' where account= '" & Session("Account") & "' and uid = '" & Request("indexOfMail") & "'"
		else
		if(bForward = 1) Then
			strSql =  "update mailfolder set mailIsread='5' where account= '" & Session("Account") & "' and uid = '" & Request("indexOfMail") & "'"
		end if
		end if
		conn.execute strSql,1,0

		strBody = objPOP3.Body

		strFrom = objPOP3.From
		strTo = objPOP3.To
		strCc = objPOP3.Cc
		strSubject = objPOP3.Subject
		strDate	= objPOP3.Date
		strUID = objPOP3.UID
		lSize = objPOP3.Size
		strBody = AutoLink(strBody)
		strBody = Replace(strBody, vbNewLine, vbNewLine&"<Br>")
		strSubject = HTMLEncode(strSubject)
		strTo = HTMLEncode(strTo)
		strCc = HTMLEncode(strCc)

		strEmailURL = objPOP3.EmailURL
		strHeaderURL = objPOP3.HeaderURL
		
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

            <table width="100%" border="0" bordercolordark=white bordercolor=gray cellspacing="0" >
              <tr valign="middle"> 
                <td valign="middle" width="100%">&nbsp;&nbsp; 
<%
		Dim Rs
		Dim nCurMailID
	
		Set rs=CreateObject("adodb.recordset")
		strSql="select * from mailfolder where account='" & Session("Account") & "' and uid='" & Request("indexOfMail") & "' order by mailid DESC"
		rs.open strSql,Conn,1,2
		if rs.eof then response.Redirect Request("subpage") & ".asp"
			nCurMailID = rs("mailid")
			rs.close
			strSql="select top 1 * from mailfolder where account='" & Session("Account") & "' and folderid='" & nFolderId & "' and mailid>" & nCurMailID
			rs.open strSql,Conn,1,2
			If not rs.eof then
				Response.Write "<a href='fgetmail.asp?subpage=" & Request("subpage")& "&indexOfMail=" & rs("uid") & "'>" & IDS_MAIL_PRI & "</a>&nbsp;&nbsp;"
			End if
			rs.close
			strSql="select top 1 * from mailfolder where account='" & Session("Account") & "' and folderid='" & nFolderId & "' and mailid<" & nCurMailID & " order by mailid DESC"
			rs.open strSql,Conn,1,2
			If not rs.eof then
				Response.Write "<a href='fgetmail.asp?subpage=" & Request("subpage")& "&indexOfMail=" & rs("uid") & "'>" & IDS_MAIL_NEXT & "</a>&nbsp;&nbsp;"
			End if
			Set rs = Nothing
%>
                  <a id=Reply href="javascript:OnReply()"><img src="images/reply.gif" width="16" height="16" hspace="5" border="0" align="absmiddle"><%=IDS_REPLY%></a>&nbsp;&nbsp; 
                  <a href="javascript:OnForward()"><img src="images/forward.gif" width="16" height="16" hspace="5" border="0" align="absmiddle"><%=IDS_FORWARD%>&nbsp;&nbsp;</a> 
                  <%If Request("subpage") <> "ftrash" Then%><a href="javascript:OnDelete()"><img src="images/rec.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_DELETE%></a> 
                  &nbsp;<%End If%><a href="javascript:OnPDelete()"><img src="images/delete.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_PDELETE%></a> 
                  &nbsp;<a href="javascript:OnMove()"><img src="images/move.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_MOVE%></a> 
              <select name="ToFolder" size="1" id="ToFolder">
                <option value="-1" selected></option>
                <option value="1"><%=IDS_INBOX%></option>
<%
			If Request("subpage") <> "foutbox" Then
%>
                <option value="2"><%=IDS_OUTBOX%></option>
<%
			End If
			If Request("subpage") <> "ffavorite" Then
%>
                <option value="3"><%=IDS_FAVORITE%></option>
<%
			End If
			If Request("subpage") <> "ftrash" Then
%>
				<option value="4"><%=IDS_TRASHCAN%></option>
<%
			End If
%>
              </select>
	  <a href="javascript:window.print()"><img src="images/print.gif" width="16" height="16" hspace="5" border="0" align="absmiddle"><%=IDS_PRINT%>&nbsp;</a> 
                  <a href="download.asp?urlOfAttach=<%=strHeaderURL%>" target=_top><img src="images/head.gif" width="16" height="16" hspace="5" border="0" align="absmiddle"><%=IDS_HEADER%></a> 
                  &nbsp;&nbsp; <a href="download.asp?urlOfAttach=<%=strEmailURL%>" target=_top><img src="images/origin.gif" width="16" height="16" hspace="5" border="0" align="absmiddle"><%=IDS_ORIGINAL_MAIL%></a>&nbsp;(<%=lSize%>bytes)</td>
                <td align="right">&nbsp; </td>
              </tr>
              <tr> 
                <td valign = "Top" colspan="2"> 
                  <table width="100%" border="1" bgcolor=white bordercolordark=white bordercolor=gray cellspacing="0" >
                    <tr bgcolor="#EEF7FF"> 
                      <td width="78"><b><font color=#000000>&nbsp;<%=IDS_SENDER%></font></b></td>
                      <td width="100%">&nbsp;<span id=From0><%= HTMLEncode(strFrom)%><b><font color="green">&nbsp;&nbsp;</font></b></span>&lt;<a href="addressm.asp?mail=<%= Server.URLEncode(strFrom)%>"><%= IDS_ADDTOADDR%><font color="#000000"></font></a>&gt;</td>
                    </tr>
                    <tr bgcolor="#EEF7FF"> 
                      <td><b><font color=#000000>&nbsp;<%=IDS_DATE%></font></b></td>
                      <td>&nbsp;<span id=Date0><%=strDate%></span></td>
                    </tr>
                    <tr bgcolor="#EEF7FF"> 
                      <td><b><font color="#000000">&nbsp;<%=IDS_RECEIVER%></font></b></td>
                      <td>&nbsp;<span id=To0><%=strTo%></span></td>
                    </tr>
                    <%If strCc <> "" Then%>
                    <tr bgcolor="#EEF7FF"> 
                      <td><b><font color="#000000">&nbsp;<%=IDS_CC%></font></b></td>
                      <td>&nbsp;<%=strCc%></td>
                    </tr>
                    <%End If%>
                    <tr bgcolor="#EEF7FF"> 
                      <td><b><font color=#000000>&nbsp;<%=IDS_SUBJECT%></font></b></td>
                      <td>&nbsp;<span id=Subject0><%= strSubject%></span></td>
                    </tr>
                    <%if nAttachCount > 0 then %>
                    <tr bgcolor="#EEF7FF"> 
                      <td><b><font color=green>&nbsp;<%=IDS_ATTACHEMENT%></font></b></td>
                      <td>&nbsp; 
                        <%
				i = 0
				While i < nAttachCount 
					i = i + 1
					objPOP3.GetAttachInfo i
					strAttachURL = objPOP3.AttachURL
					strAttachFileName = objPOP3.AttachFileName
					strAttachURL = strAttachURL
					strAttachForward = strAttachForward + strAttachURL + ";"
					Response.Write "|<a href=""download.asp?urlOfAttach="&strAttachURL&"""  target=_top> <img src=""images/print.gif"" width=16 height=16 border=0 align=absbottom>"&strAttachFileName&"</a>|&nbsp;"
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
                      <td height="216" colspan="2" class="back"><span id=Body0><%= strBody%></span><br>
                      </td>
                    </tr>
                    <tr valign="top" bgcolor="#FFFFFF"> 
                      <td height="12" colspan="2">&nbsp;<font color=#ffffff> 
                        <%if strBodyHtmlURL <> "" then%>
                        <a id=Reply href="<%=strBodyHtmlURL%>" target=_blank> 
                        <img src="images/html.gif" width="20" height="20" border="0" align="absmiddle"> 
                        <%=IDS_HTML_CONTENT%></a> 
                        <%End If%>
                        </font> </td>
                    </tr>
                    <tr> 
                      <td height="1"><img height="1" width="78" src="spacer.gif" border=0></td>
                      <td ></td>
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
                <td><img height="1" width="7" src="spacer.gif"></td>
              </tr>
            </table>
           </form>
            <form action="sendmail.asp" method=post name="ReplyMail">
              <input type=Hidden name=Subject value="">
              <input type=Hidden name=To value="">
              <input type=Hidden name=Body value="">
              <input type=Hidden name=AttachFile value="<%=strAttachForward%>" DISABLED>
              <input type=hidden name=uid value="<%=strUID%>">
	<input type=hidden name=folderid value="1">
	<input type=hidden name=reply value="0">
	<input type=hidden name=forward value="0">
            </form>
            <form action="fdelmail.asp" method=post name="DeleteMail">
              <input type=Hidden name=indexOfMail value="<%=strUID%>;">
              <input type=Hidden name=subpage value="<%=Request("subpage")%>">
            </form>
            <form action="fmvmail.asp" method=post name="MoveMail">
              <input type=Hidden name=indexOfMail value="<%=strUID%>;">
              <input type=Hidden name=subpage value="<%=Request("subpage")%>">
	      <input type=Hidden name=ToFolder value="">
            </form>
<%
	Else
		Response.Write objPOP3.LastResponse
	End If
	conn.Close
	Set conn = nothing
	Set objPOP3 = Nothing
%>
          </td>
        </tr>
      </table>
    </td>
    <td background="images/nav_06.gif">&nbsp; </td>
  </tr>
  <tr> 
    <td> <img src="images/nav_07.gif" width=6 height=9 ALT=""></td>
    <td background="images/nav_08.gif"><img src="images/nav_08.gif" width=121 height=9 ALT=""></td>
    <td> <img src="images/nav_09.gif" width=11 height=9 ALT=""></td>
  </tr>
  <tr> 
    <td height="1"><img height="1" width="6" src="spacer.gif"></td>
    <td></td>
    <td><img height="1" width="11" src="spacer.gif"></td>
  </tr>
</table>
</body>
</html>
