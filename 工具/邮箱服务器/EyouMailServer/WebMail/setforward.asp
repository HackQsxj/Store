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
<script language=javascript>
function CheckAll(name, v)
{
		var i;
		for (i=0;i<document.all.length;i++)
		{
			var e = document.all(i);
			if(e.name == name)
			{
				if(v==true)
					e.value='1'
				else
					e.value='0'
			}
		}
}
</script>
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
		objAdmin.Open Session("Account"), "EmailForwardInfo"
		If Request("Submit") <> "" Then
			objAdmin.Value("Enable") = Request("Enable")
			objAdmin.Value("LeaveCopy") = Request("LeaveCopy")
			objAdmin.Value("EmailAddress") = Request("EmailAddress")
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
              <span ><font color=green><b><%=IDS_AUTO_FORWARD%> <%=IDS_SET_CHANGESUSS%> 
              </b></font></span></p>
            <p><br>
              <span > 
              <input alt=Return border=0 height=21 name=back src="button-back.gif" width=61 value="  <%=IDS_OK%>  " onClick="window.location.replace('setforward.asp')" type=button>
              </span><br>
              <br>
              <br>
            </p></td>
        </tr>
      </table>
<% 
			Else
				Response.Redirect("setforward.asp?Err="&objAdmin.LastResponse)
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
		
		 
          
        
      <table width="80%" border="0" align="center" cellpadding="5" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor="#C6DFF7">
        <tr bgcolor="#EEF5FF"> 
          <td colspan="2"><img src="images/setup.gif" width="16" height="16" align="absmiddle"><span ><font color=#000000><b>&nbsp;<%=IDS_AUTO_FORWARD%></b></font></span></td>
        </tr>
        <tr bgcolor="#EFFBFF"> 
          <td width="285"> 
            <div align="center"><%=IDS_ENALBE_EMAIL_FORWARDING%></div>
          </td>
          <td width="480"> &nbsp;&nbsp;&nbsp; 
            <input type=checkbox name=Enable <%if objAdmin.Value("Enable") = "1" then %>checked<%End If%> value="1" onclick="CheckAll('Enable', this.checked)">
          </td>
        </tr>
        <tr bgcolor="#EFFBFF"> 
          <td> 
            <div align="center"><%=IDS_LEAVE_COPY_LOCAL%></div>
          </td>
          <td> &nbsp;&nbsp;&nbsp; 
            <input type=checkbox name=LeaveCopy <%if objAdmin.Value("LeaveCopy") = "1" then %>checked<%End If%> value="1" onclick="CheckAll('LeaveCopy', this.checked)">
          </td>
        </tr>
        <%
		nCount = objAdmin.Count
		For nI = 1 to nCount
			objAdmin.GetData nI
		%>
        <form action="setforward.asp" method=Post>
          <input type=Hidden name="Enable" value="<%=objAdmin.Value("Enable")%>">
          <input type=Hidden name="LeaveCopy" value="<%=objAdmin.Value("LeaveCopy")%>">
          <input type=Hidden name=Index value="<%=nI%>">
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_EMAIL_ADDRESS%></div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=EmailAddress value="<%=objAdmin.Value("EmailAddress")%>" >
              <input type=submit height=21 width=61 border=0 value="<%=IDS_MODIFY%>" name="Submit">
              <input type=submit height=21 width=61 border=0 value="<%=IDS_DELETE%>" name="Submit">
            </td>
          </tr>
        </form>
	        <%Next%>
        <form action="setforward.asp" method=Post>
          <input type=Hidden name="Enable" value="<%=objAdmin.Value("Enable")%>">
          <input type=Hidden name="LeaveCopy" value="<%=objAdmin.Value("LeaveCopy")%>">
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_EMAIL_ADDRESS%></div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=EmailAddress value="" >
              <input type=submit height=21 width=61 border=0 value="<%=IDS_ADD_NEW%>" name="Submit">
            </td>
          </tr>
        </form>
        <form action="setforward.asp" method=Post>
          <input type=Hidden name="Enable" value="<%=objAdmin.Value("Enable")%>">
          <input type=Hidden name="LeaveCopy" value="<%=objAdmin.Value("LeaveCopy")%>">
          <tr bgcolor="#EEF5FF"> 
            <td colspan="2"> 
              <div align="center">
                <input type=submit height=21 width=61 border=0 value="<%=IDS_SAVE%>" name="Submit">
                <input type="button" name="Button" value="<%=IDS_RETURN%>" onClick="window.location.replace('mailoptions.asp')">
              </div>
            </td>
          </tr>
        </form>
      </table>
        <br>
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