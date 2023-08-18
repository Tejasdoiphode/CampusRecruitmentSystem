<%-- 
    Document   : addJobCriteria
    Created on : Jun 7, 2021, 6:37:57 AM
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

            String jobid = request.getParameter("jobid");
            String std_ssc_cgpa=request.getParameter("std_ssc_cgpa");
            String std_ssc_per=request.getParameter("std_ssc_per");
            String std_hsc_cgpa=request.getParameter("std_hsc_cgpa");
            String std_hsc_per=request.getParameter("std_hsc_per");
            String std_d_cgpa=request.getParameter("std_degree_cgpa");
            String std_d_per=request.getParameter("std_degree_per");
            
            String backlogs=request.getParameter("std_backlogs");
            String current_backlogs=request.getParameter("std_current_backlogs");

            int s = d.addJobCriteria(jobid,std_ssc_cgpa,std_ssc_per,std_hsc_cgpa,std_hsc_per,std_d_cgpa,std_d_per,backlogs,current_backlogs);
//        out.print(s);
            if (s == 1) {
                response.sendRedirect("addJobCriteria.jsp?msg=Job Criteria Added Successfully");
            } else {
                response.sendRedirect("addJobCriteria.jsp?msg=Fail to Add Job Criteria");
            }
        } else if (request.getParameter("btn").equals("Update")) {
            String jobid = request.getParameter("jobid");
            String std_ssc_cgpa=request.getParameter("std_ssc_cgpa");
            String std_ssc_per=request.getParameter("std_ssc_per");
            String std_hsc_cgpa=request.getParameter("std_hsc_cgpa");
            String std_hsc_per=request.getParameter("std_hsc_per");
            String std_d_cgpa=request.getParameter("std_degree_cgpa");
            String std_d_per=request.getParameter("std_degree_per");
            
            String backlogs=request.getParameter("std_backlogs");
            String current_backlogs=request.getParameter("std_current_backlogs");
            
            int ed = d.executeUpdate("UPDATE tbl_eligibility_criteria SET job_id='"+jobid+"s', ssc_cgpa='"+std_ssc_cgpa+"', ssc_per='"+std_ssc_per+"', hsc_cgpa='"+std_hsc_cgpa+"', hsc_per='"+std_hsc_per+"', degree_cgpa='"+std_d_cgpa+"', degree_per='"+std_d_per+"', no_backlogs='"+backlogs+"', backlogs='"+current_backlogs+"' WHERE id=" + request.getParameter("criteriaid") + ";");
            if (ed == 1) {
                response.sendRedirect("addJobCriteria.jsp?msg=Job Criteria Updated Successfully");
            } else {
                response.sendRedirect("addJobCriteria.jsp?msg=Fail To Update Job Criteria");
            }
        }
    } else {
//        out.print("dfsdjdfsdlkfsdjfskskfsjflskfjsflsfjslfsjfjlsdfjsjdflsdjflfljfsjflsdfjsdjflsdjfjsldjfslfjsfjsfjlsjfsfsflsjfsfs");
    }
    if (request.getParameter("del") != null) {
        int del = d.executeUpdate("DELETE FROM tbl_eligibility_criteria WHERE id=" + request.getParameter("del") + ";");
        if (del == 1) {
            response.sendRedirect("addJobCriteria.jsp?msg=Job Criteria Deleted Successfully");
        } else {
            response.sendRedirect("addJobCriteria.jsp?msg=Failed To Delete Job Criteria");
        }
    } else {
//        response.sendRedirect("addJobCriteria.jsp?msg=Hello");
    }


%>
<div class="row center-align">
    <h1>Manage job criteria</h1>
