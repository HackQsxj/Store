<% 
  Option Explicit
  Response.Buffer = TRUE
%>
<!-- #include file=language.txt -->
<!-- #include file=conn.asp -->
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
			document.forms[0].action="fdelmail.asp";
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
			document.forms[0].indexOfMail.value = str
		    	document.forms[0].ToFolder.value="4";
		    	document.forms[0].action="fmvmail.asp";
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
	    	document.forms[0].action="fmvmail.asp";
			document.forms[0].submit();
			}
		}
	  }

	}
	function OnGetMail()
	{
		document.forms[0].action="fgetmail.asp";
		document.forms[0].submit();
	}
	function SetMailID(id)
	{
		document.all.item("indexOfMail").value=id;
	}
//-->
</script>
</head>
<body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000  >
<table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray  bordercolordark=white  >
  <tr bgcolor="#dcdcdc"  valign="left"> 
    <td width="100%"  height="100%" align="left" valign="top" bgcolor="#FFFFF7"> 
<%
	Dim objPOP3
	Dim rs
	Dim strSql
	Dim nI

	Set objPOP3 = CreateObject("CMailCOM.POP3.1")
	objPOP3.Login Session("User"), Session("Pass")
	Session("LoginSuccess") = objPOP3.LoginSuccess
	
	If Session("LoginSuccess")= 1 Then
 	     set rs=createobject("adodb.recordset")
	     strSql="select * from mailfolder where account='" & Session("Account") & "' and folderid='2' order by mailid DESC"
	     rs.open strSql,Conn,1,2
%>
      <form action="" method=post align="left">
        <table width="100%" >
          <tr > 
            <td valign=center width="100%" height="1"><%=IDS_OUTBOX%>&nbsp;<%=rs.recordcount%> 
              <%=IDS_MAILS%>. &nbsp; <a href="javascript:OnDelete()"><img src="images/rec.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_DELETE%></a> 
              &nbsp;<a href="javascript:OnPDelete()"><img src="images/delete.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_PDELETE%></a> 
            </td>
          </tr>
        </table>
        <table width="100%" border="0" cellpadding="4" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor=#C7DFF4>
          <tr valign=middle bgcolor="#333366"> 
            <td width="24" align="center" ><font color="#FFFFFF"><b > 
              <input name=chkall  onClick=CheckAll(document.forms[0].chkall[0].checked) type=checkbox value=on>
              </b></font></td>
            <td width="19"><font color="#FFFFFF">&nbsp;</font></td>
            <td width="156"><font color="#FFFFFF"><%=IDS_RECEIVER%></font></td>
            <td width="100%"><font color="#FFFFFF"><%=IDS_SUBJECT%></font></td>
            <td width="124"><font color="#FFFFFF"><%=IDS_DATE%></font></td>
            <td width="46"><font color="#FFFFFF"><%=IDS_SIZE%></font></td>
          </tr>
<%
		dim nCurPage
		dim nCurNo
		dim nCurCur
		dim nMailCount
		
		nMailCount = rs.recordcount
		nCurPage = 1
		nCurNo = 1
		nCurCur = 1
		
  		if Request.QueryString("pages")<>"" then
		    if not IsNumeric(Request.QueryString("pages")) then response.Redirect "foutbox.asp"
            			nCurpage=cint(Request.QueryString("pages"))
       		   end if
		nCurNo = (nCurPage-1) * session("maxlist") + 1
		
		For nI = 1 To nCurNo - 1
		  rs.movenext
		  if RS.eof then response.Redirect "foutbox.asp"
		Next
		
		do while (nCurNo <= nMailCount) and (nCurCur<=Session("maxlist"))
			objPOP3.GetMailInfoEx rs("uid")
  
