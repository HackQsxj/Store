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
<SCRIPT language=JavaScript>
<!--
	function OnSend()
	{
	    if(sm.To.value =="") {
	      alert("<%=IDS_ERR_NULLMAIL%>.");
	     return false;
	      }
	   if (document.forms[0].isSign.checked) document.forms[0].Body.value += document.forms[0].sign.value;
	     document.forms[0].submit();
	}

	function OnSave()
	{
	   if (document.forms[0].isSign.checked) document.forms[0].Body.value += document.forms[0].sign.value;
	      document.forms[0].Save2Draft.disabled = false
	     document.forms[0].submit();
	}

	function OnBack()
	{
 	   window.location.replace("finbox.asp")
	}
	
	function AdAddr()
	{
	        window.open("addressadd.asp","adaddr","width=480,height=360,scrollbars=yes,resizable=yes")
	}
//-->
</SCRIPT>
</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000  >
<TABLE BORDER=0 CELLPADDING=0 CELLSPACING=0 width="100%">
  <TR> 
    <TD width="6"> <IMG SRC="images/nav_01.gif" WIDTH=6 HEIGHT=8 ALT=""></TD>
    <TD width="100%" background="images/nav_02.gif"> <IMG SRC="images/nav_02.gif" WIDTH=121 HEIGHT=8 ALT=""></TD>
    <TD width="11"> <IMG SRC="images/nav_03.gif" WIDTH=11 HEIGHT=8 ALT=""></TD>
  </TR>
  <TR> 
    <TD background="images/nav_04.gif">&nbsp; </TD>
    <TD bgcolor="#FFFFFF" > 
      <table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray  bordercolordark=white cellpadding="0"  >
        <tr bgcolor="#dcdcdc"  > 
          <td valign="top" bgcolor="#FFFFFF" width="100%"> 
            <%
	Dim strSubject
	Dim strTo
	Dim strBody
	Dim strFrom
	Dim strCc
	Dim strBcc
	Dim rs
	Dim sql
	Dim sign
	Dim i
	Dim arrString

	If Session("LoginSuccess") = 1 Then 
			strSubject = HTMLEncode(Request("Subject"))
			strTo = Trim(HTMLEncode(Request("To")))
			'strBody = HTMLEncode(Replace(Request("Body"), vbLf, vbLf+">"))
			strBody = HTMLEncode(Request("Body"))
			strCc = HTMLEncode(Request("Cc"))
			strBcc = HTMLEncode(Request("Bcc"))
			
     			set rs=createobject("adodb.recordset")
			sql="select * from parameter where account='" & Session("Account") & "'"
			rs.open sql,conn,1,3
			
			if not rs.eof then
			   sign = RS("sign")
			else
			   sign = ""
			end if
			rs.Close
			set rs = nothing

