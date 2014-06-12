<%@ page contentType="text/html" language="java" %>
<%@ page import="myclasses.*" %>
<%@ page import="java.util.*"%>
<% 
String  firstName = "";
String  lastName = "";
String  password = "";
String  country = "";
String  city = "";
Integer zipcode = 0;
String  address = "";
String  email = "";

String error = "";

Customer currentCustomer = new Customer();
if(request.getParameter("email") != null){

    firstName  = request.getParameter("firstname");
    lastName   = request.getParameter("lastname");
    password   = request.getParameter("password");
    country    = request.getParameter("country");
    city       = request.getParameter("city");
    zipcode    = Integer.parseInt(request.getParameter("zipcode"));
    address    = request.getParameter("address");
    email      = request.getParameter("email");

    currentCustomer.CreateCustomer(firstName, lastName, password, country, city, zipcode, address, email);

    session.setAttribute("currentCustomer", currentCustomer);
}
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
                    <p>Vielen dank für die Registrierung.</p>
                <% }else{ %>
                    <div class="fullwidth"><form action="register.jsp" method="POST"><table>
                    <tr><td><label for="firstname" >Vorname:        </label></td><td><input required type="text"     name="firstname" id="firstname"></td></tr>
                    <tr><td><label for="lastname" > Nachname:       </label></td><td><input required type="text"     name="lastname"  id="lastname"></td></tr>
                    <tr><td><label for="country" >  Land:           </label></td><td><input required type="text"     name="country"   id="country"></td></tr>
                    <tr><td><label for="city" >     Stadt:          </label></td><td><input required type="text"     name="city"      id="city"></td></tr>
                    <tr><td><label for="zipcode" >  Postleitzahl:   </label></td><td><input required type="text"     name="zipcode"   id="zipcode"></td></tr>
                    <tr><td><label for="address" >  Adresse:        </label></td><td><input required type="text"     name="address"   id="address"></td></tr>
                    <tr><td><label for="email" >    Email:          </label></td><td><input required type="text"     name="email"     id="email"></td></tr>
                    <tr><td><label for="password" > Passwort:       </label></td><td><input required type="password" name="password"  id="password"></td></tr>
                    <tr><td></td><td><input type="submit" value="Registrieren"></td></tr>
                    </table></form></div>
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