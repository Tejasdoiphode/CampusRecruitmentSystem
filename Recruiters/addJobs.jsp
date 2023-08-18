<%-- 
    Document   : addJobs
    Created on : Jun 7, 2021, 5:01:16 AM
    Author     : Acer
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>

<%
    DbManager.Dbconnection d = new DbManager.Dbconnection();
    if (request.getParameter("btn") != null) {
//        out.print("okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");

        if (request.getParameter("btn").equals("Add")) {
//            out.print("gk");

            String jcode = request.getParameter("jobcode");
            String jtitle = request.getParameter("jobtitle");
            String jdisc = request.getParameter("jobdisc");
            String jlocation = request.getParameter("joblocation");
            String jnoofopenings = request.getParameter("jobopenings");
            String jppyear = request.getParameter("jobyearpay");
            String jmonthly = request.getParameter("jobmonthly");
            String jlastdate = request.getParameter("joblastdt");

            int s = d.addJobs(jcode, jtitle, jdisc, jlocation, jnoofopenings, jppyear, jmonthly, jlastdate, session.getAttribute("recruiter_id").toString());
//        out.print(s);
            if (s == 1) {
                response.sendRedirect("addJobs.jsp?msg=Job Added Successfully");
            } else {
                response.sendRedirect("addJobs.jsp?msg=Fail to Add Job");
            }
        } else if (request.getParameter("btn").equals("Update")) {
            int ed = d.executeUpdate("UPDATE tbl_job_vacancies SET Job_code='"+request.getParameter("jobcode")+"', job_title='"+request.getParameter("jobtitle")+"', job_description='"+request.getParameter("jobdisc")+"', job_location='"+request.getParameter("joblocation")+"', noofopening='"+request.getParameter("jobopenings")+"', per_year_pay='"+request.getParameter("jobyearpay")+"', monthly_pay='"+request.getParameter("jobmonthly")+"', last_date='"+request.getParameter("joblastdt")+"' WHERE id=" + request.getParameter("jobid") + ";");
            if (ed == 1) {
                response.sendRedirect("addJobs.jsp?msg=Job Updated Successfully");
            } else {
                response.sendRedirect("addJobs.jsp?msg=Failed To Update Job");
            }
        }
    } else {
//        out.print("dfsdjdfsdlkfsdjfskskfsjflskfjsflsfjslfsjfjlsdfjsjdflsdjflfljfsjflsdfjsdjflsdjfjsldjfslfjsfjsfjlsjfsfsflsjfsfs");
    }
    if (request.getParameter("del") != null) {
        int del = d.executeUpdate("DELETE FROM tbl_job_vacancies WHERE id=" + request.getParameter("del") + ";");
        if (del == 1) {
            response.sendRedirect("addJobs.jsp?msg=Job Deleted Successfully");
        } else {
            response.sendRedirect("addJobs.jsp?msg=Failed To Delete Job");
        }
    } else {
//        response.sendRedirect("addJobs.jsp?msg=Hello");
    }


%>

<div class="row center-align">
    <h1>Manage Job Vaccancies</h1>
