<%@ page contentType="text/html" language="java" %>
<%@ page import="myclasses.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.ResultSet"%>
<% 
Customer currentCustomer = new Customer();
String error = "";
String switchvar = "";

if(session.getAttribute("currentCustomer") != null && session.getAttribute("currentCustomer") != "null"){
    currentCustomer = (Customer) session.getAttribute("currentCustomer");
}

if(request.getParameter("switch") != null && request.getParameter("switch") != "null"){
    switchvar = (String) request.getParameter("switch");
}

if(switchvar.equals("customer")){
    String  firstName  = request.getParameter("firstname");
    String  lastName   = request.getParameter("lastname");
    String  password   = request.getParameter("password");
    String  country    = request.getParameter("country");
    String  city       = request.getParameter("city");
    Integer zipcode = 0;
    try{    zipcode    = Integer.parseInt(request.getParameter("zipcode"));  } catch (Exception e) { error = "kein int"; }
    String  address    = request.getParameter("address");
    String  email      = request.getParameter("email");
    
    if(error.equals("")){
        Customer customer = new Customer();
        currentCustomer.CreateCustomer(firstName, lastName, password, country, city, zipcode, address, email);
    }
}

if(switchvar.equals("article")){
    String  articleName = request.getParameter("articlename");
    Integer stock = 0;
    try{    stock       = Integer.parseInt(request.getParameter("stock"));  } catch (Exception e) { error = "kein int"; }
    Double  price = 0.0;
    try{    price       = Double.parseDouble(request.getParameter("price"));} catch (Exception e) { error = "kein double"; }
    String  description = request.getParameter("description");
    String  picture     = request.getParameter("picture");

    if(error.equals("")){
        Article article = new Article();
        error = article.CreateArticle(articleName, stock, price, description, picture);
    }
}

if(session.getAttribute("currentCustomer") != null && session.getAttribute("currentCustomer") != "null" && switchvar.equals("deletecustomer")){
    Customer customer = new Customer();
    Integer id = 0;
    try{    id        = Integer.parseInt(request.getParameter("id"));  } catch (Exception e) { error = "kein int"; }
    customer.LoadCustomerById(id);
    error = customer.DeleteCustomer(id);
}

if(session.getAttribute("currentCustomer") != null && session.getAttribute("currentCustomer") != "null" && switchvar.equals("deletearticle")){
    Article article = new Article();
    Integer id = 0;
    try{    id        = Integer.parseInt(request.getParameter("id"));  } catch (Exception e) { error = "kein int"; }
    article.LoadArticleById(id);
    error = article.DeleteArticle(id);
}

Database database = new Database();
Integer id = 0;
Integer i = 0;

List customer_ids = database.GetCustomerIds();
List<Customer> allCustomers = new ArrayList<Customer>();
for(i=0;i<customer_ids.size();i++){
    Customer customer = new Customer();
    id = (Integer) customer_ids.get(i);
    customer.LoadCustomerById(id);
    allCustomers.add(customer);
}

