<% 
  Option Explicit
  Response.Buffer = True
  Server.ScriptTimeOut = 1800
%>
<!-- #include file=language.txt -->
<!--#include file="conn.asp" -->
<!-- #include file="encode.asp" -->
<Html>
<Head>
<title><!--#include file="webmailver.txt" --></title>
<LINK href="styles.css" rel=STYLESHEET type=text/css>
<SCRIPT language=JavaScript>
<!--
	function OnReturn()
	{
		window.history.back();
		window.event.returnValue=false;
	}
	function OnSuccess()
	{
		window.location.replace("finbox.asp")
	}
//-->
</SCRIPT>
</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000  >
<p>&nbsp;</p><TABLE width="70%" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
<%
	Dim nMaxMailSize
	nMaxMailSize = -1
	'--------- If you want to limite the mail size, please remove the ' in next line
	'nMaxMailSize = 2 * 1024 * 1024
	
	If nMaxMailSize <> -1 And Request.TotalBytes > nMaxMailSize Then
		Dim nLen
		For nLen = 0 To Request.TotalBytes/ (64 * 1024) 
			Request.BinaryRead (64 *  1024)
		Next
		If Request.TotalBytes - Request.TotalBytes / (64 *  1024) * (64 *  1024) > 0 Then
			Request.BinaryRead (Request.TotalBytes - Request.TotalBytes / (64 *  1024) * (64 *  1024))
		End If
		Response.Write "<tr><td>"
		Response.Write "Your mail is too big."
		Response.Write "</td></tr></table>"
		Response.End
	
	End If
%>
  <TR>
    <TD width="6"> <IMG SRC="images/nav_01.gif" WIDTH=6 HEIGHT=8 ALT=""></TD>
    <TD background="images/nav_02.gif"> <IMG SRC="images/nav_02.gif" WIDTH=121 HEIGHT=8 ALT=""></TD>
    <TD width="11"> <IMG SRC="images/nav_03.gif" WIDTH=11 HEIGHT=8 ALT=""></TD>
  </TR>
  <TR> 
    <TD width="6" background="images/nav_04.gif">&nbsp; </TD>
    <TD bgcolor="#FFFFFF"><table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray bordercolordark=white >
              <tr> 
                <td align=center valign="top"> <p>&nbsp;</p>
      <%
	Dim objPOP3
	const UploadOK   = 0
	Dim nUploadResult
	Dim objUploader
	Dim strError
	Dim strAttachmentFiles
	Dim objSMTP
	Dim i
	Dim strFileUploaded 
	Dim strDestPath 
	Dim strSMTPUserPath
	Dim rs
	Dim strUID
	Dim strSubject
	Dim strFrom
	Dim strDate
	Dim strTo
	Dim lSize
	Dim bRead
	Dim bSaveMessage
	Dim nFolderID
	Dim bReply
	Dim bForward
	Dim bSave2Draft
	Dim bDraft
	Dim sql
	strUID = ""
	nFolderID = -1
	bReply = 0
	bForward = 0

	Set objPOP3 = CreateObject("CMailCOM.POP3.1")

	If Session("LoginSuccess") = 1 Then 

	set objSMTP= CreateObject("CMailCOM.SMTP.1")
	objSMTP.CreateUserPath(Session("User"))

	objSMTP.StartUpload(Request)
	
