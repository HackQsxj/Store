<% 
  Option Explicit
  Response.Buffer = True
%>
<!-- #include file=language.txt -->
<!-- #include file=conn.asp -->
<!-- #include file="encode.asp" -->
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
<SCRIPT>
<!--
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
	Dim strSql
	Dim rs
	Dim strSign
	
	Set objAdmin = CreateObject("CMailCOM.Admin.1")
	objAdmin.Login Session("User"),Session("Pass")
	If objAdmin.LoginSuccess = 1 Then

	  if Request.Form("setsign")= 1 then
	  strSign = replace(HTMLEncode(Request.Form("sign")), "'", "''")
	  strSql =  "update parameter set sign = '" & strSign &"' where account= '" & Session("Account") & "'"
	  conn.execute strSql,1,0

%>
      <table width="500" border="1" align="center" cellspacing="0" bordercolor=gray bordercolordark=white >
        <tr> 
          <td align=center valign="top" bgcolor="#EFFBFF"> 
            <p><br>
            </p>
            <p><br>
              <span ><font color=#000000><b><%=IDS_SET_SIGN%> <%=IDS_SET_CHANGESUSS%></b></font></span></p>
            <p><br>
              <span >
              <input alt=Return border=0 height=21 name=back src="button-back.gif" width=61 value="  <%=IDS_OK%>  " onClick="OnSuccess()" type=button>
              </span><br>
              <br>
              <br>
              <br>
            </p>
            </td>
        </tr>
      </table>
<% 
     else
	  
     set rs=createobject("adodb.recordset")
     strSql="select * from parameter where account='" & Session("Account") & "'"
     rs.open strSql,Conn,1,2
	 if not rs.eof then
	 	 strSign = rs("sign")
		 rs.Close
		 set rs = nothing
	  else
	     strSign = ""
	  	rs.Close
	          set rs = nothing
		  set rs=Server.createobject("adodb.recordset")
		  Session("maxlist") = 20
       		  rs.open "parameter",Conn,1,3
		  rs.addnew
		  rs("account")=Session("Account")
		  rs("sign")=""
		  rs("maxlist")=session("maxlist")
		  rs("replyaddr")=session("replyaddr")
		  rs("sign")=""
		  rs.update
		  rs.Close
		  set rs = nothing
	      end if
%>
      <form action="setsign.asp" method=Post name="mailsign" id="mailsign">
	    <p>
          <input type=hidden name=setsign value=1>
        </p>
        <table width="80%" border="1" align="center" cellspacing="0" bordercolor=gray bordercolordark=white>
          <tr bgcolor="#eeeeff"> 
            <td width="466" height="30" align="right"  valign="middle" nowrap bgcolor="#EFFBFF" class="tab01"><div align="left"><span ><font color=#000000><b><img src="images/setup.gif" width="16" height="16" hspace="10" align="absbottom"><%=IDS_SET_SIGN%></b></font></span></div>
              </td>
          </tr>
          <tr> 
            <td align="right"  valign="middle" nowrap class="tab01"><div align="justify"></div></td>
          </tr>
          <tr> 
            <td align="right"  valign="middle" nowrap class="tab01"> 
              <div align="center"><br>
                <textarea name="sign" cols="60" rows="12" id="sign"><%=strSign%></textarea>
                <br>
                <br>
              </div>
            </td>
          </tr>
          <tr bgcolor="#eeeeff"> 
            <td height="30" align="right"  valign="middle" nowrap bgcolor="#EFFBFF" class="tab01"> <div align="center"> 
                <input type=submit src="button-modify.gif" alt="Modify" height=21 width=61 border=0  value=" <%=IDS_MODIFY%> " name="button2">
                <input type=button src="button-modify.gif" alt="Go back" height=21 width=61 border=0 onClick="OnReturn()" value=" <%=IDS_RETURN%> " name="button">
              </div></td>
          </tr>
        </table>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      </form>
      <% 
		end if
	Else
		Response.Redirect "setsign.asp"
	End If
	conn.Close
	Set conn = nothing
	Set objAdmin = Nothing	
%>
      </td>
</tr>
</table>
</Body>
</Html>