</div>
<div class="row">
    <form method="post" name="jobcriteria" action="addJobCriteria.jsp">
        <div class="card">
            <div class="card-content">
                <div class='row' id="id_row" style="display:none;">
                    <div class='input-field col s12'>
                        <input type='text' id='criteriaid' name='criteriaid' readonly="true">
                        <label for='criteriaid'>Student ID</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <select id="jobid" name="jobid">
                            <option>Select Job</option>
                            <%
                                ResultSet dr = d.getResult("SELECT id, job_title, Job_code from tbl_job_vacancies where company_id=" + session.getAttribute("recruiter_id") + ";");
                                while (dr.next()) {
                            %>
                            <option value='<%=dr.getString("id")%>'><%=dr.getString("job_title") + " (" + dr.getString("Job_code")+")"%></option>
                            <%
                                }
    //                            out.print("<script>$('#semcourse').selectpicker('refresh');</script>");
                            %>
                        </select>
                        <label for="semcourse">Select Job</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6">
                        <input type="number" id="std_ssc_cgpa" name="std_ssc_cgpa">
                        <label for="std_ssc_cgpa">SSC CGPA</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="number" id="std_ssc_per" name="std_ssc_per">
                        <label for="std_ssc_per">SSC Percentage</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6">
                        <input type="number" id="std_hsc_cgpa" name="std_hsc_cgpa">
                        <label for="std_hsc_cgpa">HSC CGPA</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="number" id="std_hsc_per" name="std_hsc_per">
                        <label for="std_hsc_per">HSC Percentage</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6">
                        <input type="number" id="std_degree_cgpa" name="std_degree_cgpa">
                        <label for="std_degree_cgpa">Degree CGPA</label>
                    </div>
                    <div class="input-field col s6">
                        <input type="number" id="std_degree_per" name="std_degree_per">
                        <label for="std_degree_per">Degree Percentage</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s6">
                        <select id="std_backlogs" name="std_backlogs">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                        </select>
                        <label for="std_backlogs">Total Backlogs</label>
                    </div>
                    <div class="input-field col s6">
                        <select id="std_current_backlogs" name="std_current_backlogs">
                            <option value="0">0</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                        </select>
                        <label for="std_current_backlogs">Current Backlogs</label>
                    </div>
                </div>
            </div>
            
            <div class="card-action">
                <div class="row">
                    <div class="col s4">
                        <input type="submit" class="btn blue" id="add_student" name="btn" style="width:100%; font-size:20px" value="Add">
                    </div>
                    <div class="col s4">
                        <input type="submit" class="btn green" id="update_student" name="btn" style="width:100%; font-size:20px" value="Update">
                    </div>
                    <div class="col s4">
                        <a href="addJobCriteria.jsp" class="btn" style="width:100%; font-size:20px">Clean 🔄</a>
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
            <th>Job</th>
            <th>SSC Marks</th>
            <th>HSC Marks</th>
            <th>Degree Marks</th>
            <th>Backlogs/Current Backlogs</th>
            <th>Action</th>
        </tr>
        <%
            if (request.getParameter("edit") != null) {
                out.print("<script>document.getElementById('id_row').removeAttribute('style');</script>");
//        out.print("dfsdjdfsdlkfsdjfskskfsjflskfjsflsfjslfsjfjlsdfjsjdflsdjflfljfsjflsdfjsdjflsdjfjsldjfslfjsfjsfjlsjfsfsflsjfsfs");
                String editid = request.getParameter("edit");
                out.print("<script>document.getElementById('criteriaid').value = '" + editid + "';</script>");
                ResultSet sed = d.getResult("SELECT * FROM tbl_eligibility_criteria where id=" + editid + " ;");
                if (sed.next()) {
                    out.print("<script>document.getElementById('jobid').value = '" + sed.getString("job_id") + "';</script>");
                    out.print("<script>document.getElementById('std_ssc_cgpa').value = '" + sed.getString("ssc_cgpa") + "';</script>");
                    out.print("<script>document.getElementById('std_ssc_per').value = '" + sed.getString("ssc_per") + "';</script>");
                    out.print("<script>document.getElementById('std_hsc_cgpa').value = '" + sed.getString("hsc_cgpa") + "';</script>");
                    out.print("<script>document.getElementById('std_hsc_per').value = '" + sed.getString("hsc_per") + "';</script>");
                    out.print("<script>document.getElementById('std_degree_cgpa').value = '" + sed.getString("degree_cgpa") + "';</script>");
                    out.print("<script>document.getElementById('std_degree_per').value = '" + sed.getString("degree_per") + "';</script>");
                    out.print("<script>document.getElementById('std_backlogs').value = '" + sed.getString("backlogs") + "';</script>");
                    out.print("<script>document.getElementById('std_current_backlogs').value = '" + sed.getString("no_backlogs") + "';</script>");
                } else {
                    response.sendRedirect("addJobCriteria.jsp?msg=Job Criteria Not Available");
                }
            } else {

            }
            ResultSet r = d.getResult("SELECT e.id, j.job_title,j.Job_code, e.ssc_cgpa, e.ssc_per, e.hsc_cgpa, e.hsc_per, e.degree_cgpa, e.degree_per, e.backlogs, e.no_backlogs FROM tbl_eligibility_criteria as e join tbl_job_vacancies as j on j.id=e.job_id WHERE j.company_id = " + session.getAttribute("recruiter_id") + ";");
            while (r.next()) {
        %>
        <tr>
            <td><%=r.getString("id")%></td>
            <td><%=r.getString("job_title")+" ("+r.getString("Job_code")+")"%></td>
            <td><%=r.getString("ssc_cgpa") + " CGPA / "%><%=r.getString("ssc_per")+ "%"%></td>
            <td><%=r.getString("hsc_cgpa") + " CGPA / "%><%=r.getString("hsc_per") + "%"%></td>
            <td><%=r.getString("degree_cgpa") + "CGPA / "%><%=r.getString("degree_per") + "%"%></td>
            <td><%=r.getString("no_backlogs") + " Backlogs / "%><%=r.getString("backlogs") + " Current Backlogs"%></td>
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