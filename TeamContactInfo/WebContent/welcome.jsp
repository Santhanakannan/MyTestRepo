<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<% Class.forName("oracle.jdbc.driver.OracleDriver"); %>
 
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>Welcome <%=session.getAttribute("name")%></title>  
</head>  
<body>  
    <h3>Login successful!!!</h3>  
    <h4>  
        Hello,  
        <%=session.getAttribute("name")%></h4> 
  	
  	<H1>Enter the employee id to get the team member detail...</H1>
        <FORM ACTION="welcome.jsp" METHOD="POST">
            Please enter the employeeID of the team you want to see:
            <BR>
            <INPUT TYPE="TEXT" NAME="employeeid">
            <BR>
            <INPUT TYPE="SUBMIT" value="Submit">
        </FORM>


        <H1>Fetching Team member details from database</H1>

        <% 
        String url = "jdbc:oracle:thin:@localhost:1521";  
        String dbName = "hr";  
        String userName = "mytestdb";  
        String password = "mytestdb";
        Connection conn = null;
         
        conn = DriverManager.getConnection(url + dbName, userName, password);

            Statement statement = conn.createStatement();

            String employeeid = request.getParameter("employeeid");  

            ResultSet resultset = statement.executeQuery("select * from teammembers_info where employeeid = '" + employeeid + "'") ; 

            if(!resultset.next()) {
                out.println("Sorry, could not find that team member. " + "Please try again with correct employeeID</A>.");
            } else {
        %>

        <TABLE BORDER="1">
            <TR>
               <TH>EMPLOYEEID</TH>
               <TH>EMPLOYEE NAME</TH>
               <TH>DESIGNATION</TH>
               <TH>MOBILE NUMBER</TH>
               <TH>VOIP NUMBER</TH>
           </TR>
           <TR>
               <TD> <%= resultset.getString(1) %> </TD>
               <TD> <%= resultset.getString(2) %> </TD>
               <TD> <%= resultset.getString(3) %> </TD>
               <TD> <%= resultset.getString(4) %> </TD>
               <TD> <%= resultset.getString(5) %> </TD>
           </TR>
       </TABLE>
       <BR>
       <% 
           } 
       %>
  	
</body>  
</html>