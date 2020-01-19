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
		if(document.forms[0].ModifyPass.value == "1")
		{
			var str1, str2;
			str1 = new String("");
			str2 = new String("");
			str1 = document.forms[0].NewPass.value
			str2 = document.forms[0].RePass.value
			if( str1 != str2)
			{
				document.forms[0].Modify.value = "0";
				alert("<%=IDS_ALERT_CHANGE_PASSWORD%>");
				window.event.returnValue = false;
			}
			else
				document.forms[0].submit();
		}
		else
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
	Dim objAdmin, objAuth
	
	Set objAdmin = CreateObject("CMailCOM.Admin.1")
	objAdmin.AuthLogin Session("User"),Session("Pass")
	If objAdmin.LoginSuccess = 1 Then
		objAdmin.Open Session("Account"), "AccountInfo"
		If Request("Modify") = "1" Then
			Set objAuth = CreateObject("CMailCOM.Admin.1")
			objAuth.AuthLogin Session("User"), Request("Pass")
			If objAuth.LoginSuccess = 1 Then
				objAdmin.Value("Password") = Request("NewPass")
				objAdmin.Update
				If Left(objAdmin.LastResponse, 3) = "+OK" Then
					Session("Pass") = Request("NewPass")
%>
<table width="500" border="1" align="center" cellspacing="0" bordercolor=gray bordercolordark=white >
        <tr> 
          <td align=center valign="top" bgcolor="#EFFBFF"> 
            <p><br>
              <br>
              <span > <font color=#000000><b><%=IDS_SET_PASSWD%> <%=IDS_SET_CHANGESUSS%> </b></font></span></p>
            
            <p><br>
              <span > 
              <input alt=Return border=0 height=21 name=back src="button-back.gif" width=61 value="  <%=IDS_OK%>  " onClick="OnSuccess()" type=button>
              </span><br>
              <br>
              <br>
            </p></td>
        </tr>
      </table>
<% 

				Else
					Response.Redirect("setpasswd.asp?Err="&objAdmin.LastResponse)
					Response.End
				End If
			Else
					Response.Redirect("setpasswd.asp?Err="&objAuth.LastResponse)
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
      <form action="setpasswd.asp" method=Post>

          
        <p>
          <input type=Hidden name=ModifyPass value="1">
          <input type=Hidden name=Modify	value="1">
        </p>
        <table width="80%" border="0" align="center" cellpadding="5" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor="#57002C">
          <tr bgcolor="#FFEEEE"> 
            <td colspan="2"><img src="images/setup.gif" width="16" height="16" hspace="10" align="absmiddle"><span ><font color=#000000><b>&nbsp;<%=IDS_SET_PASSWD%></b></font></span></td>
          </tr>
          <tr bgcolor="#FFFFF7"> 
            <td width="149" height="50"><div align="center"><%=IDS_PASSWORD%></div></td>
            <td width="306"> &nbsp;&nbsp; 
              <input type=Password name=Pass value="" >
            </td>
          </tr>
          <tr bgcolor="#FFFFF7"> 
            <td width="149" height="50"><div align="center"><%=IDS_NEW_PASSWORD%></div></td>
            <td width="306" bgcolor="#FFFFF7"> &nbsp;&nbsp; 
              <input type=Password name=NewPass value="">
            </td>
          </tr>
          <tr bgcolor="#FFFFF7"> 
            <td width="149" height="50"><div align="center"><%=IDS_RETYPE_PASSWORD%></div></td>
            <td width="306"> &nbsp;&nbsp; 
              <input type=Password name=RePass value=""> 
            </td>
          </tr>
          <tr bgcolor="#E7E2D3"> 
            <td height="30" colspan="2"> 
              <div align="center"> 
                <input type=button src="button-modify.gif" alt="Modify" height=21 width=61 border=0 onClick="OnModify()" value=" <%=IDS_MODIFY%> " name="button2">
                <input type=button src="button-modify.gif" alt="Go back" height=21 width=61 border=0 onClick="OnReturn()" value=" <%=IDS_RETURN%> " name="button">
              </div></td>
          </tr>
        </table>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
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