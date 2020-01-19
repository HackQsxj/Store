<%
	Option Explicit
	Response.Buffer = True
	Response.ExpiresAbsolute = Now() - 1 
	Response.Expires = 0 
	Response.CacheControl = "no-cache" 
%>
<!-- #include file=language.txt -->
<Html>
<Head>
<title><!--#include file="webmailver.txt" --></title>
<style type="text/css">table {  font-family: "Arial", "Helvetica", "sans-serif"}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></Head>
<body bgcolor="#FFFFF7" leftmargin="0" topmargin="0" alink=#0000ff vlink=#0000ff link=#0000ff>
<p>&nbsp;</p>
<TABLE width="636" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR> 
    <TD width="6"> <IMG SRC="images/nav_01.gif" WIDTH=6 HEIGHT=8 ALT=""></TD>
    <TD width="618" background="images/nav_02.gif"> <IMG SRC="images/nav_02.gif" WIDTH=121 HEIGHT=8 ALT=""></TD>
    <TD width="12"> <IMG SRC="images/nav_03.gif" WIDTH=11 HEIGHT=8 ALT=""></TD>
  </TR>
  <TR> 
    <TD background="images/nav_04.gif">&nbsp; </TD>
    <TD bgcolor="#FFFFFF"> <br>
      <table border="0" align="center" cellpadding="5" cellspacing="0">
        <tr> 
          <!--td width="347" height="272" valign="top"><img src="images/webmail.gif"></td-->
          <td width="214" valign="top" height="272"> 
            <table width="100%" border="0" cellspacing="1">
              <tr> 
                <td width="15" height="20" bordercolor="#FFFFFF" bgcolor="#DDEEFF">&nbsp;</td>
                <td width="18" height="20" bordercolor="#FFFFFF" bgcolor="#C8E3FF">&nbsp;</td>
                <td width="29" height="20" bordercolor="#FFFFFF" bgcolor="#B9DCFF">&nbsp;</td>
                <td width="33" height="20" bordercolor="#FFFFFF" bgcolor="#A4D1FF">&nbsp;</td>
                <td width="37" height="20" bordercolor="#FFFFFF" bgcolor="#99CCFF">&nbsp;</td>
                <td width="63" height="20" bordercolor="#FFFFFF" bgcolor="#99CCFF">&nbsp;</td>
              </tr>
            </table>
            <br>
            <br>
            <table border="1" borderColor="#336699" cellPadding="2" cellSpacing="0" width="100%">
              <tbody> 
              <tr> 
                <td><font  size="4"><%=IDS_NEW_USER%><a href="signup.asp" target="_top"><b><%=IDS_SIGNUP_NOW%></b></a></font></td>
              </tr>
              </tbody> 
            </table>
            <Form Method="Post" Action="login.asp">
              <p><font size=2><%=IDS_ACCOUNT%></font><br>
                <input maxLength="64" name="User" size="16" value="<%=Request.Cookies("User")%>">
                <strong> </strong><br>
                <font size=2><%=IDS_PASSWORD%></font><br>
                <input maxLength="64" name="Pass" size="16" type="password" value="<%=Request.Cookies("Pass")%>">
                <input  type="submit" value=" <%=IDS_LOGIN%> "><br>
	<input type=checkbox name="SaveUserPass" value="on" <%If Request.Cookies("SaveUserPass") <> "" Then%>checked<%End If%>><font size=2><%=IDS_SAVE_USER_PASS%></font>
              </p>
            </form>
          </td>
        </tr>
      </table>
      <br>
      <div align="right"> 
        <table width="100%" border="0">
          <tr> 
            <td height="25" width="612"> 
              <div align="right"><!--a href="<%=IDS_POWERED_BY%>" style="text-decoration:none;color:#eeeeee;font-size: 8pt;font-family:'Arial Narrow'">This mail server powered by Youngzsoft</a--></div>
            </td>
          </tr>
        </table>
      </div>
    </TD>
    <TD background="images/nav_06.gif">&nbsp; </TD>
  </TR>
  <TR> 
    <TD> <IMG SRC="images/nav_07.gif" WIDTH=6 HEIGHT=9 ALT=""></TD>
    <TD background="images/nav_08.gif"> <IMG SRC="images/nav_08.gif" WIDTH=121 HEIGHT=9 ALT=""></TD>
    <TD> <IMG SRC="images/nav_09.gif" WIDTH=11 HEIGHT=9 ALT=""></TD>
  </TR>
</TABLE>
</body>    
</html>    
