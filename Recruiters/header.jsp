<%-- 
    Document   : header
    Created on : Apr 19, 2021, 11:10:43 AM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  import="DbManager.Dbconnection.*" %>
<!DOCTYPE html>
<html>
    <head>
        
<!--        <script type="text/javascript" src="../js/jquery.js"></script>-->
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="../css/materialize.min.css"  media="screen,projection"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <script type="text/javascript" src="../js/jquery.min.js"></script>
        <script type="text/javascript" src="../js/materialize.min.js"></script>
        <script src="https://smtpjs.com/v3/smtp.js"></script> 
        <title>Job Placement Cell</title>
        <script>
            function sendEmail(email_to,msg) {
                
                Email.send({ 
                    Host: "smtp.elasticemail.com", 
                    Username: "virenmistry512@gmail.com", 
                    Password: "C33B72227D8775A9C4C658E6542C7C3F62ED", 
                    To: email_to, 
                    From: "virenmistry512@gmail.com", 
                    Subject: "Recruiter Response", 
                    Body: msg, 
                }) 
                .then(function (message) { 
//                    alert("mail send successfully OTP is send to provided email id verify it"+message)

                }); 
            }
        </script>
            
    </head>
    <body>
        <%
            //session.setAttribute("email", "tcsmumbai@gmail.com");
           // session.setAttribute("recruiter_id", "1");
        %>
        <div class="container">
            <div class="row">
                <div class="col s2">
                    
                
        <ul class="sidenav sidenav-fixed">
            <li class="center-align">
                <img class="circle" src="../img/user.png" width="100%" >
                <h5>Recruiter Panel</h5>
                <h5><%out.print(session.getAttribute("email"));%></h5>
                 <a class="btn red" href="../Home/logout.jsp">Logout</a>
            </li>
            <li class="bold"><a href="dashboard.jsp">Dashboard</a></li>
            <li class="bold"><a href="addJobs.jsp">Manage Jobs</a></li>
            <li class="bold"><a href="addJobCriteria.jsp">Manage Jobs Criteria</a></li>
            <li class="bold"><a href="addPlacementDetails.jsp">Manage Placement Details</a></li>
        </ul>
                </div>
                <div class="col s10">


    
