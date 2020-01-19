<% 
	Option Explicit
	Response.Buffer = True
%>
<!-- #include file=language.txt -->
<Html>
<Head>
<meta http-equiv="refresh" content="600">
<Title>
<!--#include file="webmailver.txt" -->
</Title>
<Link Href="styles.css" Rel=STYLESHEET Type=text/css>
<Script Language="JavaScript" Type="text/JavaScript">
<!--
function MM_reloadPage(init) 
{  
	//reloads the window if Nav4 resized
	if (init==true) with (navigator) 
	{
		if ((appName=="Netscape")&&(parseInt(appVersion)==4)) 
		{
			document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; 
		}
	}
	else
	if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) 
		location.reload();
}
MM_reloadPage(true);
function showmenu(id)
{
	var img_plus=new Image();
	var img_minus=new Image();

	var img_closefolder=new Image();
	var img_openfolder=new Image();	

	img_plus.src="images/plus.gif";
	img_minus.src="images/minus.gif";
	img_closefolder.src="images/closefolder.gif";
	img_openfolder.src="images/openfolder.gif";

	if (document.all("menu_"+id).style.display=="none")
	{
		document.all("menu_"+id).style.display="";
		document.all("img_design_"+id).src=img_minus.src;
		document.all("img_folder_"+id).src=img_openfolder.src;
	 }
	else
	{
		document.all("menu_"+id).style.display="none";
		document.all("img_design_"+id).src=img_plus.src;
		document.all("img_folder_"+id).src=img_closefolder.src;
	}
}
//-->
</Script>
</Head>

<Body Bgcolor="#FFFFF7">
<Table Border=0 Cellpadding=0 Cellspacing="0">
	<Tr> 
		<Td><Img Src="images/nav_01.gif" Width=6 Height=8></Td>
		<Td Background="images/nav_02.gif"> <IMG Src="images/nav_02.gif" Width=121 Height=8></Td>
		<Td><IMG Src="images/nav_03.gif" Width=11 Height=8></Td>
	</Tr>
	<Tr> 
		<Td background="images/nav_04.gif">&nbsp;</Td>
		<Td bgcolor="#fdfffa">
		<Table border="0" cellpadding="0" cellspacing="0">
			<Tr> 
				<Td width="364" bgcolor="#FDFFFA">
				<Table border="0" cellpadding="0" cellspacing="0" background="images/nav_backk.gif">
				<Tr> 
                <Td> <Img src="images/user.gif" width="14" height="15">&nbsp;<strong><%
If InstrRev(Session("Account"), "@") > 0 Then 
			Response.Write Mid(Session("Account"), 1, Len(Session("Account")) - Len(Session("Domain")) - 1)
Else
			Response.Write Session("Account")
End If
%></strong><Br>
                  <Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle><Img  src="images/infolder.gif" width=19 height="20" border=0 align=absMiddle><A href="finbox.asp" target="main"><%=IDS_INBOX%></A><Br>
                  <Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle><Img src="images/outfolder.gif" width=19 height="20" border=0 align=absMiddle><A href="sendmail.asp" target="main"><%=IDS_NEW_MAIL%></A><br>
                  <Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle><Img  src="images/popfolder.gif" width=19 height="20" border=0 align=absMiddle><A href="getpop.asp" target="main"><%=IDS_POPMAIL%></a>
				</Td>
			</Tr>
			<Tr> 
			<Td>
<A href="javascript:showmenu(1)"><Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle  id=img_design_1><Img src="images/openfolder.gif"  id=img_folder_1 width=19 height="20" border=0 align=absMiddle></a><a href="MailBoxInfo.asp" target="main"><%=IDS_FOLDER%></A>
			</Td>
			</Tr>
			<Tr id=menu_1> 
				<Td>
<Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="finbox.asp" target="main"><%=IDS_INBOX%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="foutbox.asp" target="main"><%=IDS_OUTBOX%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="fdrafts.asp" target="main"><%=IDS_DRAFTS%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="ffavorite.asp" target="main"><%=IDS_FAVORITE%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="ftrash.asp" target="main"><%=IDS_TRASHCAN%></A>
				</Td>
			</Tr>
			<Tr> 
				<Td>
<Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle><Img  src="images/addr.gif" width=19 height="20" border=0 align=absMiddle><A href="address.asp" target="main"><%=IDS_ADDRESS%></A>
				</Td>
			</Tr>
<!-- bbs
			<Tr> 
				<Td>
<Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle><Img  src="images/addr.gif" width=19 height="20" border=0 align=absMiddle><A href="bbs/" target="main">BBS</A>
				</Td>
			</Tr>
 -->
<!-- public address 
			<Tr> 
				<Td>
<Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle><Img  src="images/addr.gif" width=19 height="20" border=0 align=absMiddle><A href="addresspub.asp" target="main"><font color=red>Public Address</font></A>
				</Td>
			</Tr>
 public address -->
			<Tr> 
				<Td>
<A href="javascript:showmenu(2)"><Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle id=img_design_2><Img src="images/openfolder.gif"  name=img_folder_2 width=19 height="20" border=0 align=absMiddle></A><A href="mailoptions.asp" target="main"><%=IDS_SET_OPTION%></A>
				</Td>
			</Tr>
			<Tr id=menu_2> 
				<Td>
<Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="setpersoninfo.asp" target="main"><%=IDS_SET_PERSONINFO%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="setpasswd.asp" target="main"><%=IDS_SET_PASSWD%></a><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="setsign.asp" target="main"><%=IDS_SET_SIGN%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="setparam.asp" target="main"><%=IDS_SET_PARAM%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="setpop.asp" target="main"><%=IDS_SET_POP%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="setforward.asp" target="main"><%=IDS_AUTO_FORWARD%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="setfilter.asp" target="main"><%=IDS_EMAIL_FILTER%></A><Br><Img align=absMiddle border=0  src="images/i_line.gif" width=19><Img align=absMiddle border=0  src="images/t_line.gif" width=19><Img src="images/navdot.gif" width="12" height="14" hspace="2" align="absmiddle"><A href="setautoreply.asp" target="main"><%=IDS_AUTO_REPLY%></A>
				</Td>
			</Tr>
<% If Session("Admin") <> 0 Then %>
<!-- admin -->
			<Tr> 
				<Td>
<Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle><Img  src="images/addr.gif" width=19 height="20" border=0 align=absMiddle><A href="admin.asp" target="main"><font color=red><%=IDS_ADMIN%></font></A>
				</Td>
			</Tr>
<!-- admin -->
<% End If %>
<% If Session("Admin") = 2 Then %>
<!-- sys admin -->
			<Tr> 
				<Td>
<Img src="images/minus.gif" width=19 height="20" border=0 align=absMiddle><Img  src="images/addr.gif" width=19 height="20" border=0 align=absMiddle><A href="sysadmin.asp" target="main"><font color=red><%=IDS_SYS_ADMIN%></font></A>
				</Td>
			</Tr>
<!-- sys admin -->
<% End If %>

			<Tr> 
				<Td>
<Img src="images/ender.gif" width=19 height="20" border=0 align=absMiddle><Img src="images/endfolder.gif" width=19 height="20" border=0 align=absMiddle><A href="logout.asp" target="_parent"><%=IDS_EXIT%></A>
				</Td>
			</Tr>
		</Table>
			</Td>
		</Tr>
	</Table>
	</Td>
	<Td background="images/nav_06.gif">&nbsp;</Td>
	</Tr>
	<Tr> 
		<Td><Img SRC="images/nav_07.gif" WIDTH=6 HEIGHT=9></Td>
		<Td background="images/nav_08.gif"><Img SRC="images/nav_08.gif" WIDTH=121 HEIGHT=9></Td>
		<Td><Img SRC="images/nav_09.gif" WIDTH=11 HEIGHT=9></Td>
	</Tr>
</Table>
</Body>
</Html>