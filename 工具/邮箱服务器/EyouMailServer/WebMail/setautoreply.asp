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
		objAdmin.Open Session("Account"), "EmailAutoReplyInfo"
		If Request("Submit") <> "" Then
			objAdmin.Value("Enable") = Request("Enable")
			objAdmin.Value("Subject") = Request("Subject")
			objAdmin.Value("Body") = Request("Body")
			If Request("Submit") = IDS_MODIFY Then	objAdmin.Edit Request("Index")
			objAdmin.Update			
			If Left(objAdmin.LastResponse, 3) = "+OK" Then
%>
      <table width="438" border="1" align="center" cellspacing="0" bordercolor=gray bordercolordark=white >
        <tr> 
          <td align=center valign="top" bgcolor="#EFFBFF"> 
            <p><br>
            </p>
            <p><br>
              <span ><font color=green><b><%=IDS_AUTO_REPLY%> <%=IDS_SET_CHANGESUSS%> 
              </b></font></span></p>
            <p><br>
              <span > 
              <input alt=Return border=0 height=21 name=back src="button-back.gif" width=61 value="  <%=IDS_OK%>  " onClick="window.location.replace('setautoreply.asp')" type=button>
              </span><br>
              <br>
              <br>
            </p></td>
        </tr>
      </table>
<% 
			Else
				Response.Redirect("setautoreply.asp?Err="&objAdmin.LastResponse)
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
     

		 <form action="setautoreply.asp" method=Post>
        <table width="80%" border="0" align="center" cellpadding="5" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor="#C6DFF7">
          <tr bgcolor="#EEF5FF"> 
            <td colspan="2"><img src="images/setup.gif" width="16" height="16" align="absmiddle"><span ><font color=#000000><b>&nbsp;<%=IDS_AUTO_REPLY %></b></font></span></td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="285"> 
              <div align="center"><%=IDS_ENABLE%> </div>
            </td>
            <td width="480"> &nbsp;&nbsp; 
              <input type=checkbox name=Enable <%if objAdmin.Value("Enable") = "1" then %>checked<%End If%> value="1">
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_SUBJECT%></div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=Subject value="<%=objAdmin.Value("Subject")%>" >
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_BODY%></div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <textarea name="Body" rows="10" cols="40"><%=objAdmin.Value("Body")%> </textarea>
            </td>
          </tr>
          <tr bgcolor="#EEF5FF"> 
            <td colspan="2"> 
              <div align="center"> 
                <input type=submit height=21 width=61 border=0 value="<%=IDS_MODIFY%>" name="Submit">
                <input type="button" name="Button" value="<%=IDS_RETURN%>" onClick="window.location.replace('mailoptions.asp')">
              </div>
            </td>
          </tr>
        </table>
        <br></form>
		

      
		 
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