%>
            <Form name="sm" ENCTYPE="multipart/form-data" ACTION="postmail.asp?" METHOD=post>
              <Table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bordercolordark=white bgcolor="gray">
                <tr bgcolor="#F7F7F7"> 
                  <td colspan="2" ><img src="images/sendmail.gif" width="25" height="19" hspace="10" border="0" align="absmiddle"> 
                    <%=IDS_NEW_MAIL%> </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFFFF7" width="60"> 
                    <p align="center"><font color=#000000><span ><b><%=IDS_SENDER%></b></span></font> 
                  </td>
                  <%
 		Dim strUserName
		Dim objAdmin	
		Set objAdmin = CreateObject("CMailCOM.Admin.1")
		objAdmin.Login Session("User"),Session("Pass")
		If objAdmin.LoginSuccess = 1 Then
		   strUserName = objAdmin.UserName
		End If
		Set objAdmin = Nothing
			
	    %>
                  <td bgcolor="#EFFBFF" width="100%"> 
                    <%if Trim(strUserName) <> "" then%>
                    <input type=text name="From" value='"<%=strUserName%>"<<%=Session("emailaddress")%>>' size="50" readonly>
                    <%else%>
                    <input type=text name="From" value="<%=Session("emailaddress")%>" size="50" readonly>
                    <%end if%><input type="button" value="<%=IDS_SEND%>" onClick="OnSend()">&nbsp;&nbsp; 
                  </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFFFF7"> 
                    <p align="center"><font color=#000000><span ><b><%=IDS_RECEIVER%></b></span></font> 
                  </td>
                  <td bgcolor="#EFFBFF"> 
                    <input type=text name="To" value="<%=strTo%>" size="50" >
                    <font color="green">&nbsp;<a href="javascript:AdAddr()"><%=IDS_GETADDR%></a></font> 
                  </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFFFF7"> 
                    <p align="center"><font color=#000000 ><span ><b><%=IDS_CC%></b></span></font> 
                  </td>
                  <td bgcolor="#EFFBFF"> 
                    <input type=text name="Cc" value="<%=strCc%>" size="50" >
                    <font color="green">&nbsp;<a href="javascript:AdAddr()"><%=IDS_GETADDR%></a></font> 
                  </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFFFF7"> 
                    <p align="center"><font color=#000000 ><b><%=IDS_BCC%></b></font> 
                  </td>
                  <td bgcolor="#EFFBFF"> 
                    <input type=text name="Bcc" value="<%=strBcc%>" size="50" >
                    <font color="green">&nbsp;</font><a href="javascript:AdAddr()"><%=IDS_GETADDR%></a> 
                  </td>
                </tr>
                <tr> 
                  <td bgcolor="#FFFFF7"> 
                    <p align="center"><font color=#000000 ><span ><b><%=IDS_SUBJECT%></b></span></font> 
                  </td>
                  <td bgcolor="#EFFBFF"> 
                    <input type=text name="Subject" value = "<%=strSubject%>" size="50" >
                  </td>
                </tr>
                <Tr> 
                  <Td bgcolor="#FFFFFF" valign="top"> 
                    <div align="center"> </div>
                  </Td>
                  <Td bgcolor="#FFFFFF" valign="top"> 
                    <input type="checkbox" name="SaveMessage" value="1">
                    <%=IDS_SAVE_MESSAGE%><input type="hidden" name="Save2Draft" value="1" DISABLED><br>
                    <textarea name=Body rows = 10 cols = 65><%=strBody%></textarea>
                  </Td>
                </Tr>
                <Tr bgcolor="#F0F0F0"> 
                  <Td valign="middle"> 
                    <div align="center"><font color=#000000 ><span ><b><%=IDS_ATTACHEMENT%></b></span></font></div>
                  </Td>
                  <Td valign="top"> 
                    <input name="attach1" type="file">
                    <input name="attach2" type="file">
                    <br>
                    <input name="attach3" type="file">
                    <input name="attach4" type="file">
	    <br>
                    <input name="attach5" type="file">
                    <input name="attach6" type="file">
	<%If Len(Request("AttachFile")) > 0 Then
		i = 0
		arrString = Split(Request("AttachFile"), ";", -1, 1)
		If UBound(arrString) > 0 Then%>
		<input name=AttachAddedCount value="<%=UBound(arrString)%>" type=hidden><%
			While Len(arrString(i)) <> 0 And i < UBound(arrString) 
	%>
	 <br><input type="checkbox" name="AttachAddedSel<%=i%>" value="1" checked>
<input name=AttachAdded<%=i%> type=Hidden value="<%=arrString(i)%>">
<%=Mid(arrString(i), InStrRev(arrString(i), "/") + 1)%>
		<% i = i + 1
			Wend
	End If
	%>
 <%End If%>
                  </Td>
                </Tr>
                <Tr bgcolor="#FFFFFF"> 
                  <Td align="center" valign="middle"> 
                    <p align="center"> 
                      <input name="isSign" type="checkbox" style=" border: 0px solid; font-size: 9pt;" value="checkbox">
                      <font color="#000000"><strong><br>
                      <%=IDS_HAVESIGN %></strong></font></p>
                  </Td>
                  <Td align="center" valign="top"> 
                    <div align="left"> 
                      <textarea name="sign" cols="65" rows="4" id="sign">	
---------------------------------------------
<%=sign%></textarea>
                    </div>
                  </Td>
                </Tr>
                <tr> 
                  <td><img height="1" width="60" src="spacer.gif"></td>
                  <td></td>
                </tr>
              </Table>
		<input name=uid type=Hidden value="<%=Request("uid")%>">
		<input name=folderid type=hidden value="<%=Request("folderid")%>">
		<input name=reply type=hidden value="<%=Request("reply")%>">
		<input name=forward type=hidden value="<%=Request("forward")%>">
		<input name=draft type=hidden value="<%=Request("draft")%>">
            </Form>
          </Td>
        </Tr>
      </Table>
      <center>
        <input type="button" value="<%=IDS_SEND%>" onClick="OnSend()">&nbsp;&nbsp;
	<input type="button" value="<%=IDS_SAVE%>" onClick="OnSave()">&nbsp;&nbsp;
        <input type="button" value="<%=IDS_CANCEL%>" onClick="OnBack()">
      </center><br>
    </TD>
    <TD background="images/nav_06.gif" >&nbsp; </TD>
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
<p>
<%
	End If
	conn.Close
	Set conn = Nothing	
%>
</p>
</Body>
</Html>