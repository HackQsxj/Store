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
		window.location.replace("setpersoninfo.asp")
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
	Dim strUserName
	Dim strComment
	Dim strContactEmail

	Set objAdmin = CreateObject("CMailCOM.Admin.1")
	objAdmin.AuthLogin Session("User"),Session("Pass")
	If objAdmin.LoginSuccess = 1 Then
		objAdmin.Open Session("Account"), "AccountInfo"
		strUserName = objAdmin.Value("UserName")
		strComment  = objAdmin.Value("Comment")
		strContactEmail = objAdmin.Value("ContactEmail")

		If Request("Modify") = "1" Then
			objAdmin.Value("UserName") = Request("UserName")
			objAdmin.Value("Comment") = Request("Comment")
			objAdmin.Value("ContactEmail") = Request("ContactEmail")
			objAdmin.Update
			If Left(objAdmin.LastResponse, 3) = "+OK" Then
%>
<table width="438" border="1" align="center" cellspacing="0" bordercolor=gray bordercolordark=white >
        <tr> 
          <td align=center valign="top" bgcolor="#EFFBFF"> 
            <p><br>
              <br>
              <span > <font color=#000000><b><%=IDS_SET_PERSONINFO%> <%=IDS_SET_CHANGESUSS%> 
              </b></font></span></p>
            <p><br>
              <span > 
              <input alt=Return border=0 height=21 name=back src="button-back.gif" width=61 value="  <%=IDS_OK%>  " onClick="OnSuccess()" type=button>

              </span><br>
              <br>
            </p></td>
        </tr>
      </table>
<% 
			Else
				Response.Redirect("setpersoninfo.asp?Err="&objAdmin.LastResponse)
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
      <form action="setpersoninfo.asp" method=Post>
        <p>
          <input type=Hidden name=Modify	value="0">
        </p>
        <table width="80%" border="0" align="center" cellpadding="0" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor="gray">
          <tr bgcolor="#C6DFF7"> 
            <td height="30" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/setup.gif" width="16" height="16" align="absmiddle"><span ><font color=#000000><b>&nbsp;<%=IDS_SET_PERSONINFO%> 
              </b></font></span> </td>
          </tr>
          <tr bgcolor="#FFFFF7"> 
            <td height="80" bgcolor="#FFFFF7"> 
              <div align="center"><%=IDS_YOUR_NAME%></div>
            </td>
            <td width="74%"> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=UserName value="<%=strUserName%>" >
            </td>
          </tr>
          <tr bgcolor="#EEEDDF"> 
            <td width="26%" height="80"> 
              <div align="center"><%=IDS_CONTACT_EMAIL%></div>
            </td>
            <td width="74%" bgcolor="#EEEDDF"> &nbsp;&nbsp;&nbsp; 
              <input type=Text name="ContactEmail" value="<%=strContactEmail%>" >
            </td>
          </tr>
          <tr bgcolor="#EEEDDF"> 
            <td width="26%" height="80" bgcolor="#FFFFF7"> 
              <div align="center"><%=IDS_COMMENT%></div>
            </td>
            <td width="74%" bgcolor="#FFFFF7"> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=Comment value="<%=strComment%>" >
            </td>
          </tr>
          <tr bgcolor="#C6DFF7"> 
            <td height="43" colspan="2"> 
              <div align="center"> 
                <input type=button src="button-modify.gif" alt="Modify" height=21 width=61 border=0 onClick="OnModify()" value=" <%=IDS_MODIFY%> " name="button2">
                <input type=button src="button-modify.gif" alt="Go back" height=21 width=61 border=0 onClick="OnReturn()" value=" <%=IDS_RETURN%> " name="button">
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