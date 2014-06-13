<%@ page contentType="text/html" language="java" %>
<%@ page import="myclasses.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.ResultSet"%>
<% 
String email    = "";
String password = "";
String error    = "";

Customer currentCustomer = new Customer();
if(request.getParameter("email") != null && request.getParameter("password") != null){
    email       = request.getParameter("email");
    password    = request.getParameter("password");
    error       = currentCustomer.LoadCustomer(email, password);
    session.setAttribute("currentCustomer", currentCustomer);
}else if(session.getAttribute("currentCustomer") != null && session.getAttribute("currentCustomer") != "null"){
    currentCustomer = (Customer) session.getAttribute("currentCustomer");
}

Database database = new Database();
String table_rows = database.GetOrders(currentCustomer.GetId());
%>

<!DOCTYPE html>
<html lang="de">
    <head>
        <link href="css/style.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href='http://fonts.googleapis.com/css?family=Special+Elite' rel='stylesheet' type='text/css'>
        <meta name="author" content="Jan Ryklikas"/>
        <meta name="keywords" lang="de" content="Webshop"/>
        <meta name="description" content=
            "description"
        />
        <meta name="robots" content="index,follow"/>
        <link rel="shortcut icon" href="img/favico.ico" type="image/x-icon"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=1024" />
        <!--<meta name="viewport" content="width=device-width; initial-scale=1.0">-->
        <title>Jans Webshop</title>
    </head> 
    <body>
        <div id="head-wrapper">
            <div id="header">
                <div id="logo">
                    <a href="webshop.jsp">Jan's Webshop</a>
                </div> <!-- logo -->
                <div id="login">
                    <% if(currentCustomer.GetEmail() != ""){ %>
                        <div id="profile_info">
                            Hallo <%= currentCustomer.GetFirstName() %> <%= currentCustomer.GetLastName() %><br />
                            <a href="profile.jsp">Profil</a><br />
                            <a href="logout.jsp">logout</a><br />
                            <a href="cart.jsp">Warenkorb</a><br />
                        </div>
                    <% }else{ %>
                        <form action="webshop.jsp" method="POST">
                            <input type="text" name="email" placeholder="E-Mail"/>                       
                            <input type="password" name="password" placeholder="Passwort"/>
                            <input type="submit" value="Login" class="login_button"/>
                            <div class="register"><a href="register.jsp" class="register_button">Registrieren</a></div>
                        </form>
                    <% } %>
                </div>  <!-- login -->
            </div> <!-- head -->
        </div> <!-- Head-Wrapper -->
        <div id="content-wrapper">
            <div id="content">
                <% if(error != ""){ %><div id="error"><%= error %></div><% } %>
                <% if(currentCustomer.GetEmail() != ""){ %>
                    <div style="width: 100%" class="fullwidth">
                        <strong>Meine Daten</strong><br /><br />
                        <table border="0">
                            <tr><td>ID: </td><td><%= currentCustomer.GetId() %></td></tr>
                            <tr><td>Vorname: </td><td><%= currentCustomer.GetFirstName() %></td></tr>
                            <tr><td>Nachname: </td><td><%= currentCustomer.GetLastName() %></td></tr>
                            <tr><td>Land: </td><td><%= currentCustomer.GetCountry() %></td></tr>
                            <tr><td>Stadt: </td><td><%= currentCustomer.GetCity() %></td></tr>
                            <tr><td>Postleitzah: </td><td><%= currentCustomer.GetZipcode() %></td></tr>
                            <tr><td>Adresse: </td><td><%= currentCustomer.GetAddress() %></td></tr>
                            <tr><td>Email: </td><td><%= currentCustomer.GetEmail() %></td></tr>
                        </table>
                    </div>
                    <div class="space"></div>
                    <div class="fullwidth db_output">
                        <strong>Meine Bestellungen</strong><br /><br />
                        <table>
                            <tr>
                                <th>Bestellnummer</th>
                                <th>Datum</th>
                                <th>Status</th>
                                <th>Gesamtpreis</th>
                                <th>Artikel/Menge</th>
                            </tr>
                            <%= table_rows %>
                        </table>
                    </div>
                <% }else{ %>
                    <p>Not Logged in!</p>
                <% } %>
            </div> <!-- content -->
        </div> <!-- Content-Wrapper -->
        <div id="foot-wrapper">
            <div id="foot">
                <a href="admin.jsp">Admin</a>
            </div>
        </div> <!-- Foot-Wrapper -->
    </body>
</html>