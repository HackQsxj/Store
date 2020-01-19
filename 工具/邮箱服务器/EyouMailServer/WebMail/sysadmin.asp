<% 
  Option Explicit
  Response.Buffer = True
%>
<!-- #include file=language.txt -->
<html>
<head>
<title> 
<!-- #include file=webmailver.txt -->
</title>
<style type="text/css">
	a:link {text-decoration:none; cursor: hand}
	a:visited {text-decoration:none}
	a:hover {text-decoration:underline}
	body,table {font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</style>
</head>
<body bgcolor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000 >
<%
	If Len(Request("Err")) <> 0 Then
%>
<table width="438" border="1" align="center" cellspacing="0" bordercolor=gray bordercolordark=white >
        <tr> 
          <td align=center valign="top" bgcolor="#EFFBFF"> 
            <p><br>
            </p>
            <p><br>
	<font color=red><b><%=Request("Err")%> 
              </b></font></p>
            <p><br>
              <input value="  <%=IDS_RETURN%>  " onClick="window.history.back()" type=button>
              <br>
              <br>
              <br>
            </p></td>
        </tr>
</table>
<%
	Response.End
	End If
%>
<table border="0"  bordercolordark=white bordercolor=gray cellspacing="0" height="100%" width="100%" >
   <tr bgcolor="#dcdcdc">
     <td valign="top" bgcolor="#FFFFF7"> 
<%
	Dim objAdmin
	Dim nI
	Dim nCount
	Dim strMultipleDomain
	
	Set objAdmin = CreateObject("CMailCOM.Admin.1")
	objAdmin.AuthLogin Session("User"),Session("Pass")
	If objAdmin.LoginSuccess = 1 Then
		objAdmin.Open Session("Account"), "DomainInfo"
		strMultipleDomain = objAdmin.Value("MultipleDomain")
'---------- form submit 
		If Request("Submit") <> "" Then
			objAdmin.Value("Domain") = Request("Domain")
			objAdmin.Value("MaxSpace") = Request("MaxSpace")
			objAdmin.Value("MaxCount") = Request("MaxCount")
			objAdmin.Value("DefaultSize") = Request("DefaultSize")
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
	<font color=green><b><%=IDS_DOMAIN%> <%=IDS_SET_CHANGESUSS%> 
              </b></font></p>
            <p><br>
              <input value="  <%=IDS_OK%>  " onClick="window.location.replace('sysadmin.asp')" type=button>
              <br>
              <br>
              <br>
            </p></td>
        </tr>
      </table>
<% 
			Else
				Response.Redirect("sysadmin.asp?Err="&objAdmin.LastResponse)
				Response.End
			End If
				
		Else

'--------------------- list domain -------------------
			nCount = objAdmin.Count
			For nI = 1 to nCount
				objAdmin.GetData nI
%>
<form action="sysadmin.asp" method=Post>
<input type=Hidden name=Index value="<%=nI%>">
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor="#C6DFF7">
          <tr bgcolor="#EEF5FF"> 
            <td colspan="2"><img src="images/setup.gif" width="16" height="16" align="absmiddle"><font color=#000000><b>&nbsp;<%=IDS_DOMAIN%></b></font></td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="285"> 
              <div align="center"><%=IDS_DOMAIN%></div>
            </td>
            <td width="480"> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=Domain value="<%=objAdmin.Value("Domain")%>" >
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_DOMAIN_MAX_SPACE%></div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=MaxSpace value="<%=objAdmin.Value("MaxSpace")%>" >
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_DOMAIN_MAX_COUNT%></div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=MaxCount value="<%=objAdmin.Value("MaxCount")%>" >
            </td>
          </tr>
	<tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_DOMAIN_MAILBOX_DEFAULT_SIZE%>(M)</div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=DefaultSize value="<%=objAdmin.Value("DefaultSize")%>" >
            </td>
          </tr>
          <tr bgcolor="#EEF5FF"> 
            <td colspan="2"> 
              <div align="center"> 
                <input type=submit height=21 width=61 border=0 value="<%=IDS_MODIFY%>" name="Submit">
	<%If strMultipleDomain = "1" Then%>
                <input type=submit height=21 width=61 border=0 value="<%=IDS_DELETE%>" name="Submit">
	<%End If%>
              </div>
            </td>
          </tr>
 </table>
 </form>

<%

			Next

'------------------- add new form
	If strMultipleDomain = "1" Then
%>
      <form action="sysadmin.asp" method=Post>
          <input type=Hidden name=Index value="<%=nI%>">
        <table width="80%" border="0" align="center" cellpadding="5" cellspacing="1" bordercolor=gray bordercolordark=white bgcolor="#C6DFF7">
          <tr bgcolor="#EEF5FF"> 
            <td colspan="2"><img src="images/setup.gif" width="16" height="16" align="absmiddle"><font color=#000000><b>&nbsp;<%=IDS_ADD_NEW%><%=IDS_DOMAIN%></b></font></td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td width="285"> 
              <div align="center"><%=IDS_DOMAIN%></div>
            </td>
            <td width="480"> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=Domain >
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_DOMAIN_MAX_SPACE%></div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=MaxSpace >
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td> 
              <div align="center"><%=IDS_DOMAIN_MAX_COUNT%></div>
            </td>
            <td> &nbsp;&nbsp;&nbsp; 
              <input type=Text name=MaxCount >
            </td>
          </tr>
          <tr bgcolor="#EEF5FF"> 
            <td colspan="2"> 
              <div align="center"> 
                <input type=submit height=21 width=61 border=0 value="<%=IDS_ADD_NEW%>" name="Submit">
                <input type="button" name="Button" value="<%=IDS_RETURN%>" onClick="window.location.replace('sysadmin.asp')">
              </div>
            </td>
          </tr>
        </table>
       </form>
		 
<% 
	End If
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