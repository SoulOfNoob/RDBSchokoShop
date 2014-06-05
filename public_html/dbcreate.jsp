<%@ page contentType="text/html" language="java" %>
<%@ page import="myclasses.CreateDatabaseTablesClass" %>
<%@ page import="java.util.*"%>
<html>
	<head>
		<title>
			JSP-DBCreate
		</title>
	</head>
	<body bgcolor="#CCFF00">
		<% CreateDatabaseTablesClass tables = new CreateDatabaseTablesClass(); %>
		<%= tables.CreateTables() %>
		<br />
		<a href="http://praxi.mt.haw-hamburg.de/~dx45"> Zur&uuml;ck zu praxi</a>
	</body>
</html>