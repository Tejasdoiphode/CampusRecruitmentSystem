<%-- 
    Document   : addPlacementDetails
    Created on : Jun 7, 2021, 7:38:32 AM
    Author     : Acer
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>
<%
    DbManager.Dbconnection d = new DbManager.Dbconnection();

%>
<div class="row center-align">
    <h1>Applicants Details</h1>
</div>
<%    if (request.getParameter("reply_btn") != null) {
        String rstatus = request.getParameter("r_status");
        String rmessage = request.getParameter("r_msg");
        String app_id = request.getParameter("app_id");
        int s = d.replyApplicant(rstatus, rmessage, app_id);
        if (s == 1) {

            response.sendRedirect("addPlacementDetails.jsp?msg=Replied to Applicant&app_id=" + app_id + "&rstatus=" + rstatus + "&rmessage="+rmessage);
        } else {
            response.sendRedirect("addPlacementDetails.jsp?msg=Fail to Reply Applicant");
        }
    } else {
    }
    if(request.getParameter("rstatus")!=null) {
        String table = "SELECT s.email FROM tbl_student_details as s join tbl_applied as a on s.id=a.student_id where a.id=" + request.getParameter("app_id") + ";";
        ResultSet s2 = d.getResult(table);
        String msg = "Your Application Status of Recruiter is " + request.getParameter("rstatus") + "</br>" + request.getParameter("rmessage") + "<br/>Thank you.";
        if (s2.next()) {
            out.print("<script>sendEmail('" + s2.getString("email") + "','" + msg + "');</script>");
        }
    }
    if (request.getParameter("reply") != null) {
%>
<div class="card center-block">
    <form method="post" name="reply" action="addPlacementDetails.jsp">
        <div class="card-title">
            <h3>Reply <%=request.getParameter("name")%></h3>
        </div>
        <div class="card-content">
            <div class='row'>
                <div class='input-field col s12'>
                    <input type='text' id='app_id' name='app_id' readonly="true">
                    <label for='app_id'>Applicant ID</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <select id="r_status" name="r_status">
                        <option>Select Status</option>
                        <option value="yes">yes</option>
                        <option value="no">no</option>
                    </select>
                    <label for="r_status">Status</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <textarea id="r_msg" name="r_msg" class="materialize-textarea"></textarea>
                    <label for="r_msg">Message</label>
                </div>
            </div>
        </div>
        <div class="card-action">
            <div class="row">
                <div class="col s6">
                    <input type="submit" class="btn orange lighten-2" id="reply_btn" name="reply_btn" style="width:100%; font-size:20px" value="Reply">
                </div>
                <div class="col s6">
                    <a href="addPlacementDetails.jsp" class="btn red" style="width:100%; font-size:20px">Cancel ✖</a>
                </div>
            </div>
        </div>
    </form>
</div>
<%
        out.print("<script>document.getElementById('app_id').value = '" + request.getParameter("reply") + "';</script>");
        String rm = "SELECT * FROM tbl_applied WHERE id =" + request.getParameter("reply") + ";";
        ResultSet rq = d.getResult(rm);
        if (rq.next()) {
            out.print("<script>document.getElementById('r_status').value = '" + rq.getString("Status") + "';</script>");
            out.print("<script>document.getElementById('r_msg').value = '" + rq.getString("Recruiter_reply") + "';</script>");
        } else {
            response.sendRedirect("addPlacementDetails.jsp?msg=Application Not available");
        }
    }
