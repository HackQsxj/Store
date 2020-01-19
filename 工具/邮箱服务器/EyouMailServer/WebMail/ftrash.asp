<% 
  Option Explicit
  Response.Buffer = True
%>
<!-- #include file=language.txt -->
<!-- #include file=conn.asp -->
<!-- #include file="encode.asp" -->
<Html>
<Head>
<title><!--#include file="webmailver.txt" --></title>
<Style Type = text/css>
a:link {text-decoration:none; cursor: hand}
a:visited {text-decoration:none}
a:hover {text-decoration:underline}
body,table {  font-family: "Arial", "Helvetica", "sans-serif"; font-size: 9pt}
</Style>
<SCRIPT language=JavaScript>
<!--
	function CheckAll(v)
	{
		var i;
		for (i=0;i<document.forms[0].elements.length;i++)
		{
			var e = document.forms[0].elements[i];
		        e.checked = v;
		}
	}
	function OnDelete()
	{
		var str, a, i;
		str = new String("");
		for(i = 0; i < document.forms[0].elements.length ; i ++)
		{
			var e = document.forms[0].elements[i];
			if(e.name == 'sel')
			{
			   if ( e.checked == true)
			   {
		   		a = e.value;
				str = str + a + ";";
			   }
			};
		}
		if(str == "")
		{
			alert("<%=IDS_ALERT_NO_SELECTION%>")

		}
		else
		{
			if(confirm("<%=IDS_ALERT_PDELETE%>")==true)
			{
			document.forms[0].indexOfMail.value = str
			document.forms[0].action="fdelmail.asp";
			document.forms[0].submit();
			}
		}
	}
	function OnMove()
	{
	  var str, a, i;
	  str = new String("");
	  if (document.forms[0].ToFolder.value>0)
	   { 
		for(i = 0; i < document.forms[0].elements.length ; i ++)
		{
			var e = document.forms[0].elements[i];
			if(e.name == 'sel')
			{
			   if ( e.checked == true)
			   {
		   		a = e.value;
				str = str + a + ";";
			   }
			};
		}
		if(str == "")
		{
			alert("<%=IDS_ALERT_NO_SELECTION_MOVE %>")

		}
		else
		{
			if(confirm("<%=IDS_ALERT_MOVE%>")==true)
			{
			document.forms[0].indexOfMail.value = str
	    	document.forms[0].action="fmvmail.asp";
			document.forms[0].submit();
			}
		}
	  }

	}
	function OnGetMail()
	{
		document.forms[0].action="fgetmail.asp";
		document.forms[0].submit();
	}
	function SetMailID(id)
	{
		document.all.item("indexOfMail").value=id;
	}
//-->
</SCRIPT>
<base target="_self">
</Head>
<Body bgColor=#FFFFF7 alink=#000000 vlink=#000000 link=#000000  >
<table width="100%" border="0" align="center" cellspacing="0" bordercolor=gray  bordercolordark=white  >
  <tr bgcolor="#dcdcdc"  valign="left"> 
    <td width="100%"  height="100%" align="left" valign="top" bgcolor="#FFFFF7"> 
      <%
	Dim rs
	Dim strSql
	Dim nI

	If Session("LoginSuccess")= 1 Then
 
	set rs=createobject("adodb.recordset")
	strSql="select * from mailfolder where account='" & Session("Account") & "' and folderid='4' order by mailid DESC"
	rs.open strSql,Conn,1,2
	 
%>
      <FORM action="" method=post align="left">
        <Table width="100%" >
          <Tr > 
            <TD vAlign=center width="100%" height="1"><%=IDS_TRASHCAN%>&nbsp;<%=RS.recordcount%> 
              <%=IDS_MAILS%>. <a href="javascript:OnDelete()"><img src="images/delete.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_PDELETE%></a>&nbsp;</TD>
          </Tr>
        </Table>
        <table width="100%" border="0" cellpadding="4" cellspacing="1" bordercolordark=white bgcolor=#400000>
          <TR vAlign=middle bgcolor="#990000"> 
            <TD width="24" align="center" ><font color="#FFFFFF"><b > 
              <input name=chkall  onClick=CheckAll(document.forms[0].chkall[0].checked) type=checkbox value=on>
              </b></font></TD>
            <TD width="19"><font color="#FFFFFF">&nbsp;</font></TD>
            <td width="156"><font color="#FFFFFF"><%=IDS_SENDER%></font></td>
            <TD width="100%"><font color="#FFFFFF"><%=IDS_SUBJECT%></font></TD>
            <td width="124"><font color="#FFFFFF"><%=IDS_DATE%></font></td>
            <TD width="46"><font color="#FFFFFF"><%=IDS_SIZE%></font></TD>
          </TR>
<%
		dim nCurPage
		dim nCurNo
		dim nCurCur
		dim nMailCount
		
		nMailCount = RS.recordcount
		nCurPage = 1
		nCurNo = 1
		nCurCur = 1
		
  		if Request.QueryString("pages")<>"" then
		    if not IsNumeric(Request.QueryString("pages")) then response.Redirect "ftrash.asp"
            			nCurpage=cint(Request.QueryString("pages"))
    		    end if
		nCurNo = (nCurPage-1) * session("maxlist") + 1
		
		For nI = 1 To nCurNo - 1
		  RS.movenext
		  if RS.eof then response.Redirect "ftrash.asp"
		Next
		
		do while (nCurNo <= nMailCount) and (nCurCur<=Session("maxlist"))
  