%>
          <tr bgcolor="#F5F5FA"> 
            <td height=1 align=center vAlign=top> <b> 
              <Input name=sel type=checkbox value='<%=HTMLEncode(RS("uid"))%>'>
              </b></td>
            <td> 
	<%if RS("mailIsread") mod 2 = 1 then %>
	<%if RS("mailIsread") = 3 then%><img src="images/reply.gif" width="16" height="16"><%else%>
	<%if RS("mailIsread") = 5 then%><img src="images/forward.gif" width="16" height="16"><%else%><img src="images/oldmail.gif" width="16" height="16"><%end if%><%end if%>	
             <%else 
	if rs("mailIsread") = 0 then %>
              <img src="images/newmail.gif" align="absmiddle"> 
              <%else%>
              &nbsp; 
              <%end if
              end if%>
            </td>
            <td> 
              <%if rs("mailIsread") = 0 then %>
              <b><%=HTMLEncode(objPOP3.To)%></b> 
              <%else%>
              <%=HTMLEncode(objPOP3.To)%> 
              <%end if%>
            </td>
            <td><a href='fgetmail.asp?subpage=foutbox&indexOfMail=<%=HTMLEncode(rs("uid"))%>' > 
              <%if rs("mailIsread") = 0 then %>
              <b><%=HTMLEncode(rs("subject"))%> </b> 
              <%else%>
              <%=HTMLEncode(rs("subject"))%> 
              <%end if%>
              </a></td>
            <td> 
              <%if rs("mailIsread") = 0 then %>
              <b><%=HTMLEncode(RS("maildate"))%> </b> 
              <%else%>
              <%=HTMLEncode(RS("maildate"))%> 
              <%end if%>
            </td>
            <Td> 
              <%if rs("mailIsread") = 0 then %>
              <b><%If RS("mailsize") Then Response.Write(CStr(Round(RS("mailsize")/1024+0.5))&" K ") Else Response.Write("1 K ")%> </b> 
              <%else%>
              <%If RS("mailsize") Then Response.Write(CStr(Round(RS("mailsize")/1024+0.5))&" K ") Else Response.Write("1 K ")%> 
              <%end if%>
            </Td>
          </Tr>
          
<%
		rs.movenext
        		nCurCur = nCurCur + 1
		nCurNo = nCurNo + 1 
	    loop
%>
            <tr bgcolor="#FFFFFF"> 
            <td height="0"><img height="1" width="24" src="spacer.gif"></td>
            <td><img height="1" width="19" src="spacer.gif"></td>
            <td><img height="1" width="156" src="spacer.gif"></td>
            <td></td>
            <td><img height="1" width="124" src="spacer.gif"></td>
            <td><img height="1" width="46" src="spacer.gif"></td>
          </tr>
        </table>
        <table width="100%" >
          <tr> 
            <td align=left height=1 vAlign=top width="100%"> <b > 
              <input name=chkall  onclick=CheckAll(document.forms[0].chkall[1].checked) type=checkbox value=on>
              </b> <font color=#cc3366><%=IDS_SELECT_ALL%></font> &nbsp; <a href="javascript:OnDelete()"><img src="images/rec.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_DELETE%></a> 
              &nbsp;<a href="javascript:OnPDelete()"><img src="images/delete.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_PDELETE%></a> 
              &nbsp;&nbsp;<a href="javascript:OnMove()"><img src="images/move.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_MOVE%></a> 
              <select name="ToFolder" size="1" class="normal-font" id="ToFolder">
                <option value="-1" selected></option>
                <option value="1"><%=IDS_INBOX%></option>
                <option value="3"><%=IDS_FAVORITE%></option>
                <option value="4"><%=IDS_TRASHCAN%></option>
                <option value="5"><%=IDS_DRAFTS %></option>
              </select>
            </td>
          </tr>
        </table>
        <input type = hidden value = "-1" name=indexOfMail id=indexOfMail>
        <input name="subpage" type="hidden" id="subpage" value="foutbox">
        <input type = hidden value="<%=Request("pages")%>" name=pages id=pages>
      </form>
      <%
	rs.Close
	Set rs = nothing
	Else
	   Response.Write objPOP3.LastResponse
	End If
	Set objPOP3 = Nothing
	conn.Close
	Set conn = nothing
%>
    </td>
  </tr>
  <%
    If nMailCount>session("maxlist") Then
	Dim nPages
	nPages = nMailcount \ Session("maxlist")
	If nPages * Session("maxlist") <> nMailcount Then
		nPages = nPages + 1
	End If
	
%>
  <tr bgcolor="#dcdcdc"  valign="left"> 
    <td valign="top" bgcolor="#FFFFFF"  height="100%"> 
      <div align="center">>> 
        <%    For nI=1 To nPages %>
        &nbsp; 
        <%If nI<> nCurPage Then %>
        <a href="foutbox.asp?pages=<%=nI%>"><%=nI%></a> 
        <% Else %>
        <b><%=nI%></b> 
        <%End  If%>
        &nbsp; 
        <% Next %>
        << </div>
    </td>
  </tr>
<% 
	End  If
%>
</table>
</body>
</html>