</div>
<div class="row">
    <form method="post" name="jobs" action="addJobs.jsp">
        <div class="card">
            <div class="card-content">
                <div class='row' id="id_row" style="display:none;">
                    <div class='input-field col s12'>
                        <input type='text' id='jobid' name='jobid' readonly="true">
                        <label for='jobid'>Job ID</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input type="text" id="jobcode" name="jobcode">
                        <label for="jobcode">Enter Job Code</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6">
                        <input type="text" id="jobtitle" name="jobtitle">
                        <label for="jobtitle">Enter Job Title</label>
                    </div>
                    <div class="input-field col s6">
                        <textarea type="text" id="jobdisc" name="jobdisc" class="materialize-textarea"></textarea>
                        <label for="jobdisc">Enter Job Description</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6">
                        <input type="text" id="joblocation" name="joblocation">
                        <label for="joblocation">Enter Job Location</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="number" id="jobopenings" name="jobopenings">
                        <label for="jobopenings">Enter No. of Jobs Openings</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6">
                        <input type="number" id="jobyearpay" name="jobyearpay">
                        <label for="jobyearpay">Package per Year</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="number" id="jobmonthly" name="jobmonthly">
                        <label for="jobmonthly">Monthly CTC</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <input type="date" id="joblastdt" name="joblastdt">
                        <label for="joblastdt">Last Date</label>
                    </div>
                </div>
            </div>
            <div class="card-action">
                <div class="row">
                    <div class="col s4">
                        <input type="submit" class="btn blue" id="add_job" name="btn" style="width:100%; font-size:20px" value="Add">
                    </div>
                    <div class="col s4">
                        <input type="submit" class="btn green" id="update_job" name="btn" style="width:100%; font-size:20px" value="Update">
                    </div>
                    <div class="col s4">
                        <a href="addJobs.jsp" class="btn" style="width:100%; font-size:20px">Clean 🔄</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<div class="row">
    <table class="responsive-table">
        <tr>
            <th>ID</th>
            <th>Job Code</th>
            <th>Title</th>
            <th>Description</th>
            <th>Location</th>
            <th>No. of Openings</th>
            <th>Package per Year</th>
            <th>Monthly CTC</th>
            <th>Posted on</th>
            <th>Last Date</th>
            <th>Action</th>
        </tr>
        <%
            if (request.getParameter("edit") != null) {
                out.print("<script>document.getElementById('id_row').removeAttribute('style');</script>");
//        out.print("dfsdjdfsdlkfsdjfskskfsjflskfjsflsfjslfsjfjlsdfjsjdflsdjflfljfsjflsdfjsdjflsdjfjsldjfslfjsfjsfjlsjfsfsflsjfsfs");
                String editid = request.getParameter("edit");
                out.print("<script>document.getElementById('jobid').value = '" + editid + "';</script>");
                ResultSet sed = d.getResult("SELECT * FROM tbl_job_vacancies where id=" + editid + " ;");
                if (sed.next()) {
                    out.print("<script>document.getElementById('jobcode').value = '" + sed.getString("Job_code") + "';</script>");
                    out.print("<script>document.getElementById('jobtitle').value = '" + sed.getString("job_title") + "';</script>");
                    out.print("<script>document.getElementById('jobdisc').value = '" + sed.getString("job_description") + "';</script>");
                    out.print("<script>document.getElementById('joblocation').value = '" + sed.getString("job_location") + "';</script>");
                    out.print("<script>document.getElementById('jobyearpay').value = '" + sed.getString("per_year_pay") + "';</script>");
                    out.print("<script>document.getElementById('jobmonthly').value = '" + sed.getString("monthly_pay") + "';</script>");
                    out.print("<script>document.getElementById('joblastdt').value = '" + sed.getString("last_date") + "';</script>");
                    out.print("<script>document.getElementById('jobopenings').value = '" + sed.getString("noofopening") + "';</script>");
                } else {
                    response.sendRedirect("addJobs.jsp?msg=Job Not Available");
                }
            } else {

            }
            String sql="SELECT * from tbl_job_vacancies WHERE company_id='" + session.getAttribute("recruiter_id") + "';";
            ResultSet r = d.getResult(sql);
            while (r.next()) {
        %>
        <tr>
            <td><%=r.getString("id")%></td>
            <td><%=r.getString("Job_code")%></td>
            <td><%=r.getString("job_title")%></td>
            <td><%=r.getString("job_description")%></td>
            <td><%=r.getString("job_location")%></td>
            <td><%=r.getString("noofopening")%></td>
            <td><%=r.getString("per_year_pay")%></td>
            <td><%=r.getString("monthly_pay")%></td>
            <td><%=r.getString("posted_on")%></td>
            <td><%=r.getString("last_date")%></td>
            <td>
                <a class="btn green" href="?edit=<%=r.getString("id")%>">✏</a>
                <a class="btn red" href="?del=<%=r.getString("id")%>">✖</a>
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
        out.print("<script>M.toast({html: '" + request.getParameter("msg") + "', classes: 'rounded'})</script>");
    }
%>