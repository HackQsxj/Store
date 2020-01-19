<% 
  Option Explicit
  Response.Buffer = True
  Server.ScriptTimeOut = 1800
%>
<!-- #include file="Language.txt" -->
<!-- #include file="encode.asp" -->
<Html>
<Head>
<title><!--#include file="webmailver.txt" --></title>
<LINK href="styles.css" rel=STYLESHEET type=text/css>
<SCRIPT language=JavaScript>
<!--
	function OnReturn()
	{
		window.history.back();
		window.event.returnValue=false;
	}

	function OnSuccess()
	{
		window.location.replace("finbox.asp")
	}
//-->
</SCRIPT>
</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000  >
<p>&nbsp;</p><TABLE width="70%" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR> 
    <TD width="6"> <IMG SRC="images/nav_01.gif" WIDTH=6 HEIGHT=8 ALT=""></TD>
    <TD background="images/nav_02.gif"> <IMG SRC="images/nav_02.gif" WIDTH=121 HEIGHT=8 ALT=""></TD>
    <TD width="11"> <IMG SRC="images/nav_03.gif" WIDTH=11 HEIGHT=8 ALT=""></TD>
  </TR>
  <TR> 
    <TD width="6" background="images/nav_04.gif">&nbsp; </TD>
    <TD bgcolor="#FFFFFF"><table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray bordercolordark=white >
              <tr> 
                <td align=center valign="top"> <p>&nbsp;</p>
            <p> <br>
              <span > 
              <%
	Dim objPOP3

	Set objPOP3= CreateObject("CMailCOM.POP3.1")
	objPOP3.Login Session("User"), Session("Pass")
	Session("LoginSuccess") = objPOP3.LoginSuccess

	If Session("LoginSuccess") = 1 Then 

		objPOP3.GetRemotePOP3
		
    		If Left(objPOP3.LastResponse, 3) = "+OK" Then
%>
              <font color=#000000><b><%=IDS_POP_SUCCESSFULLY%><br><%=IDS_POP_WAIT%> </b></font></span></p>
            <p><span > 
              <input alt=Return border=0 height=21 name=back src="images/button-back.gif" width=61 value="  <%=IDS_OK%>  " onClick="OnSuccess()" type=button>
<%
		Else
%>
              <font color=gray><b> <%=IDS_POP_FAILED%></b></font><br>
              <br>
              <%=HTMLEncode(objPOP3.LastResponse)%><br>
              <br>
              <input alt=Return border=0 height=21 name=back2 src="images/button-back.gif" width=61 value=" <%=IDS_RETURN%> " onClick="OnReturn()" type=button>
              <%
		End If
	Else
		Response.Write objPOP3.LastResponse
	End If
	Set objPOP3 = Nothing
%>
              </span></p>
            <p> <br>
            </p>
            </td>
              </tr>
            </table></TD>
<TD width="11" background="images/nav_06.gif">&nbsp; </TD>
</TR>
<TR> 
<TD> <IMG SRC="images/nav_07.gif" WIDTH=6 HEIGHT=9 ALT=""></TD>
<TD background="images/nav_08.gif"> <IMG SRC="images/nav_08.gif" WIDTH=121 HEIGHT=9 ALT=""></TD>
<TD> <IMG SRC="images/nav_09.gif" WIDTH=11 HEIGHT=9 ALT=""></TD>
</TR>
</TABLE>
</Body>
</Html>