'-------- get attached files when forward ------
	objSMTP.SetSubject("AttachAddedCount")
	Dim nAttachAddedCount
	nAttachAddedCount = 0

	If Len(objSMTP.Subject) > 0 Then
		nAttachAddedCount = CInt(objSMTP.Subject)
	End If

	For i = 0 To nAttachAddedCount - 1
		objSMTP.SetSubject("AttachAddedSel" & i)
		If objSMTP.Subject = "1" Then
			objSMTP.SetSubject("AttachAdded" & i)
			objSMTP.Attachment = objSMTP.Attachment + Mid(Server.MapPath("/maildata"), 1, InStrRev(Server.MapPath("/maildata"), "\") - 1) + Replace(objSMTP.Subject, "/", "\") + ";"
		End If
	Next
'-----------------------------------------------

	objSMTP.SetSubject("uid")
	If objSMTP.Subject <> "" Then
		strUID = objSMTP.Subject
	End If

	objSMTP.SetSubject("folderid")
	If objSMTP.Subject <> "" Then
		nFolderID = CInt(objSMTP.Subject)
	End If

	objSMTP.SetSubject("reply")
	If objSMTP.Subject <> "" Then
		bReply = CInt(objSMTP.Subject)
	End If

	objSMTP.SetSubject("forward")
	If objSMTP.Subject <> "" Then
		bForward = CInt(objSMTP.Subject)
	End If


'---------get save message sign --------------------
	objSMTP.SetSubject("SaveMessage")
	If Len(objSMTP.Subject) = 0 Then
		bSaveMessage = 0
	Else
		bSaveMessage = CInt(objSMTP.Subject)
	End If
'----------------------------------------------------------------------

'---------get save draft sign --------------------
	objSMTP.SetSubject("Save2Draft")
	If Len(objSMTP.Subject) = 0 Then
		bSave2Draft = 0
	Else
		bSave2Draft = CInt(objSMTP.Subject)
	End If
	objSMTP.SetSubject("Draft")
	If Len(objSMTP.Subject) = 0 Then
		bDraft = 0
	Else
		bDraft = CInt(objSMTP.Subject)
	End If
'----------------------------------------------------------------------


	objSMTP.SetSubject("Subject")

	objSMTP.SetBody("Body")

	'objSMTP.Body = objSMTP.Body & vbCrLf & vbCrLf & vbCrLf & "--------------------" & vbCrLf & "Do you yahoo?"
	
	objSMTP.SetTo("To")
	
	objSMTP.SetCc("Cc")

	objSMTP.SetBcc("Bcc")

	objSMTP.SetFrom("From")	
	
	If LCase(Session("emailaddress")) <> LCase(Session("replyaddr")) Then
		objSMTP.Reply = Session("replyaddr")
	End If

	For i = 1 To 6
		objSMTP.AddAttach("attach" & i)
	Next

	objSMTP.SaveMessage = bSaveMessage

	objSMTP.SaveDraft = bSave2Draft

	objSMTP.SendMail

	If Left(objSMTP.LastResponse, 3) = "+OK" Then
		objPOP3.Login Session("User"), Session("Pass")
		If bReply = 1 Then
			objPOP3.SetReplySign 1, strUID, nFolderID
			sql = "update mailfolder set mailIsread='3' where account= '" & Session("Account") & "' and uid = '" & strUID & "'"
			conn.execute sql, 1, 0
		End If
		If bForward = 1 Then
			objPOP3.SetForwardSign 1, strUID, nFolderID
			sql = "update mailfolder set mailIsread='5' where account= '" & Session("Account") & "' and uid = '" & strUID & "'"
			conn.execute sql, 1, 0
		End If
		If bDraft = 1 Then
			If (bSave2Draft = 1) Then
				sql =  "delete from mailfolder where account= '" & Session("Account") & "' and uid = '" & strUID & "'"
				conn.execute sql,1,0
				objPOP3.DeleteMailEx strUID
			End If
		End If
		If (bSaveMessage = 1 And bSave2Draft = 0) or bSave2Draft = 1 Then
			strUID = objSMTP.UID
			objPOP3.GetMailInfoEx strUID
			If Left(objPOP3.LastResponse, 3) = "+OK" Then
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
				set rs=Server.createobject("adodb.recordset")
				rs.open "mailfolder",Conn,1,3
				rs.addnew
				rs("account")=Session("Account")
				rs("uid")=strUID
				If (bSave2Draft = 1) Then
					rs("folderid") = "5"
				Else
					rs("folderid")= "2"
				End If
				rs("subject") =strSubject
				rs("mailfrom")=strFrom
				rs("maildate")=strDate
				rs("mailsize")=lSize
				rs("mailIsread")=bRead
				rs.update
				rs.Close
				set rs = nothing
			End if
		End If

%>
	<br><p> 
	<font color=#000000><b><%=IDS_SENT_SUCCESSFULLY%> <%=IDS_MAIL_SENT_TO%> </b></font><br>
	<%=HTMLEncode(objSMTP.To)%><br>
	<%=HTMLEncode(objSMTP.Cc)%><br>
	<%=HTMLEncode(objSMTP.Bcc)%><br></p>
        <input alt=Return border=0 height=21 name=back src="images/button-back.gif" width=61 value="  <%=IDS_OK%>  " onClick="OnSuccess()" type=button>
              <%
	    Else
%>
		<br><p> 
              <font color=gray><b> <%=IDS_SENT_FAILED%></b></font><br>
              <br>
               <%=HTMLEncode(objSMTP.LastResponse)%><br>
              <br></p>
              <input alt=Return border=0 height=21 name=back2 src="images/button-back.gif" width=61 value=" <%=IDS_RETURN%> " onClick="OnReturn()" type=button>
              <%
	    End If
		
	Else
		Response.Write objPOP3.LastResponse
	End If
	Set objPOP3 = Nothing
	Set objSMTP = Nothing
	conn.Close
	Set conn = Nothing
%>
<p> <br>
            </p>
            </td>
              </tr>
            </table></TD>
    <TD width="11" background="images/nav_06.gif">&nbsp; </TD>
  </TR>
  <TR> 
    <TD> <IMG SRC="images/nav_07.gif" WIDTH=6 HEIGHT=9 ALT=""></TD>
    <TD background="images/nav_08.gif"> <IMG SRC="images/nav_08.gif" WIDTH=121 HEIGHT=9 ALT=""></TD>
    <TD> <IMG SRC="images/nav_09.gif" WIDTH=11 HEIGHT=9 ALT=""></TD>
  </TR>
</TABLE>
</Body>
</Html>