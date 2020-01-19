<% 
	Option Explicit
	Response.Buffer = True
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
</head>
<%
Dim objAdmin, strRecv, nI
Dim strAccount, strUserName, strSize, strUnlimited, strDisabled, strUserInfo, strPassword, strPermission
Dim strEnableForward, strLeavecopyLocal, strForwardAddress, strComment
strLeavecopyLocal = "1"
If (Session("LoginSuccess") = 1 And Session("Admin") <> 0) Then
	'--- Delete account
	If CInt(Request("Add")) = -1 Then
		Dim strUserList
		strUserList = Request("userlist")
		strUserList = Split(strUserList, ";")
		If UBound(strUserList) > 0 Then
			Set objAdmin = CreateObject("CMailCOM.Admin.1")
			objAdmin.AuthLogin Session("User"), Session("Pass")
			objAdmin.Open Session("Domain"), "AccountListInfo"
			If Left(objAdmin.LastResponse, 3) <> "+OK" Then
				Response.Write objAdmin.LastResponse
				Response.End
			End If
			For nI = 0 To UBound(strUserList) - 1
				objAdmin.Delete objAdmin.Find(strUserList(nI))
			Next
			Set objAdmin = Nothing
			Response.Redirect "admin.asp"
		End If
		Response.End		
	End If
	If Request("Submit") <> "" Then
		'--- add new account
		If Request("Add") = "1" Then
			Set objAdmin = CreateObject("CMailCOM.Admin.1")
			objAdmin.AuthLogin Session("User"), Session("Pass")
			objAdmin.Open Session("Domain"), "AccountListInfo"
			If Left(objAdmin.LastResponse, 3) <> "+OK" Then
				Response.Write objAdmin.LastResponse
				Response.End
			End If
			objAdmin.Value("Account") = Request("Account")
			objAdmin.Value("Size") = Request("Size")
			objAdmin.AddNew
			If Left(objAdmin.LastResponse, 3) <> "+OK" Then
				Response.Write objAdmin.LastResponse
				Response.End
			End If
		End If

		'--- modify account
		Set objAdmin = Nothing
		Set objAccount = CreateObject("CMailCOM.Admin.1")
		objAccount.AuthLogin Session("User"), Session("Pass")
		objAccount.Open Request("Account"), "AccountInfo"
		objAccount.Value("UserName") = Request("UserName")
		objAccount.Value("Size") = Request("Size")
		objAccount.Value("MaxSize") = Request("Unlimited")
		objAccount.Value("Permission") = Request("Permission")
		if Request("Disabled") = "1" Then
			objAccount.Value("Enable") = "0"
		else
			objAccount.Value("Enable") = "1"
		end if
		objAccount.Value("Comment") = Request("Comment")
		If Request("Password") <> "" Then
			objAccount.Value("Password") = Request("Password")
		End If
		objAccount.Update
		if Left(objAccount.LastResponse, 3) = "+OK" Then
			Response.Redirect "admin.asp"
			Response.End
		End If
		Response.Write objAccount.LastResponse
		Set objAccount = Nothing

		strAccount = Request("Account")
		strUserName = Request("UserName")
		strSize = Request("Size")
		strUnlimited = Request("Unlimited")
		strDisabled = Request("Disabled")
		strComment = Request("Comment")
		strPassword = Request("Password")

	Else
		'------------ read account info
		Dim objAccount
		Set objAccount = CreateObject("CMailCOM.Admin.1")
		If Request("Account") <> "" Then
			objAccount.AuthLogin Session("User"), Session("Pass")
			objAccount.Open Request("Account"), "AccountInfo"
			strAccount = Request("Account")
			strUserName = objAccount.Value("UserName")
			strSize = objAccount.Value("Size")
			strUnlimited = objAccount.Value("MaxSize")
			strPermission = objAccount.Value("Permission")
			if "0" = objAccount.Value("Enable") Then
				strDisabled ="1"
			else
				strDisabled = "0"
			end if
			strComment = objAccount.Value("Comment")
		Else
		'-------- new account initialize
			objAccount.AuthLogin Session("User"), Session("Pass")
			objAccount.Open Session("Domain"), "AccountListInfo"
			strSize = objAccount.Value("DefaultSize")
		End If
		Set objAccount = Nothing

	End If
