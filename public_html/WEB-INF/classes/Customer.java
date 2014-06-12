//Das JDBC-Servlet "Customer.java"

package myclasses;

import java.io.*;
import java.sql.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.*;
import javax.servlet.http.*;

// myclasses.*;

//Hier die Klasse
public class Customer{
  Integer id = 0;
  String  firstName = "";
  String  lastName = "";
  String  password = "";
  String  country = "";
  String  city = "";
  Integer zipcode = 0;
  String  address = "";
  String  email = "";
  //Database db = new Database();

  public String CreateCustomer(String firstName, String lastName, String password, String country, String city, Integer zipcode, String address, String email){ 
      String message;
      message = "<strong>Customer erfolgreich erstellt</strong>";
      try{
        Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
      } catch (ClassNotFoundException e) {
        message = "<strong>DB-Treiber nicht da!</strong>";
      }
      try{
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
        Statement st1 = con.createStatement();  //(Noch) leerer SQL-Befehl
        st1.executeUpdate("INSERT INTO `Customers` (firstname,lastname,password,country,city,zipcode,address,email) VALUES ('"+firstName+"','"+lastName+"','"+password+"','"+country+"','"+city+"','"+zipcode+"','"+address+"','"+email+"');");
        st1.close();

        Statement st2 = con.createStatement();  //(Noch) leerer SQL-Befehl
        ResultSet result = st2.executeQuery("Select * From `Customers` Where `lastname` like '"+lastName+"' AND `password` like '"+password+"'");
        try{
          result.next();

          this.id          = result.getInt(1);
          this.firstName   = result.getString("firstname");
          this.lastName    = result.getString("lastname");
          this.password    = result.getString("password");
          this.country     = result.getString("country");
          this.city        = result.getString("city");
          this.zipcode     = result.getInt(7);
          this.address     = result.getString("address");
          this.email       = result.getString("email");
        } catch (Exception e) {
          message = message + "<strong>Result: " + result + "</strong>";
        }
        st2.close();
        con.close();
      } catch (Exception e) {
        message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
      }
    return message;
  }
  public String LoadCustomer(String email, String password){

    String message;
    message = "<strong>Customer erfolgreich geladen</strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

      ResultSet result = st.executeQuery("Select * From `Customers` Where `email` like '"+email+"' AND `password` like '"+password+"'");
      result.next();

      message = message + "<strong>Result: " + result + "</strong>";

      this.id          = result.getInt(1);
      this.firstName   = result.getString("firstname");
      this.lastName    = result.getString("lastname");
      this.password    = result.getString("password");
      this.country     = result.getString("country");
      this.city        = result.getString("city");
      this.zipcode     = result.getInt(7);
      this.address     = result.getString("address");
      this.email       = result.getString("email");

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    return message;
  }
  public String LoadCustomerById(Integer id){

    String message;
    message = "<strong>Customer erfolgreich geladen</strong>";
    try{
      Class.forName("org.gjt.mm.mysql.Driver");  //Da sind die Treiber
    } catch (ClassNotFoundException e) {
      message = "<strong>DB-Treiber nicht da!</strong>";
    }
    try{
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dx45", "dx45", "Ch4H");
      Statement st = con.createStatement();  //(Noch) leerer SQL-Befehl

      ResultSet result = st.executeQuery("Select * From `Customers` Where `ID` like '"+id+"';");
      result.next();

      message = message + "<strong>Result: " + result + "</strong>";

      this.id          = result.getInt(1);
      this.firstName   = result.getString("firstname");
      this.lastName    = result.getString("lastname");
      this.password    = result.getString("password");
      this.country     = result.getString("country");
      this.city        = result.getString("city");
      this.zipcode     = result.getInt(7);
      this.address     = result.getString("address");
      this.email       = result.getString("email");

      st.close();
      con.close();
    } catch (Exception e) {
      message = "<strong>MySQL Exception: " + e.getMessage() + "</strong>";
    }
    return message;
  }
  //getter Methoden
  public Integer GetId(){        return this.id; }
  public String  GetFirstName(){ return this.firstName; }
  public String  GetLastName(){  return this.lastName; }
  public String  GetCountry(){   return this.country; }
  public String  GetCity(){      return this.city; }
  public Integer GetZipcode(){   return this.zipcode; }
  public String  GetAddress(){   return this.address; }
  public String  GetEmail(){     return this.email; }

  //setter Methoden
  public void SetFirstName(String firstName){ this.firstName = firstName; }
  public void SetLastName(String lastName){   this.lastName  = lastName; }
  public void SetCountry(String country){     this.country   = country; }
  public void SetCity(String city){           this.city      = city; }
  public void SetZipcode(Integer zipcode){    this.zipcode   = zipcode; }
  public void SetAddress(String address){     this.address   = address; }
  public void SetEmail(String address){       this.email     = email; }
}