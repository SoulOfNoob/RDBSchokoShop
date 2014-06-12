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
  ResultSet rs;
  List<Integer> ids = new ArrayList<Integer>();

  public String ExecuteQuery(String query){
    
    message = "<strong>Customer erfolgreich erstellt</strong>";
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
    
    message = "<strong>Customer erfolgreich erstellt</strong>";
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
        ids.add(rs.getInt(1));
      }

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    this.error = message;
    return ids;
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
        ids.add(rs.getInt(1));
      }

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    this.error = message;
    return ids;
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
          "PRIMARY KEY (`ID`),"+
          "constraint foreign key(customer_ID) references Customers(ID) on update restrict"+
        ") ENGINE=InnoDB;"
       );
       //st.executeUpdate("INSERT INTO `Bills` (customer_ID,status,price) VALUES (1,1,17.97);");

       st.executeUpdate(
        "CREATE TABLE `Orders` ("+
          "`bill_ID` int(5),"+
          "`article_ID` int(5),"+
          "`amount` int(11),"+
          "constraint foreign key(bill_ID) references Customers(ID) on update restrict,"+
          "constraint foreign key(article_ID) references Articles(ID) on update restrict"+
        ") ENGINE=InnoDB;"
       );
       //st.executeUpdate("INSERT INTO `Orders` (bill_ID,article_ID,amount) VALUES (1,1,3);");
       st.close();
       con.close();
   } catch (Exception e) {
       message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
   }
   this.error = message;
   return message;
  }
}