%>
<body bgcolor="#FFFFF7">
<form name="addfm" method="post" action="adminm.asp">
  <table width="100%" height="267" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#99CCFF">
    <tr> 
      <td align="left" valign="top" bgcolor="#FFFFF7" width="100%"> 
        <table border="0" cellpadding="5" cellspacing="1" bgcolor="#084563" align="center">
          <tr bgcolor="#084587" style="background-image: url(images/addback.gif);background-repeat:no-repeat;background-position: right;"> 
            <td height="35" colspan="5"><font color="#EFFBFF"><img src="images/add.gif" width="14" height="14" hspace="10" align="absmiddle"></font></td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="27">&nbsp;</td>
            <td width="80"> 
              <div align="center"><%=IDS_ACCOUNT%></div>
            </td>
            <td width="229"> 
              <input name="Account" type="text" value="<%=strAccount%>" size="25" maxlength="40" <%If CInt(Request("Add")) <> 1 Then%>readonly<%End If%>>
            </td>
            <td width="83"> 
              <div align="center"><%=IDS_PASSWORD%></div>
            </td>
            <td width="247" > 
              <input name="Password" type="text" value="<%=strPassword%>" size="25" maxlength="40">
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="27" height="37">&nbsp;</td>
            <td width="80" height="37"> 
              <div align="center"><%=IDS_NAME%></div>
            </td>
            <td colspan="3" height="37"> 
              <input name="UserName" type="text" value="<%=strUserName%>" size="25" maxlength="40" >
            </td>
          </tr>
          <tr bgcolor="#F7F7F2"> 
            <td colspan="5">&nbsp;</td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="27">&nbsp;</td>
            <td width="80"> 
              <div align="center"><%=IDS_TOTAL_CONTENT%></div>
            </td>
            <td width="229"> 
              <input name="Size" type="text" value="<%=strSize%>" size="25" maxlength="40">
            </td>
            <td width="83"> 
              <div align="center"><%=IDS_UNLIMITED%></div>
            </td>
            <td width="247"> 
              <input type="checkbox" name="Unlimited" value="1" <%If strUnlimited = "1" Then%>checked<%End If%>>
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="27">&nbsp;</td>
            <td width="80"> 
              <div align="center"><%=IDS_DISABLED_ACCOUNT%></div>
            </td>
            <td width="229"> 
              <input type="checkbox" name="Disabled" value="1" <%If CInt(strDisabled) = 1 Then%>checked<%End If%>>
            </td>
            <td width="83"> 
              <div align="center"><%=IDS_PERMISSION%></div>
            </td>
            <td width="247">&nbsp; 
              <select name="Permission" <%If strPermission = "2" and Session("Admin") <> "2" Then%>disabled<%End If%>>
                <option value="0" <%If strPermission = "0" Then%>selected<%End If%>><%=IDS_MAIL_ACCOUNT%></option>
                <option value="1" <%If strPermission = "1" Then%>selected<%End If%>><%=IDS_DOMAIN_ADMIN%></option>
	<% if strPermission = "2" or Session("Admin") = "2" Then%>
                <option value="2" <%If strPermission = "2" Then%>selected<%End If%>><%=IDS_SYSTEM_ADMIN%></option>
	<%End If%>
              </select>
            </td>
          </tr>
          <tr bgcolor="#F7F7F7"> 
            <td colspan="5">&nbsp;</td>
          </tr>
          <tr> 
            <td bgcolor="#EFFBFF" width="27">&nbsp;</td>
            <td bgcolor="#EFFBFF" width="80"> 
              <div align="center"><%=IDS_COMMENT%></div>
            </td>
            <td colspan="3" bgcolor="#EFFBFF"> 
              <input name="Comment" type="text" value="<%=strComment%>" size="60" maxlength="250">
            </td>
          </tr>
          <tr bgcolor="#F7F7F2"> 
            <td colspan="5"> 
              <div align="center"> 
                <input type="submit" value="<%=IDS_OK%>" name="Submit">
                <input type="reset">
                <input type="hidden" name="Add" value="<%=Request("Add")%>">
	<input value="<%=IDS_RETURN%>" onClick="window.history.back()" type=button>
              </div>
            </td>
          </tr>
        </table>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>

</form>
</body>

<%	  
End If
%>
</html>