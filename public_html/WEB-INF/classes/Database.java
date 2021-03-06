//Das JDBC-Servlet "Database.java"

package myclasses;

import java.io.*;
import java.util.*;
import java.sql.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.*;
import javax.servlet.http.*;

//Hier die Klasse
public class Database{

  String error = "";
  String message = "";
  String table = "";
  ResultSet rs;
  List<Integer> ids1 = new ArrayList<Integer>();
  List<Integer> ids2 = new ArrayList<Integer>();

  public String ExecuteQuery(String query){
    message = "<strong>Query erfolgreich ausgefuehrt</strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

      st.executeUpdate(query);

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    this.error = message;
    return message;
  }

  public ResultSet GetResults(String query){
    message = "<strong>Request erfolgreich ausgefuehrt</strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

      rs = st.executeQuery(query);

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    this.error = message;
    return rs;
  }

  public List GetCustomerIds(){
    message = "<strong>Customer erfolgreich erstellt</strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

      rs = st.executeQuery("Select `ID` FROM `Customers`");

      while(rs.next()){
        ids1.add(rs.getInt(1));
      }

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    this.error = message;
    return ids1;
  }

  public List GetArticleIds(){
    message = "<strong>Customer erfolgreich erstellt</strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

      rs = st.executeQuery("Select `ID` FROM `Articles`");

      while(rs.next()){
        ids2.add(rs.getInt(1));
      }

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    this.error = message;
    return ids2;
  }

  public String GetOrders(Integer customer_ID){
    message = "<strong> </strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

      rs = st.executeQuery("SELECT * FROM `Bills` WHERE `customer_ID` = "+customer_ID+";");

      while(rs.next()){
        String articles[] = rs.getString("articles").split(";");
        String articleString = "";
        for(int i = 0;i<articles.length;i++){
          articleString = articleString + articles[i] + "<br />";
        }
        table = table + "<tr><td>"+rs.getInt(1)+"</td><td>"+rs.getString("date")+"</td><td>"+rs.getInt(4)+"</td><td>"+rs.getDouble(5)+" &euro;</td><td>"+articleString+"</td></tr>";
      }

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    this.error = message;

    

    return table;
  }

  public String CreateTables(){
    message = "<strong>Tabellen erfolgreich eingerichtet</strong>";
    //DB-Treiber einbinden
    try{
        Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
        message = "<strong>DB-Treiber nicht da!</strong>";
    }
    // Connection zum DB-Server eroeffnen
    try{
       Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");

       //Jetzt einen SQL-Befehl vorbereiten
       Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl
       try{
           st.executeUpdate("DROP TABLE IF EXISTS `Orders`;");
           st.executeUpdate("DROP TABLE IF EXISTS `Bills`;");
           st.executeUpdate("DROP TABLE IF EXISTS `Articles`;");
           st.executeUpdate("DROP TABLE IF EXISTS `Customers`;");
       } catch (Exception e) {
           message = "<strong>Problem mit: DROP TABLE</strong>";
       }
       // Jetzt normales SQL-Skript, aber innerhalb des Servlets

       st.executeUpdate(
        "CREATE TABLE `Customers` ("+
          "`ID` int(5) AUTO_INCREMENT,"+
          "`password` varchar(100),"+
          "`firstname` varchar(100),"+
          "`lastname` varchar(100),"+
          "`country` varchar(100),"+
          "`city` varchar(100),"+
          "`zipcode` int(11),"+
          "`address` varchar(100),"+
          "`email` varchar(100),"+
          "PRIMARY KEY (`ID`)"+
        ") ENGINE=InnoDB;"
       );
       //st.executeUpdate("INSERT INTO `Customers` (password,firstname,lastname,country,city,zipcode,address) VALUES ('password','Jan','Ryklikas','Deutschland','Hamburg',22459,'meinestrasse11');");

       st.executeUpdate(
        "CREATE TABLE `Articles` ("+
          "`ID` int(5) AUTO_INCREMENT,"+
          "`article_name` varchar(100),"+
          "`stock` int(11),"+
          "`price` double,"+
          "`description` text,"+
          "`picture` varchar(100),"+
          "PRIMARY KEY (`ID`)"+
        ") ENGINE=InnoDB;"
       );
       //st.executeUpdate("INSERT INTO `Articles` (article_name,stock,price,description,picture) VALUES ('Schokolade',50,5.99,'Leckere Schokolade aus natuerlichem Anbau','Pfad');");

       st.executeUpdate(
        "CREATE TABLE `Bills` ("+
          "`ID` int(5) AUTO_INCREMENT,"+
          "`customer_ID` int(5),"+
          "`date` timestamp DEFAULT CURRENT_TIMESTAMP,"+
          "`status` int(1),"+
          "`price` double,"+
          "`articles` text,"+
          "PRIMARY KEY (`ID`),"+
          "constraint foreign key(customer_ID) references Customers(ID) on update restrict"+
        ") ENGINE=InnoDB;"
       );
       //st.executeUpdate("INSERT INTO `Bills` (customer_ID,status,price) VALUES (1,1,17.97);");

       st.close();
       con.close();
   } catch (Exception e) {
       message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
   }
   this.error = message;
   return message;
  }
  public String GetError(){
    return this.error;
  }
}