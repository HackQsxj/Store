<% 
  Option Explicit
  Response.Buffer = True
%>
<!-- #include file=language.txt -->
<!-- #include file="encode.asp" -->
<Html>
<Head>
<title> 
<!--#include file="webmailver.txt" -->
</title>
<Style Type = text/css>
body,table {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</Style>

<SCRIPT language=JavaScript>
<!--
	function OnSignup()
	{
		document.forms[0].Signup.value = "1";
		var str1, str2;
		str1 = new String("");
		str2 = new String("");
		str1 = document.forms[0].Pass.value
		str2 = document.forms[0].RePass.value
		if( str1 != str2)
		{
			document.forms[0].Signup.value = "0";
			alert("<%=IDS_ALERT_CHANGE_PASSWORD%>");
			window.event.returnValue = false;
		}
	}

	function OnBack()
	{
		window.history.back();
		window.event.returnValue=false;
	}
//-->
</SCRIPT>
</Head>
<body bgcolor="#FFFFF7" leftmargin="0" topmargin="0"  alink=#0000ff vlink=#0000ff link=#0000ff>
<div align="center">
<p>&nbsp;</p>
  <table width="232" border="0">
    <tr> 
      <td height="25" bordercolor="#FFFFFF" bgcolor="#DDEEFF" width="3">&nbsp;</td>
      <td height="25" bordercolor="#FFFFFF" bgcolor="#DDEEFF" width="33">&nbsp;</td>
      <td height="25" bordercolor="#FFFFFF" bgcolor="#C8E3FF" width="33">&nbsp;</td>
      <td height="25" bordercolor="#FFFFFF" bgcolor="#B9DCFF" width="31">&nbsp;</td>
      <td height="25" bordercolor="#FFFFFF" bgcolor="#A4D1FF" width="118">&nbsp;</td>
      <td height="25" bordercolor="#FFFFFF" bgcolor="#99CCFF" width="84">&nbsp;</td>
      <td height="25" bordercolor="#FFFFFF" bgcolor="#99CCFF" width="6">&nbsp;</td>
    </tr>
    <tr align="center"> 
      <td valign="top" colspan="7"> 
        <Form Method="Post" Action="signup.asp">
          <br>
          <Input Type=Hidden Name=Signup	Value="0">
          <table border="0" cellPadding="0" cellSpacing="0" width=100%>
            <tbody> 
            <tr> 
              <td> 
                <table border="1" borderColor="#336699" cellPadding="2" cellSpacing="0" width="100%">
                  <tbody> 
                  <tr> 
<%
	Dim objAdmin
	Dim SignupOK
	SignupOK = 0
	If Request("Signup") = "1" Then

		Set objAdmin = CreateObject("CMailCOM.Admin.1")
		objAdmin.Password = Request("Pass")
		objAdmin.UserName = Request("UserName")
		objAdmin.Comment  = Request("Comment")
		objAdmin.POP3Server = Request("POP3Server")
		objAdmin.POP3Mail = Request("POP3Mail")
		objAdmin.POP3Password = Request("POP3Password")
		objAdmin.POP3Account = Request("POP3Account")

		If Request("LeaveCopy") = "on" then
			objAdmin.LeaveCopy = 1
		Else
			objAdmin.LeaveCopy = 0
		End If
		objAdmin.Signup Request("Account")+ ":" + Request("REMOTE_ADDR")
				
		If Left(objAdmin.LastResponse, 3) = "+OK" Then
			SignupOK = 1
%>
                    <Td width="103"><B><%=IDS_SIGNUP_SUCCESSFULLY%>!<Br>
                      <A href="index.asp" ><%=IDS_LOGIN_NOW%>!</A></B></Td>
                    <%
		Else
			SignupOK = 0
	%>
                    <Td width="111"><Font size="4" color=Gray><B><%=IDS_SIGNUP_FAILED%>.</B><Br>
                      </Font> 
                      <%Response.Write(HTMLEncode(objAdmin.LastResponse))%>
                    </Td>
                    <%
		End If
		Set objAdmin = NoThing

	Else		
	%>
                    <Td width="97"><B><%=IDS_HERE_SIGNUP_NOW%></B></Td>
                    <%
	End If
	%>
                  </tr>
                  </tbody> 
                </table>
              </td>
            </tr>
            <tr> 
              <td height="30" vAlign="bottom"><%=IDS_ACCOUNT%>*</td>
            </tr>
            <tr> 
              <td> 
                <%If SignupOK = 0 Then %>
                <input maxLength="64" name="Account" size="30" value="<%=Request("Account")%>">
                <%Else%>
                <b><%=Request("Account")%></B> 
                <%End If%>
                <b></b><font ><b></b></font></td>
            </tr>
            <%If SignupOK = 0 Then %>
            <Tr> 
              <Td noWrap> <%=IDS_PASSWORD%>*</Td>
            </Tr>
            <Tr> 
              <Td> 
                <Input Type="Password" Name="Pass" size="30" value="" maxlength="64">
              </td>
            </Tr>
            <Tr> 
              <Td noWrap><%=IDS_RETYPE_PASSWORD%>*</Td>
            </Tr>
            <Tr> 
              <Td> 
                <Input Type="Password" Name="RePass" size="30" value="" maxlength="64">
              </td>
            </Tr>
            <%End If%>
            <tr> 
              <td noWrap><%=IDS_YOUR_NAME%></td>
            </tr>
            <tr> 
              <td> 
                <%If SignupOK = 0 Then %>
                <input name="UserName" size="30" value="<%=Request("UserName")%>" maxlength="64">
                <%Else%>
                <b><%=Request("UserName")%></B> 
                <%End If%>
              </td>
            </tr>
            <Tr> 
              <Td noWarp><%=IDS_COMMENT%></Td>
            </Tr>
            <Tr> 
              <%If SignupOK = 0 Then %>
              <Td> 
                <Input Name="Comment" size="30" value="<%=Request("Comment")%>" maxlength="64">
                <B><%=Request("Comment")%></B></Td>
              <%Else%>
              <%End If%>
              <Td width="1"></Td>
            </Tr>
            <Tr> 
              <Td noWarp><%=IDS_CONTACT_EMAIL%></Td>
            </Tr>
            <Tr> 
              <%If SignupOK = 0 Then %>
              <Td> 
                <Input Name="POP3Mail" size="30" value="<%=Request("POP3Mail")%>" maxlength="64">
                <B><%=Request("POP3Mail")%></B></Td>
              <%Else%>
              <%End If%>
              <Td width="1"></Td>
            </Tr>
            <%If SignupOK = 0 Then %>
            <Tr> 
              <Td> 
                <p align="center"><br>
                  <Input Type="Submit" onclick="OnSignup()" Value=" <%=IDS_SIGNUP%> ">
                  <Input Type="Button" onclick="OnBack()" Value=" <%=IDS_RETURN%> ">
                </p>
                <p align="right"><!--a href="<%=IDS_POWERED_BY%>" style="text-decoration:none;color:#eeeeee;font-size: 8pt;font-family:'Arial Narrow'">This mail server powered by Youngzsoft</a--> </p>
              </Td>
            </Tr>
            <%End If%>
            </tbody> 
          </table>
        </Form>
      </td>
    </tr>
  </table>
</div>  
</Body>
</Html>