<%@ page contentType="text/html" language="java" %>
<%@ page import="myclasses.*" %>
<%@ page import="java.util.*"%>
<html>
	<head>
		<title>
			JSP-ClassTests
		</title>
	</head>
	<body bgcolor="#00E0FF">
		<table border="1">
			<tr><td colspan="2" style="text-align: center;">
				db.CreateTables(): 
				<% Database db = new Database(); %>
				<%= db.CreateTables() %>
				
			</td></tr>

			<tr><td width="50%">
				jan.CreateCustomer("Jan", "Ryklikas", "meinpass", "Deutschland", "Hamburg", 22459, "testadresse", "jan_ryklikas@ymail.com"): 
				<% Customer jan = new Customer(); %>
				<%= jan.CreateCustomer("Jan", "Ryklikas", "meinpass", "Deutschland", "Hamburg", 22459, "testadresse", "jan_ryklikas@ymail.com") %>
				<br />
				<table border="0">
					<tr><td>ID: </td><td><%= jan.GetId() %></td></tr>
					<tr><td>Vorname: </td><td><%= jan.GetFirstName() %></td></tr>
					<tr><td>Nachname: </td><td><%= jan.GetLastName() %></td></tr>
					<tr><td>Land: </td><td><%= jan.GetCountry() %></td></tr>
					<tr><td>Stadt: </td><td><%= jan.GetCity() %></td></tr>
					<tr><td>Postleitzahl</td><td><%= jan.GetZipcode() %></td></tr>
					<tr><td>Adresse: </td><td><%= jan.GetAddress() %></td></tr>
					<tr><td>Email: </td><td><%= jan.GetEmail() %></td></tr>
				</table>
				<br />
				<br />
				
				jan2.LoadCustomer(Ryklikas", "meinpass"): 
				<% Customer jan2 = new Customer(); %>
				<%= jan2.LoadCustomer("jan_ryklikas@ymail.com", "meinpass") %>
				<br />
				<table border="0">
					<tr><td>ID: </td><td><%= jan2.GetId() %></td></tr>
					<tr><td>Vorname: </td><td><%= jan2.GetFirstName() %></td></tr>
					<tr><td>Nachname: </td><td><%= jan2.GetLastName() %></td></tr>
					<tr><td>Land: </td><td><%= jan2.GetCountry() %></td></tr>
					<tr><td>Stadt: </td><td><%= jan2.GetCity() %></td></tr>
					<tr><td>Postleitzahl</td><td><%= jan2.GetZipcode() %></td></tr>
					<tr><td>Adresse: </td><td><%= jan2.GetAddress() %></td></tr>
					<tr><td>Email: </td><td><%= jan2.GetEmail() %></td></tr>
				</table>
			</td>

			<td width="50%">
				schoko.CreateArticle('Schokolade',50,5.99,'Leckere Schokolade aus natuerlichem Anbau','Pfad'): 
				<% Article schoko = new Article(); %>
				<%= schoko.CreateArticle("Schokolade", 50, 5.99, "Leckere Schokolade aus natuerlichem Anbau", "BildPfad") %>
				
				<table border="0">
					<tr><td>ID: </td><td><%= schoko.GetId() %></td></tr>
					<tr><td>Artikel Name: </td><td><%= schoko.GetArticleName() %></td></tr>
					<tr><td>Vorrat: </td><td><%= schoko.GetStock() %></td></tr>
					<tr><td>Preis: </td><td><%= schoko.GetPrice() %></td></tr>
					<tr><td>Beschreibung: </td><td><%= schoko.GetDescription() %></td></tr>
					<tr><td>Bild</td><td><%= schoko.GetPicture() %></td></tr>
				</table>
				<br />
				<br />
				
				schoko2.LoadArticle("Schokolade"): 
				<% Article schoko2 = new Article(); %>
				<%= schoko2.LoadArticle("Schokolade") %>
				
				<table border="0">
					<tr><td>ID: </td><td><%= schoko2.GetId() %></td></tr>
					<tr><td>Artikel Name: </td><td><%= schoko2.GetArticleName() %></td></tr>
					<tr><td>Vorrat: </td><td><%= schoko2.GetStock() %></td></tr>
					<tr><td>Preis: </td><td><%= schoko2.GetPrice() %></td></tr>
					<tr><td>Beschreibung: </td><td><%= schoko2.GetDescription() %></td></tr>
					<tr><td>Bild</td><td><%= schoko2.GetPicture() %></td></tr>
				</table>
			</td>
			<tr><td colspan="2" style="text-align: center;"><a href="http://praxi.mt.haw-hamburg.de/~dx45"> Zur&uuml;ck zu praxi</a></td></tr>
		</table>
	</body>
</html>