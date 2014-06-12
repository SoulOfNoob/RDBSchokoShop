//Das JDBC-Servlet "Article.java"

package myclasses;

import java.io.*;
import java.sql.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.*;
import javax.servlet.http.*;

//Hier die Klasse
public class Article{
  Integer id = 0;
  String  articleName = "";
  Integer stock = 0;
  Double  price = 0.0;
  String  description = "";
  String  picture = "";

  public String CreateArticle(String articleName, Integer stock, Double price, String description, String picture){ 
    String message;
    message = "<strong>Artikel erfolgreich erstellt</strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st1 = con.createStatement();  //(Noch) leerer SQL-Befehl
      st1.executeUpdate("INSERT INTO `Articles` (article_name,stock,price,description,picture) VALUES ('"+articleName+"','"+stock+"','"+price+"','"+description+"','"+picture+"');");
      st1.close();

      Statement st2 = con.createStatement();  //(Noch) leerer SQL-Befehl
      ResultSet result = st2.executeQuery("Select * From `Articles` Where `article_name` like '"+articleName+"'");
      result.next();

      this.id           = result.getInt(1);
      this.articleName  = result.getString("article_name");
      this.stock        = result.getInt(3); //stock
      this.price        = result.getDouble(4); //price
      this.description  = result.getString("description");
      this.picture      = result.getString("picture");

      st2.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    return message;
  }
  public String LoadArticle(String articleName){
    String message;
    message = "<strong>Artikel erfolgreich geladen</strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

      ResultSet result = st.executeQuery("Select * From `Articles` Where `article_name` like '"+articleName+"'");
      result.next();

      this.id           = result.getInt(1);
      this.articleName  = result.getString("article_name");
      this.stock        = result.getInt(3); //stock
      this.price        = result.getDouble(4); //price
      this.description  = result.getString("description");
      this.picture      = result.getString("picture");

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    return message;
  }

  public String LoadArticleById(Integer id){
    String message;
    message = "<strong>Artikel erfolgreich geladen</strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

      ResultSet result = st.executeQuery("Select * From `Articles` Where `ID` like '"+id+"'");
      result.next();

      this.id           = result.getInt(1);
      this.articleName  = result.getString("article_name");
      this.stock        = result.getInt(3); //stock
      this.price        = result.getDouble(4); //price
      this.description  = result.getString("description");
      this.picture      = result.getString("picture");

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    return message;
  }
  //getter Methoden
  public Integer GetId(){           return this.id; }
  public String  GetArticleName(){  return this.articleName; }
  public Integer GetStock(){        return this.stock; }
  public Double  GetPrice(){        return this.price; }
  public String  GetDescription(){  return this.description; }
  public String  GetPicture(){      return this.picture; }

  //setter Methoden
  public void SetArticleName(String articleName){ this.articleName = articleName; }
  public void SetStock(Integer stock){            this.stock       = stock; }
  public void SetPrice(Double price){             this.price       = price; }
  public void SetDescription(String description){ this.description = description; }
  public void SetPicture(String picture){         this.picture     = picture; }
}