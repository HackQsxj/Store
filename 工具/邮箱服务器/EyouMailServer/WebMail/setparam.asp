<% 
  Option Explicit
  Response.Buffer = True
%>
<!-- #include file=language.txt -->
<!-- #include file=conn.asp -->
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
<style type="text/css">
<!--
.back {
	background-image: url(images/sendmailback.gif);
	background-repeat: no-repeat;
	background-position: right bottom;
}
-->
</style>

</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000 >
<table border="0"  bordercolordark=white bordercolor=gray cellspacing="0" height="100%" width="100%" >
  <tr bgcolor="#dcdcdc">
    <td colspan="4" valign="top" bgcolor="#FFFFF7"> 
<%
	Dim objAdmin
	Dim nMaxlist
	Dim strSql
	Dim strLanguage
	Dim strReply
	dim rs
	
	Set objAdmin = CreateObject("CMailCOM.Admin.1")
	objAdmin.Login Session("User"),Session("Pass")
	If objAdmin.LoginSuccess = 1 Then
	
	if Request.Form("maxList")<>"" then
      	  	nMaxlist = cint(request.Form("maxlist"))
	  	strReply = replace(request.form("replyaddr"), "'", "''")
       	  	strSql =  "update parameter set maxlist="&nMaxlist&", replyaddr='"&strReply&"' where account= '" & Session("Account") & "'"
	  	conn.execute strSql,1,0
	  	strReply = request.form("replyaddr")
	  	session("maxlist") = nMaxlist 
	  	session("replyaddr")  = strReply
        
	  
%>
      <table border="1" align="center" cellspacing="0" bordercolor=gray bordercolordark=white width="500" >
        <tr> 
          <td  align=center valign="top" bgcolor="#EFFBFF"> 
            <p><br>
            </p>
            <p><br>
              <span > <font color=green><b><%=IDS_SET_PARAM%> <%=IDS_SET_CHANGESUSS%> </b></font></span></p>
           
            <p><br>
              <span > 
              <input alt=Return border=0 height=21 name=back src="button-back.gif" width=61 value="  <%=IDS_OK%>  " onClick="OnSuccess()" type=button>
              </span></p>
            <p><br>
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
	  	 Session("maxlist") = RS("maxlist")
	 	 Session("language") = RS("language")
	 	 Session("replyaddr") = RS("replyaddr")
		 rs.Close
		 set rs = nothing
	   else
		rs.Close 
		set rs = nothing
	  	set rs=Server.createobject("adodb.recordset")
		rs.open "parameter",Conn,1,3
	                rs.addnew
		rs("account")=Session("Account")
		rs("sign")=""
		rs("maxlist")=session("maxlist")
		rs("replyaddr")=session("replyaddr")       
		rs.update
	                rs.Close
	                set rs = nothing
	   end if
%>
<form action="setparam.asp" method=Post>
        <table width="80%" border="1" align="center" cellpadding="5" cellspacing="0" bordercolor=gray bordercolordark=white>
          <tr bgcolor="#EFFBFF"> 
            <td height="25" colspan="2" align="right"  valign="middle" nowrap class="tab01"> 
              <div align="left"><span ><font color=#000000><b><img src="images/setup.gif" width="16" height="16" align="absmiddle">&nbsp;<%=IDS_SET_PARAM%></b></font></span></div>
            </td>
          </tr>
          <tr> 
            <td height="150" align="right"  valign="middle" nowrap class="tab01" bgcolor="#EFEBDE"><%=IDS_MAX_MAILS_PER_PAGE%>&nbsp;&nbsp;&nbsp;</td>
            <td width="66%" align="left" class="tab02" bgcolor="#EFEBDE" > 
              <input type="radio" style="border: 0px solid;" name="maxlist" value="10" <%if Session("maxlist")=10 then%> checked <% end if %>>
              10<br>
              <input type="radio" name="maxlist" value="20" style="border: 0px solid;" <%if Session("maxlist")=20 then%> checked <% end if %> >
              20<br>
              <input type="radio" name="maxlist" value="30" style="border: 0px solid;" <%if Session("maxlist")=30 then%> checked <% end if %> >
              30<br>
              <input type="radio" name="maxlist" value="40" style="border: 0px solid;" <%if Session("maxlist")=40 then%> checked <% end if %> >
              40<br>
              <input type="radio" name="maxlist" value="50" style="border: 0px solid;" <%if Session("maxlist")=50 then%> checked <% end if %> >
              50<br>
              <input type="radio" name="maxlist" value="100" style="border: 0px solid;"<%if Session("maxlist")=100 then%> checked <% end if %>  >
              100</td>
          </tr>
          <tr> 
            <td height="50" align="right"  valign="middle" nowrap class="tab01"><%=IDS_REPLY_ADDR%>:&nbsp;&nbsp;&nbsp;</td>
            <td align="right"  valign="middle" nowrap class="tab01"> 
              <div align="left">&nbsp;&nbsp; 
                <input name="replyaddr" type="text" size="30" maxlength="40" value="<%=Session("replyaddr")%>">
              </div>
            </td>
          </tr>
          <tr bgcolor="#EFFBFF"> 
            <td height="50" nowrap class="tab01" colspan="2"> 
              <div align="center">
                <input type=submit src="button-modify.gif" alt="Modify" height=21 width=61 border=0  value=" <%=IDS_MODIFY%> " name="button2">
                <input type=button src="button-modify.gif" alt="Go back" height=21 width=61 border=0 onClick="OnReturn()" value=" <%=IDS_RETURN%> " name="button">
              </div>
            </td>
          </tr>
        </table>
        <table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><div align="right"><br>
              </div>
            </td>
          </tr>
        </table>
        </form>
<% 
		end if
	Else
		Response.Redirect "setparam.asp"
	End If
	conn.Close
	set conn=nothing
	set objAdmin = nothing
%>
      </td>
     </tr>
  </table>
</Body>
</Html>