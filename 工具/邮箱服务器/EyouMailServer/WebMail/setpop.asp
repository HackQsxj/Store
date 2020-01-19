<% 
  Option Explicit
  Response.Buffer = True
%>
<!-- #include file=language.txt -->
<Html>
<Head>
<title> 
<!-- #include file=webmailver.txt -->
</title>
<Style Type = text/css>
a:link {text-decoration:none; cursor: hand}
a:visited {text-decoration:none}
a:hover {text-decoration:underline}
body,table {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</Style>
<SCRIPT language=JavaScript>
<!--
	function OnModify()
	{
		document.forms[0].Modify.value = "1";
		document.forms[0].submit();
	}
	function OnReturn()
	{
		window.location.replace("mailoptions.asp")
	}
	function OnSuccess()
	{
		window.location.replace("mailoptions.asp")
	}	
//-->
</SCRIPT>
</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000 >
<table border="0"  bordercolordark=white bordercolor=gray cellspacing="0" height="100%" width="100%" >
  <tr bgcolor="#dcdcdc">
    <td colspan="4" valign="top" bgcolor="#FFFFF7"> 
      <%
	Dim objAdmin
	Dim nI
	Dim nCount
	
	Set objAdmin = CreateObject("CMailCOM.Admin.1")
	objAdmin.AuthLogin Session("User"),Session("Pass")
	If objAdmin.LoginSuccess = 1 Then
		objAdmin.Open Session("Account"), "EmailPOP3RemoteInfo"
		If Request("Submit") <> "" Then
			objAdmin.Value("Enable") = Request("Enable")
			objAdmin.Value("POP3Server") = Request("POP3Server")
			objAdmin.Value("POP3Account") = Request("POP3Account")
			objAdmin.Value("POP3Password") = Request("POP3Password")
			objAdmin.Value("LeaveCopy") = Request("LeaveCopy")
			If Request("Submit") = IDS_MODIFY Then	objAdmin.Edit Request("Index")
			If Request("Submit") = IDS_DELETE Then objAdmin.Delete Request("Index")
			If Request("Submit") = IDS_ADD_NEW Then objAdmin.AddNew
			objAdmin.Update			
			If Left(objAdmin.LastResponse, 3) = "+OK" Then
%>
      <table width="438" border="1" align="center" cellspacing="0" bordercolor=gray bordercolordark=white >
        <tr> 
          <td align=center valign="top" bgcolor="#EFFBFF"> 
            <p><br>
            </p>
            <p><br>
              <span ><font color=green><b><%=IDS_SET_POP%> <%=IDS_SET_CHANGESUSS%> 
              </b></font></span></p>
            <p><br>
              <span > 
              <input alt=Return border=0 height=21 name=back src="button-back.gif" width=61 value="  <%=IDS_OK%>  " onClick="window.location.replace('setpop.asp')" type=button>
              </span><br>
              <br>
              <br>
            </p></td>
        </tr>
      </table>
<% 
			Else
				Response.Redirect("setpop.asp?Err="&objAdmin.LastResponse)
				Response.End
			End If
				
		Else
		
	%>
      <%
	If Len(Request("Err")) <> 0 Then
%>
      <font color = Red > <%=Request("Err")%> </font> 
      <%
	End If
%>
     
		<%
		nCount = objAdmin.Count
		For nI = 1 to nCount
			objAdmin.GetData nI
		%>
		 <form action="setpop.asp" method=Post>
          <input type=Hidden name=Index value="<%=nI%>">
        <table width="80%" border="0" align="center" cellpadding="5" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor="#C6DFF7">
          <tr bgcolor="#EEF5FF"> 
            <td colspan="4"><img src="images/setup.gif" width="16" height="16" align="absmiddle"><span ><font color=#000000><b>&nbsp;<%=IDS_SET_POP%></b></font></span></td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="195"> 
              <div align="center"><%=IDS_ENABLE_POP3_RETRIVING%></div>
            </td>
            <td width="175" bgcolor="#EFFBFF"> &nbsp;&nbsp;&nbsp; 
              <input type=checkbox name=Enable <%if objAdmin.Value("Enable") = "1" then %>checked<%End If%> value="1">
            </td>
            <td width="195" bgcolor="#EFFBFF"><%=IDS_POP3_SERVER_ADDRESS%></td>
            <td width="178" bgcolor="#EFFBFF"> 
              <input type=Text name=POP3Server value="<%=objAdmin.Value("POP3Server")%>" >
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_POP3_ACCOUNT%></div>
            </td>
            <td> 
              <input type=Text name=POP3Account value="<%=objAdmin.Value("POP3Account")%>" >
              &nbsp;&nbsp;&nbsp; </td>
            <td><%=IDS_POP3_PASSWORD%></td>
            <td> 
              <input type="Password" name=POP3Password value="<%=objAdmin.Value("POP3Password")%>" >
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_LEAVE_COPY%></div>
            </td>
            <td colspan="3"> &nbsp;&nbsp;&nbsp; 
              <input type=checkbox name=LeaveCopy <%if objAdmin.Value("LeaveCopy") = "1" then %>checked<%End If%> value="1">
            </td>
          </tr>
          <tr bgcolor="#EEF5FF"> 
            <td colspan="4"> 
              <div align="center"> 
                <input type=submit height=21 width=61 border=0 value="<%=IDS_MODIFY%>" name="Submit">
                <input type=submit height=21 width=61 border=0 value="<%=IDS_DELETE%>" name="Submit">
                <input type="button" name="Button" value="<%=IDS_RETURN%>" onClick="window.location.replace('mailoptions.asp')">
              </div>
            </td>
          </tr>
        </table>
        </form>
		
      <%Next%>
      <form action="setpop.asp" method=Post>
          <input type=Hidden name=Index value="<%=nI%>">
        <table width="80%" border="0" align="center" cellpadding="5" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor="#C6DFF7">
          <tr bgcolor="#EEF5FF"> 
            <td colspan="4"><img src="images/setup.gif" width="16" height="16" align="absmiddle"><span ><font color=#000000><b>&nbsp;<%=IDS_SET_POP%></b></font></span></td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="195"> 
              <div align="center"><%=IDS_ENABLE_POP3_RETRIVING%></div>
            </td>
            <td width="175"> &nbsp;&nbsp;&nbsp; 
              <input type=checkbox name=Enable checked value="1">
            </td>
            <td width="195"><%=IDS_POP3_SERVER_ADDRESS%></td>
            <td width="178"> 
              <input type=Text name=POP3Server value="" >
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_POP3_ACCOUNT%></div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=POP3Account value="" >
            </td>
            <td><%=IDS_POP3_PASSWORD%></td>
            <td> 
              <input type="Password" name=POP3Password value="" >
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_LEAVE_COPY%></div>
            </td>
            <td colspan="3"> &nbsp;&nbsp;&nbsp; 
              <input type=checkbox name=LeaveCopy value="1">
            </td>
          </tr>
          <tr bgcolor="#EEF5FF"> 
            <td colspan="4"> 
              <div align="center"> 
                <input type=submit height=21 width=61 border=0 value="<%=IDS_ADD_NEW%>" name="Submit">
                <input type="button" name="Button" value="<%=IDS_RETURN%>" onClick="window.location.replace('mailoptions.asp')">
              </div>
            </td>
          </tr>
        </table>
        </form>
		 
      <% 
	  	End if
	Else
		Response.Write objAdmin.LastResponse
	End If
	set objAdmin = nothing
%>
      </td>
</tr>
</table>
</Body>
</Html>