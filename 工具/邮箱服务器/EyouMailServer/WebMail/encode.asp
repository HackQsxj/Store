<%
Function Autolink(strContent)
	strContent = replace(strContent, ">", "&gt;")
	strContent = replace(strContent, "<", "&lt;")
	strContent = Replace(strContent, CHR(34), "&quot;")
	strContent = Replace(strContent, CHR(39), "&#39;")
	Dim re
	set re = New RegExp	
	re.IgnoreCase = True
	re.Global = True
	
	re.Pattern = "^((http|https|ftp|rtsp|mms):(\/\/|\\\\)[A-Za-z0-9\./=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<a<>target=_blank<>href=$1>$1</a>")
	re.Pattern = "((http|https|ftp|rtsp|mms):(\/\/|\\\\)[A-Za-z0-9\./=\?%\-&_~`@':+!]+)$"
	strContent = re.Replace(strContent,"<a<>target=_blank<>href=$1>$1</a>")
	re.Pattern = "([^>=""])((http|https|ftp|rtsp|mms):(\/\/|\\\\)[A-Za-z0-9\./=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"$1<a<>target=_blank<>href=$2>$2</a>")
	re.Pattern = "([^(http://|http:\\)])((www|cn)[.](\w)+[.]{1,}(net|com|cn|org|cc)(((\/[\~]*|\\[\~]*)(\w)+)|[.](\w)+)*(((([?](\w)+){1}[=]*))*((\w)+){1}([\&](\w)+[\=](\w)+)*)*)"
	strContent = re.Replace(strContent,"<a<>target=_blank<>href=http://$2>$2</a>")

	'strContent = Replace(strContent, CHR(32), " &nbsp;")
	'strContent = Replace(strContent, CHR(9), "&nbsp; ")
	strContent = Replace(strContent, "<>", " ")

	Autolink = strContent
End function

Function HTMLEncode(fString)
	If not isnull(fString) then
		fString = replace(fString, ">", "&gt;")
		fString = replace(fString, "<", "&lt;")
		'fString = Replace(fString, CHR(32), "&nbsp;")
		'fString = Replace(fString, CHR(9), "&nbsp;")
		fString = Replace(fString, CHR(34), "&quot;")
		fString = Replace(fString, CHR(39), "&#39;")
		HTMLEncode = fString
	End if
End function
%>