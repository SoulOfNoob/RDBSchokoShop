<%@ page contentType="text/html" language="java" %>
<%@ page import="myclasses.*" %>
<%@ page import="java.util.*"%>
<% session.invalidate();%>
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
                    <form action="webshop.jsp" method="POST">
                        <input type="text" name="email" placeholder="E-Mail"/>                       
                        <input type="password" name="password" placeholder="Passwort"/>
                        <input type="submit" value="Login" class="login_button"/>
                        <div class="register"><a href="register.jsp" class="register_button">Registrieren</a></div>
                    </form>
                </div>  <!-- login -->
            </div> <!-- head -->
        </div> <!-- Head-Wrapper -->
        <div id="content-wrapper">
            <div id="content">
                <p>Logged Out!</p>
            </div> <!-- content -->
        </div> <!-- Content-Wrapper -->
        <div id="foot-wrapper">
            <div id="foot">
                <a href="admin.jsp">Admin</a>
            </div>
        </div> <!-- Foot-Wrapper -->
    </body>
</html>