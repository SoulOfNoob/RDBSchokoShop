<%@ page contentType="text/html" language="java" %>
<%@ page import="myclasses.*" %>
<%@ page import="java.util.*"%>
<% 
String email    = "";
String password = "";
String error    = "";
String articleString = "";

Double summe    = 0.0;
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
Integer id = 0;
Integer i = 0;
Integer wert = 0;

List article_ids = database.GetArticleIds();
List<Article> boughtArticles = new ArrayList<Article>();
List<Integer> boughtAmount   = new ArrayList<Integer>();

if(request.getParameter("feld1") != null){
    for(i=0;i<article_ids.size();i++){
        if(request.getParameter("feld"+(i+1)) != null){
            wert = Integer.parseInt( request.getParameter( "feld"+(i+1) ) );
        }
        if(wert > 0){
            Article article = new Article();
            id = (Integer) article_ids.get(i);
            article.LoadArticleById(id);
            boughtArticles.add(article);
            boughtAmount.add(wert);
        }
    }
    session.setAttribute("boughtArticles", boughtArticles);
    session.setAttribute("boughtAmount", boughtAmount);
}else if(session.getAttribute("boughtArticles") != null && session.getAttribute("boughtArticles") != "null"){
    boughtArticles = (List) session.getAttribute("boughtArticles");
    boughtAmount   = (List) session.getAttribute("boughtAmount");
}

if(request.getParameter("switch") != null){
    Integer tmp_customer_ID = Integer.parseInt(request.getParameter("customerid"));
    Double  tmp_summe       = Double.parseDouble(request.getParameter("price"));
    String  tmp_articles    = request.getParameter("articles");

    error = database.ExecuteQuery("INSERT INTO `Bills` (customer_ID,status,price,articles) VALUES ("+tmp_customer_ID+",1,"+tmp_summe+", '"+tmp_articles+"');");
}

//error = error + "<br />boughtArticles: "+boughtArticles+"<br />boughtAmount: "+boughtAmount;
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
                    <form action="cart.jsp" method="POST">
                        <div class="fullwidth db_output">
                            <table>
                                <tr>
                                    <th>Artikelname</th>
                                    <th>Beschreibung</th>
                                    <th>Menge</th>
                                    <th>Stückpreis</th>
                                    <th>Gesamptpreis</th>
                                </tr>
                                <% for(i=0;i<boughtArticles.size();i++){ 
                                    Article article = new Article();
                                    article = (Article) boughtArticles.get(i);
                                    Double sum = (boughtAmount.get(i) * article.GetPrice());
                                %>
                                    <tr>
                                        <td><%= article.GetArticleName() %></td>
                                        <td><%= article.GetDescription() %></td>
                                        <td><%= boughtAmount.get(i) %></td>
                                        <td><%= article.GetPrice()%> &euro;</td>
                                        <td><%= sum %> &euro;</td>
                                    </tr>


                                <%
                                    articleString = articleString + "[Artikel_ID: "+article.GetId()+", Menge: "+boughtAmount.get(i)+"], ";
                                    summe = summe + sum; 
                                } %>
                                <input type="hidden" name="switch"      value="order">
                                <input type="hidden" name="customerid"  value="<%= currentCustomer.GetId() %>">
                                <input type="hidden" name="price"       value="<%= summe %>">
                                <input type="hidden" name="articles"    value="<%= articleString %>">
                                <tr><td colspan="2"></td><td colspan="2"><strong>Summe:</strong></td><td><%= summe %> &euro;</td></tr>

                            </table>
                        </div>
                        <p style="text-align: right;"><input type="submit" value="Artikel Bestellen"></p>
                    </form>
                <% }else{ %>
                    <p>Not logged in!</p>
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