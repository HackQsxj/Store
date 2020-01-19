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
<LINK href="styles.css" rel=STYLESHEET type=text/css>
</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 >
<TABLE width="90%" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR> 
    <TD> <IMG SRC="images/nav_01.gif" WIDTH=6 HEIGHT=8 ALT=""></TD>
    <TD background="images/nav_02.gif"> <IMG SRC="images/nav_02.gif" WIDTH=121 HEIGHT=8 ALT=""></TD>
    <TD> <IMG SRC="images/nav_03.gif" WIDTH=11 HEIGHT=8 ALT=""></TD>
  </TR>
  <TR> 
    <TD width="6" background="images/nav_04.gif">&nbsp; </TD>
    <TD bgcolor="#FFFFFF" class="backset"><br>
      <table width="80%" border="0" align="center" cellpadding="5" cellspacing="0">
        <tr> 
          <td width="33%"><table width="100%" border="1" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#000000">
              <tr> 
                <td height="25" align="center" bgcolor="#CECFCE"><a href="setpersoninfo.asp"><font color="#000000"><%=IDS_SET_PERSONINFO%></font></a></td>
              </tr>
              <tr> 
                <td height="80" bgcolor="#F7F3F7" align="center"><%=IDS_SET_PERSONINFO_D%></td>
              </tr>
            </table></td>
          <td width="33%"><table width="100%" border="1" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#000000">
              <tr> 
                <td height="25" align="center" bgcolor="#CECFCE"><a href="setpasswd.asp"><font color="#000000"><%=IDS_SET_PASSWD%></font></a></td>
              </tr>
              <tr> 
                <td height="80" align="center" bgcolor="#F7F3F7"><%=IDS_SET_PASSWD_D%></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" border="1" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#000000">
              <tr> 
                <td height="25" align="center" bgcolor="#CECFCE"><a href="setsign.asp"><font color="#000000"><%=IDS_SET_SIGN%></font></a></td>
              </tr>
              <tr> 
                <td height="80" align="center" bgcolor="#F7F3F7"><%=IDS_SET_SIGN_D%></td>
              </tr>
            </table></td>
          <td><table width="100%" border="1" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#000000">
              <tr> 
                <td height="25" align="center" bgcolor="#CECFCE"><a href="setparam.asp"><font color="#000000"><%=IDS_SET_PARAM%></font></a></td>
              </tr>
              <tr> 
                <td height="80" bgcolor="#F7F3F7" align="center"> <%=IDS_SET_PARAM_D%></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" border="1" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#000000">
              <tr> 
                <td height="25" align="center" bgcolor="#CCCCCC"><a href="setpop.asp"><font color="#000000"><%=IDS_SET_POP%></font></a></td>
              </tr>
              <tr> 
                <td height="80" align="center" bgcolor="#F7F3F7"><%=IDS_SET_POP_D%></td>
              </tr>
            </table></td>
          <td><table width="100%" border="1" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#000000">
              <tr> 
                <td height="25" align="center" bgcolor="#CCCCCC"><a href="setforward.asp"><font color="#000000"><%=IDS_AUTO_FORWARD%></font></a></td>
              </tr>
              <tr> 
                <td height="80" align="center" bgcolor="#F7F3F7"><%=IDS_AUTO_FORWARD%><%=IDS_OPTION%></td>
              </tr>
            </table></td>
        </tr>
     <tr> 
          <td><table width="100%" border="1" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#000000">
              <tr> 
                <td height="25" align="center" bgcolor="#CECFCE"><a href="setfilter.asp"><font color="#000000"><%=IDS_EMAIL_FILTER%></font></a></td>
              </tr>
              <tr> 
                <td height="80" align="center" bgcolor="#F7F3F7"><%=IDS_EMAIL_FILTER%><%=IDS_OPTION%></td>
              </tr>
            </table></td>
          <td><table width="100%" border="1" cellpadding="4" cellspacing="1" bordercolor="#FFFFFF" bgcolor="#000000">
              <tr> 
                <td height="25" align="center" bgcolor="#CECFCE"><a href="setautoreply.asp"><font color="#000000"><%=IDS_AUTO_REPLY%></font></a></td>
              </tr>
              <tr> 
                <td height="80" bgcolor="#F7F3F7" align="center"> <%=IDS_AUTO_REPLY%><%=IDS_OPTION%></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <p>&nbsp;</p>
      </TD>
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