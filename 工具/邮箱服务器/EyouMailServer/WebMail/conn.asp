<%
	Dim conn
	Dim db
	Dim strConn

	'---- get the file path of database
	db = Server.MapPath("/mail")
	db = Mid(db, 1, InStrRev(db, "\")) & "db\db.mdb"

	'---- open database	
	Set conn = Server.CreateObject("ADODB.Connection")
	'---- almost for MS Access 2000
	'strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & db
	'---- almost for MS Access 97
	'strConn = "driver={Microsoft Access Driver (*.mdb)};dbq=" & db
	'---- for ODBC connection
	strConn = "DSN=CMailServer"
'	Conn.Mode = 3
	conn.open strConn
%>