List article_ids = database.GetArticleIds();
List<Article> allArticles = new ArrayList<Article>();
for(i=0;i<article_ids.size();i++){
    Article article = new Article();
    id = (Integer) article_ids.get(i);
    article.LoadArticleById(id);
    allArticles.add(article);
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
            <div id="content" style="text-align: center;">
                <% if(error != ""){ %><div id="error"><%= error %></div><% } %>
                <% if(currentCustomer.GetEmail() != ""){ %>
                    <div class="row clearfix">
                        <div class="column half">
                            Usereingabe<br /><br /><br />
                            <form action="admin.jsp" method="POST"><table>
                                <tr><td><label for="firstname" >Vorname:        </label></td><td><input required type="text"     name="firstname" id="firstname"></td></tr>
                                <tr><td><label for="lastname" > Nachname:       </label></td><td><input required type="text"     name="lastname"  id="lastname"></td></tr>
                                <tr><td><label for="country" >  Land:           </label></td><td><input required type="text"     name="country"   id="country"></td></tr>
                                <tr><td><label for="city" >     Stadt:          </label></td><td><input required type="text"     name="city"      id="city"></td></tr>
                                <tr><td><label for="zipcode" >  Postleitzahl:   </label></td><td><input required type="text"     name="zipcode"   id="zipcode"></td></tr>
                                <tr><td><label for="address" >  Adresse:        </label></td><td><input required type="text"     name="address"   id="address"></td></tr>
                                <tr><td><label for="email" >    Email:          </label></td><td><input required type="text"     name="email"     id="email"></td></tr>
                                <tr><td><label for="password" > Passwort:       </label></td><td><input required type="password" name="password"  id="password"></td></tr>
                                <input type="hidden" name="switch" value="customer">
                                <tr><td></td><td><input type="submit" value="Einfügen"></td></tr>
                            </table></form>
                        </div>
                        <div class="column half">
                            Artikeleingabe<br /><br /><br />
                            <form action="admin.jsp" method="POST"><table>
                                <tr><td><label for="articlename" > Artikel Name:   </label></td><td><input required type="text"     name="articlename"    id="articlename"></td></tr>
                                <tr><td><label for="stock" >        Menge:          </label></td><td><input required type="text"     name="stock"           id="stock"></td></tr>
                                <tr><td><label for="price" >        Preis:          </label></td><td><input required type="text"     name="price"           id="price"></td></tr>
                                <tr><td><label for="description" >  Beschreibung:   </label></td><td><input required type="text"     name="description"     id="description"></td></tr>
                                <tr><td><label for="picture" >      Bildpfad:       </label></td><td><input required type="text"     name="picture"         id="picture"></td></tr>
                                <input type="hidden" name="switch" value="article">
                                <tr><td></td><td><input type="submit" value="Einfügen"></td></tr>
                            </table></form>
                        </div>
                    </div>
                    <div class="space"></div>
                    
                    <div class="fullwidth db_output">
                        <strong>User</strong><br /><br />
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>password</th>
                                <th>firstname</th>
                                <th>lastname</th>
                                <th>country</th>
                                <th>city</th>
                                <th>zipcode</th>
                                <th>address</th>
                                <th>email</th>
                                <th>löschen</th>
                            </tr>
                            <% for(i=0;i<allCustomers.size();i++){ 
                                Customer customer = new Customer();
                                customer = allCustomers.get(i);
                            %>
                                <tr>
                                    <td><%= customer.GetId() %></td>
                                    <td><%= customer.GetId() %></td>
                                    <td><%= customer.GetFirstName() %></td>
                                    <td><%= customer.GetLastName() %></td>
                                    <td><%= customer.GetCountry() %></td>
                                    <td><%= customer.GetCity() %></td>
                                    <td><%= customer.GetZipcode() %></td>
                                    <td><%= customer.GetAddress() %></td>
                                    <td><%= customer.GetEmail() %></td>
                                    <td><a href="admin.jsp?switch=deletecustomer&id=<%= customer.GetId() %>">X</a></td>
                                </tr>
                            <% } %>
                        </table>
                    </div>
                    
                    <div class="fullwidth db_output">
                        <strong>Artikel</strong><br /><br />
                        <table>
                            <tr><th>ID</th><th>article_name</th><th>stock</th><th>price</th><th>description</th><th>picture</th><th>löschen</th></tr>
                            <% for(i=0;i<allArticles.size();i++){ 
                                Article article = new Article();
                                article = (Article) allArticles.get(i);
                            %>
                                <tr>
                                    <td><%= article.GetId() %></td>
                                    <td><%= article.GetArticleName() %></td>
                                    <td><%= article.GetStock() %></td>
                                    <td><%= article.GetPrice() %></td>
                                    <td><%= article.GetDescription() %></td>
                                    <td><%= article.GetPicture() %></td>
                                    <td><a href="admin.jsp?switch=deletearticle&id=<%= article.GetId() %>">X</a></td>
                                </tr>
                            <% } %>
                        </table>
                    </div>
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