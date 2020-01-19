<% 
	Option Explicit
	Response.Buffer = TRUE
%>
<!-- #include file=language.txt -->
<!-- #include file="encode.asp" -->
<html>
<head>
<title><!--#include file="webmailver.txt" --></title>
<style type = text/css>
	a:link {text-decoration:none; cursor: hand}
	a:visited {text-decoration:none}
	a:hover {text-decoration:underline}
	body,table {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</style>
<script language=javascript>
<!--
	function CheckAll(v)
	{
		var i;
		for (i=0;i<document.forms[0].elements.length;i++)
		{
			var e = document.forms[0].elements[i];
		        e.checked = v;
		}
	}
	function OnPDelete()
	{
		var str, a, i;
		str = new String("");
		for(i = 0; i < document.forms[0].elements.length ; i ++)
		{
			var e = document.forms[0].elements[i];
			if(e.name == 'sel')
			{
			   if ( e.checked == true)
			   {
		   		a = e.value;
				str = str + a + ";";
			   }
			};
		}
		if(str == "")
		{
			alert("<%=IDS_ALERT_NO_SELECTION%>")

		}
		else
		{
			if(confirm("<%=IDS_ALERT_PDELETE%>")==true)
			{
			document.forms[0].indexOfMail.value = str
			document.forms[0].action="delmail.asp";
			document.forms[0].submit();
			}
		}
	}
	function OnDelete()
	{
	  var str, a, i;
	  str = new String("");
		for(i = 0; i < document.forms[0].elements.length ; i ++)
		{
			var e = document.forms[0].elements[i];
			if(e.name == 'sel')
			{
			   if ( e.checked == true)
			   {
		   		a = e.value;
				str = str + a + ";";
			   }
			};
		}
		if(str == "")
		{
			alert("<%=IDS_ALERT_NO_SELECTION %>")

		}
		else
		{
			document.forms[0].indexOfMail.value = str;
			document.forms[0].ToFolder.value = 4;
	    		document.forms[0].action="mvmail.asp";
			document.forms[0].submit();
		}
	  }
	function OnMove()
	{
	  var str, a, i;
	  str = new String("");
	  if (document.forms[0].ToFolder.value>0)
	   { 
		for(i = 0; i < document.forms[0].elements.length ; i ++)
		{
			var e = document.forms[0].elements[i];
			if(e.name == 'sel')
			{
			   if ( e.checked == true)
			   {
		   		a = e.value;
				str = str + a + ";";
			   }
			};
		}
		if(str == "")
		{
			alert("<%=IDS_ALERT_NO_SELECTION_MOVE %>")

		}
		else
		{
			if(confirm("<%=IDS_ALERT_MOVE%>")==true)
			{
			document.forms[0].indexOfMail.value = str
		    	document.forms[0].action="mvmail.asp";
			document.forms[0].submit();
			}
		}
	  }
	}
	function OnGetMail()
	{
		document.forms[0].action="getmail.asp";
		document.forms[0].submit();
	}
	function SetMailID(id)
	{
		document.all.item("indexOfMail").value=id;
	}
//-->
</script>
</head>
<body bgcolor=#FFFFF7 alink=#333333 vlink=#000000 link=#000000  >
<table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray  bordercolordark=white>
  <tr bgcolor="#dcdcdc"  valign="left"> 
    <td valign="top" bgcolor="#FFFFF7" width="100%"  height="100%"> 
      <%
	Dim objPOP3
	Dim nMailCount
	Dim nI
	Dim strSubject
	Dim strFrom
	Dim strDate
	Dim bRead
	Dim lSize
	Dim strUID
	Dim bReply
	Dim bForward

	Set objPOP3 = CreateObject("CMailCOM.POP3.1")
	objPOP3.Login Session("User"), Session("Pass")
	Session("LoginSuccess") = objPOP3.LoginSuccess
	
	If Session("LoginSuccess")= 1 Then
		objPOP3.GetMailBoxInfo
		nMailCount = objPOP3.MailCount
%>
      <form action="" method=post align="left">
        <table width="100%" >
          <tr> 
            <td valign=center width="100%" height="1"><%=IDS_INBOX%>&nbsp;<%=nMailCount%> 
              <%=IDS_MAILS%>.&nbsp; <a href="javascript:OnDelete()"><img src="images/rec.gif" width="14" height="14" hspace="5" border="0" align="absbottom"><%=IDS_DELETE%></a> 
              <a href="javascript:OnPDelete()"><img src="images/delete.gif" width="14" height="14" hspace="5" border="0" align="absbottom"><%=IDS_PDELETE%></a> 
            </td>
          </tr>
        </table>
        <table width="100%" border="0" cellpadding="4" cellspacing="1" bordercolordark=white bgcolor=#C7DFF4>
          <tr vAlign=middle bgcolor="#FFFFFF"> 
            <td width="24" align="center" bgcolor="#FFFFFF" ><font color="#000000"><b> 
              <input name=chkall  onClick=CheckAll(document.forms[0].chkall[0].checked) type=checkbox value=on>
              </b></font></td>
            <td width="19"><font color="#000000">&nbsp;</font></td>
            <td width="156"><font color="#000000">&nbsp;<%=IDS_SENDER%></font></td>
            <td width="100%"><font color="#000000">&nbsp;<%=IDS_SUBJECT%></font></td>
            <td width="124"><font color="#000000">&nbsp;<%=IDS_DATE%></font></td>
            <td width="46"><font color="#000000">&nbsp;<%=IDS_SIZE%></font></td>
          </tr>
          <%

		dim nCurPage
		dim nCurNo
		dim nCurCur
		dim strMail
		
		nCurPage = 1
		nCurNo = nMailCount
		nCurCur = 1
		
  		if Request.QueryString("pages")<>"" then
			if not IsNumeric(Request.QueryString("pages")) then response.Redirect "finbox.asp"
				nCurpage=cint(Request.QueryString("pages"))
			end if
			nCurNo = nMailCount - (nCurPage-1) * session("maxlist")
			do while (nCurNo > 0) and (nCurCur<=Session("maxlist"))
				objPOP3.GetMailInfo nCurNo
				strSubject = objPOP3.Subject
				If Len(strSubject) = 0 Then
					strSubject = "(nosubject)"
				End If
				strFrom = objPOP3.From
				If Len(strFrom) = 0 Then
					strFrom = "(noaddr)"
				End If
				strDate	   = objPOP3.Date
				If Len(strDate) = 0 Then
					strDate = "(nodate)"
				End If
				bRead = objPOP3.IsRead
				bReply = objPOP3.IsReply
				bForward = objPOP3.IsForward
				lSize = CStr(Round(objPOP3.Size/1024+0.5))&" K "
				strUID = objPOP3.UID
%>
          <tr> 
            <td width="24" height=1 align=center valign=top bgcolor="#EFFBFF"> 
              <b> 
              <input name=sel type=checkbox value='<%=strUID%>'>
              </b></td>
            <td width="19" bgcolor="#EFF9FE"> 
              <%if bRead = 1 then 
		if bReply = 1 Then
	%>
<img src="images/reply.gif" width="16" height="16" align="absmiddle"> 
	<%
		else
			if bForward = 1 Then
	%><img src="images/forward.gif" width="16" height="16" align="absmiddle"> <%
			else%>
<img src="images/oldmail.gif" width="16" height="16" align="absmiddle"> 
	<%
			end if
		end if
	else
	%>
              <img src="images/newmail.gif" width="19" height="16" align="absmiddle"> 
	<%
	end if
	%>
            </td>
            <td width="156" bgcolor="#EFF9FE"> 
              <%if bRead = 0 then %>
              <b> 
              <%=HTMLEncode(strFrom)%>
              </b> 
              <%else%>
              <%=HTMLEncode(strFrom)%>
              <%end if%>
            </td>
            <td bgcolor="#EFF9FE"><a href="getmail.asp?indexOfMail=<%=nCurNo%>&mailcount=<%=nMailCount%>" > 
              <%if bRead = 0 then %>
              <b> 
              <%=HTMLEncode(strSubject)%>
              </b> 
              <%else%>
              <%=HTMLEncode(strSubject)%>
              <%end if%>
              </a></td>
            <td width="124" bgcolor="#EFF9FE"> 
              <%if bRead = 0 then %>
              <b><%=strDate%> </b> 
              <%else%>
              <%=strDate%> 
              <%end if%>
            </td>
            <td width="46" bgcolor="#EFF9FE"> 
              <%if bRead = 0 then %>
              <b><%=lSize%> </b> 
              <%else%>
              <%=lSize   %> 
              <%end if%>
            </td>
          </tr>
          <%
			nCurCur = nCurCur + 1
			nCurNo = nCurNo -1 
		Loop
%>
<tr bgcolor=#ffffff> 
            <td height="9"><img height="1" width="24" src="spacer.gif"></td>
            <td><img height="1" width="19" src="spacer.gif"></td>
            <td><img height="1" width="156" src="spacer.gif"></td>
            <td></td>
            <td><img height="1" width="124" src="spacer.gif"></td>
            <td><img height="1" width="46" src="spacer.gif"></td>
          </tr>
        </Table>
        <table width="100%" >
          <tr> 
            <td align=left  height=1 vAlign=top width="100%"> <b > 
              <input name=chkall  onclick=CheckAll(document.forms[0].chkall[1].checked) type=checkbox value=on>
              </b> <font color=#cc3366><%=IDS_SELECT_ALL%></font> &nbsp;<a href="javascript:OnDelete()"><img src="images/rec.gif" width="14" height="14" hspace="5" border="0" align="absbottom"><%=IDS_DELETE%></a> 
              <a href="javascript:OnPDelete()"><img src="images/delete.gif" width="14" height="14" hspace="5" border="0" align="absbottom"><%=IDS_PDELETE%></a> 
              <a href="javascript:OnMove()"><img src="images/move.gif" width="14" height="14" hspace="5" border="0" align="absbottom"><%=IDS_MOVE%></a> 
              <select name="ToFolder" size="1" class="normal-font" id="ToFolder">
                <option value="-1" selected></option>
                <option value="2"><%=IDS_OUTBOX %></option>
                <option value="3"><%=IDS_FAVORITE %></option>
                <option value="4"><%=IDS_TRASHCAN %></option>
                <option value="5"><%=IDS_DRAFTS %></option>
              </select>
            </td>
          </tr>
        </table>
        <input type = hidden value = "-1" name=indexOfMail id=indexOfMail>
        <input type = hidden value = "<%=nMailCount%>" name=mailcount id=mailcount>
        <input type = hidden value = "<%=Request("pages")%>" name=pages id=pages>
       </form>
      <%
	Else
		Response.Write objPOP3.LastResponse
	End If
	Set objPOP3 = NoThing
%>
    </td>
  </tr>
<%
    if nMailCount>session("maxlist") then
	dim nPages
	nPages = nMailcount \ Session("maxlist")
	If nPages * Session("maxlist") <> nMailcount Then
		nPages = nPages + 1
	End If
	
%>
  <tr bgcolor="#dcdcdc"  valign="left"> 
    <td valign="top" bgcolor="#FFFFFF"  height="100%"> 
      <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#666666">
        <tr> 
          <td bgcolor="#FFFFFF" width="100%"> 
            <div align="center">>> 
              <%    for nI=1 to nPages %>
              <%if nI<> nCurPage then %>
              <a href="finbox.asp?pages=<%=nI%>"><%=nI%></a> 
              <% else %>
              <b><%=nI%></b> 
              <%end if%>
              &nbsp; 
              <% next %>
              << </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
<% 
	end if
%>
</table>
</body>
</html>
