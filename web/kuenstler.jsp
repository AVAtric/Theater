<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<sql:setDataSource
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@localhost:1521:xe"
        user="bic4b19_04"
        password="Oht2Zee2F"
/>

<fmt:setLocale value="de_DE"/>

<div class="container">
    <h1 class="mt-5">K&uuml;nstler</h1>
    <sql:query var="personen"
               sql="select * from person natural join kuenstler">
    </sql:query>
    <table class="table table-striped mt-3">
        <thead>
        <tr>
            <th scope="col">SVNr</th>
            <th scope="col">Vorname</th>
            <th scope="col">Nachname</th>
            <th scope="col">K&uuml;nstlername</th>
            <th scope="col">Einstelldatum</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="person" begin="0" items="${personen.rows}">
            <tr>
                <th scope="row">${person.SVNr}</th>
                <td>${person.Vorname}</td>
                <td>${person.Nachname}</td>
                <td>${person.kuenstlername}</td>
                <td><fmt:formatDate type="date" value="${person.einstelldatum}"/></td>
                <td>
                    <button
                            type="button"
                            class="btn btn-primary"
                            data-toggle="modal"
                            data-target="#kuenstlerModal"
                            data-svnr="${person.SVNr}"
                            data-vorname="${person.Vorname}"
                            data-nachname="${person.Nachname}"
                            data-kuenstlername="${person.kuenstlername}">
                        <i class="fa fa-fw fa-edit"></i>
                    </button>
                    &nbsp;
                    <button type="button" class="btn btn-danger"><i class="fa fa-fw fa-trash"></i></button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="modal fade" id="kuenstlerModal" tabindex="-1" role="dialog" aria-labelledby="kuenstlerModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="kuenstlerModalLabel">New message</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="svnr" class="col-form-label">SVNr:</label>
                            <input type="text" class="form-control" id="svnr">
                        </div>
                        <div class="form-group">
                            <label for="vorname" class="col-form-label">Vorname:</label>
                            <input type="text" class="form-control" id="vorname">
                        </div>
                        <div class="form-group">
                            <label for="nachname" class="col-form-label">Nachname:</label>
                            <input type="text" class="form-control" id="nachname">
                        </div>
                        <div class="form-group">
                            <label for="kuenstlername" class="col-form-label">K&uuml;nstlername:</label>
                            <input type="text" class="form-control" id="kuenstlername">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-fw fa-window-close"></i>&nbsp;Close</button>
                    <button type="button" class="btn btn-primary"><i class="fa fa-fw fa-save"></i>&nbsp;Save</button>
                </div>
            </div>
        </div>
    </div>
</div>