%>
          <TR bgcolor="#FFFFFF"> 
            <Td height=1 align=center vAlign=top> <b> 
              <Input name=sel type=checkbox value='<%=HTMLEncode(RS("uid"))%>'>
              </b></Td>
            <Td> 
	<%if RS("mailIsread") mod 2 = 1 then %>
	<%if RS("mailIsread") = 3 then%><img src="images/reply.gif" width="16" height="16"><%else%>
	<%if RS("mailIsread") = 5 then%><img src="images/forward.gif" width="16" height="16"><%else%><img src="images/oldmail.gif" width="16" height="16"><%end if%><%end if%>	
              <%else 
		if RS("mailIsread")  = 0 then %>
              <img src="images/newmail.gif"> 
              <%else%>
              &nbsp; 
              <%end if
              end if%>
            </Td>
            <td> 
              <%if RS("mailIsread") = 0 then %>
              <b><%=HTMLEncode(RS("mailfrom"))%> </b> 
              <%else%>
              <%=RS("mailfrom")%> 
              <%end if%>
            </td>
            <Td><a href='fgetmail.asp?subpage=ftrash&indexOfMail=<%=HTMLEncode(RS("uid"))%>' > 
              <%if RS("mailIsread") = 0 then %>
              <b><%=HTMLEncode(RS("subject"))%> </b> 
              <%else%>
              <%=HTMLEncode(RS("subject"))%> 
              <%end if%>
              </a></Td>
            <td> 
              <%if RS("mailIsread") = 0 then %>
              <b><%=HTMLEncode(RS("maildate"))%> </b> 
              <%else%>
              <%=RS("maildate")%> 
              <%end if%>
            </td>
            <Td> 
              <%if RS("mailIsread") = 0 then %>
               <b><%If RS("mailsize") Then Response.Write(CStr(Round(RS("mailsize")/1024+0.5))&" K ") Else Response.Write("1 K ")%> </b> 
              <%else%>
              <%If RS("mailsize") Then Response.Write(CStr(Round(RS("mailsize")/1024+0.5))&" K ") Else Response.Write("1 K ")%> 
              <%end if%>
            </Td>
          </Tr>
          <%
		RS.movenext
        		nCurCur = nCurCur + 1
		nCurNo = nCurNo + 1 
	    loop
%>
		<tr bgcolor="#FFFFFF"> 
            <td height="0"><img height="1" width="24" src="spacer.gif"></td>
            <td><img height="1" width="19" src="spacer.gif"></td>
            <td><img height="1" width="156" src="spacer.gif"></td>
            <td></td>
            <td><img height="1" width="124" src="spacer.gif"></td>
            <td><img height="1" width="46" src="spacer.gif"></td>
          </tr>
        </Table>
        <TABLE width="100%" >
          <TBODY> 
          <TR> 
            <TD align=LEFT height=1 vAlign=top width="100%"> <b > 
              <INPUT name=chkall  onclick=CheckAll(document.forms[0].chkall[1].checked) type=checkbox value=on>
              </b> <FONT color=#cc3366><%=IDS_SELECT_ALL%></FONT> <a href="javascript:OnDelete()"><img src="images/delete.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_PDELETE%></a>&nbsp;&nbsp;<a href="javascript:OnMove()"><img src="images/move.gif" width="14" height="14" hspace="5" border="0" align="absmiddle"><%=IDS_MOVE%></a> 
              <select name="ToFolder" size="1" class="normal-font" id="ToFolder">
                <option value="-1" selected></option>
                <option value="1"><%=IDS_INBOX%></option>
                <option value="2"><%=IDS_OUTBOX%></option>
                <option value="3"><%=IDS_FAVORITE%></option>
                <option value="5"><%=IDS_DRAFTS%></option>
              </select>
            </TD>
          </TR>
          </TBODY> 
        </TABLE>
        <input type = hidden value = "-1" name=indexOfMail id=indexOfMail>
        <input name="subpage" type="hidden" id="subpage" value="ftrash">
        <input type = hidden value="<%=Request("pages")%>" name=pages id=pages>
      </Form>
      <%
	rs.Close
	set rs = nothing
	End If
	conn.Close
	set conn = nothing
%>
    </td>
  </tr>
  <%
    if nMailCount>session("maxlist") then
	
	Dim nPages
	
	nPages = nMailcount \ Session("maxlist")
	If nPages * Session("maxlist") <> nMailcount Then
		nPages = nPages + 1
	End If
	
%>
  <tr bgcolor="#dcdcdc"  valign="left"> 
    <td valign="top" bgcolor="#FFFFFF"  height="100%"> 
      <div align="center">>> 
        <%    for nI=1 to nPages %>
        &nbsp; 
        <%if nI<> nCurPage then %>
        <a href="ftrash.asp?pages=<%=nI%>"><%=nI%></a> 
        <% else %>
        <b><%=nI%></b> 
        <%end if%>
        &nbsp; 
        <% next %>
        << </div>
    </td>
  </tr>
  <% 
	end if
%>
</table>
</Body>
</Html>