%>
<%
    if (request.getParameter("s_id") != null) {
        String sql = "SELECT s.id as id, s.student_name as student_name, s.email as email, s.d_o_b as d_o_b, s.mobile as mobile, clg.college_name as college, c.course_name as course, sc.sem_name as current_semester, s.ssc_cgpa as ssc_cgpa, s.ssc_per as ssc_per, s.hsc_cgpa as hsc_cgpa, s.hsc_per as hsc_per, s.degree_cgpa as degree_cgpa, s.degree_per as degree_per, s.backlogs as backlogs, s.no_backlogs as no_backlogs, s.address as address FROM tbl_student_details as s join tbl_semester as sc on sc.id=s.current_semester join tbl_course as c on c.id=sc.course_id join tbl_college_details as clg on clg.id=sc.college_id where s.id =" + request.getParameter("s_id") + ";";
        ResultSet ad = d.getResult(sql);
        if (ad.next()) {
%>
<div id="applicant_details" class="card center-block">
    <div class="card-title">
        <div class="row"  style="padding-right:10px;">
            <a href="addPlacementDetails.jsp" class="btn red right">✖</a>
            <h3 class="center-align" style=" padding-top: 10px;">Applicant Details</h3>
        </div>
    </div>
    <div class="card-content">
        <table>
            <tr>
                <td>ID : <h4><%=ad.getString("id")%></h4></td>
                <td>Name: <h4><%=ad.getString("student_name")%></h4></td>
            </tr>
            <tr>
                <td>Email: <h4><%=ad.getString("email")%></h4></td>
                <td>Contact: <h4><%=ad.getString("mobile")%></h4></td>
            </tr>
            <tr>
                <td>College: <h4><%=ad.getString("college")%></h4></td>
                <td>DoB: <h4><%=ad.getString("d_o_b")%></h4></td>
            </tr>
            <tr>
                <td>Course: <h4><%=ad.getString("course")%></h4></td>
                <td>Current Semister: <h4><%=ad.getString("current_semester")%></h4></td>
            </tr>
            <tr>
                <td colspan='2'>
                    <div class='row center-align'>Academic Performance:</div>
                    <div class="row">
                        <div class="col s6">
                            SSC:<h4><%=ad.getString("ssc_cgpa") + " CGPA/ " + ad.getString("ssc_per") + "%"%></h4>
                        </div>
                        <div class="col s6">
                            HSC:<h4><%=ad.getString("hsc_cgpa") + " CGPA/ " + ad.getString("hsc_per") + "%"%></h4>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col s6">
                            Degree:<h4><%=ad.getString("degree_cgpa") + " CGPA/ " + ad.getString("degree_per") + "%"%></h4>
                        </div>
                        <div class="col s6">
                            Backlogs:<h4><%=ad.getString("no_backlogs") + " Backlogs / " + ad.getString("backlogs") + " Current Backlogs"%></h4>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan='2'>
                    Address:
                    <h4 class="center-align">
                        <%=ad.getString("address")%>
                    </h4>
                </td>
            </tr>
        </table>
    </div>
</div>
<%
        }
    }
%>
<div class="row">
    <table>
        <tr>
            <th>ID</th>
            <th>Status</th>
            <th>Recruiter Reply</th>
            <th>Applicant Name</th>
            <th>Current Academic Status</th>
            <th>Job</th>
            <th>Applicant Details</th>
        </tr>
        <%
            String table = "SELECT a.id as application_id, a.Status as Status, a.Recruiter_reply as recruiter_reply, a.student_id as student_id, std.student_name as student_name, c.course_name as course, s.sem_name as current_semister, j.job_title as job_title, j.Job_code as job_code FROM tbl_applied as a join tbl_student_details as std on std.id=a.student_id join tbl_job_vacancies as j on j.id=a.job_id inner JOIN tbl_semester as s on std.current_semester = s.id INNER join tbl_course as c on c.id = s.course_id where j.company_id='" + session.getAttribute("recruiter_id") + "';";
            ResultSet r = d.getResult(table);
            while (r.next()) {
        %>
        <tr>
            <td><%=r.getString("application_id")%></td>
            <td><%=r.getString("Status")%></td>
            <td><%=r.getString("recruiter_reply")%></td>
            <td><%=r.getString("student_name")%></td>
            <td><%=r.getString("course") + " " + r.getString("current_semister")%></td>
            <td><%=r.getString("job_title") + " (" + r.getString("job_code") + ")"%></td>
            <td class="center-align">
                <a class="btn" href="?s_id=<%=r.getString("student_id")%>">👁</a>
                <a class="btn orange lighten-2" href="?reply=<%=r.getString("application_id")%>&sid=<%=r.getString("student_id")%>&name=<%=r.getString("student_name")%>">📤</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>


<script>
    $(document).ready(function () {
        $('select').formSelect();
    });
</script>
<jsp:include page="footer.jsp"></jsp:include>
<%
    if (request.getParameter("msg") != null) {

//         out.print("<script>sendEmail('virenmistry916@gmail.com','ok');</script>");
        out.print("<script>M.toast({html: '" + request.getParameter("msg") + "', classes: 'rounded'})</script>");
    }
%>