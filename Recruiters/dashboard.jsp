<%-- 
    Document   : dashboard
    Created on : Jun 5, 2021, 2:46:39 PM
    Author     : Acer
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:include page="header.jsp"></jsp:include>

<%
    DbManager.Dbconnection d = new DbManager.Dbconnection();
%>
    <div class="row center-align">
        <h3><%
            Date dNow = new Date();
            SimpleDateFormat ft
                    = new SimpleDateFormat("E, dd MMM ,yyyy  '-' hh:mm a");
            out.print("<h2 align=\"center\">" + ft.format(dNow) + "</h2>");
        %></h3>
    </div>
<div class="row center-align">
    <h1><%
        ResultSet cn = d.getResult("SELECT recruiter_name,recruiter_email,address,contact FROM tbl_recruiter_details where id="+session.getAttribute("recruiter_id")+";");
        cn.next();
        out.print(cn.getString("recruiter_name"));
        %></h1>
</div>
<div class="row">
    <div class="col s6 center-align">
        <h5>Email-<br/><%=cn.getString("recruiter_email")%></h5>
    </div>
    <div class="col s6 center-align">
        <h5>Contact-<br/><%=cn.getString("contact")%></h5>
    </div>
</div>
<div class="row center-align">
    <h5>Address:-<br/><%=cn.getString("address")%></h5>
</div>
<div class="row">
    <div class="col s6 offset-s3">
        <div class="card"  style="background-color: buttonhighlight;">
            <div class="card-title center-align"><h1><%
                    ResultSet r = d.getResult("SELECT COUNT(1) as total FROM  tbl_job_vacancies where company_id="+session.getAttribute("recruiter_id")+";");
                    r.next();
                    out.print(r.getString("total"));
                    %></h1></div>
            <div class="card-content center-align"><h6>Jobs</h6></div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('select').formSelect();
    });
</script>
<jsp:include page="footer.jsp"></jsp:include>

