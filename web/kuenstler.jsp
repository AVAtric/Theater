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

    <c:if test="${!empty param.updateKuenstler}">
        <sql:update var="updateKuenstler"
                    sql="UPDATE PERSON SET Vorname = ?, Nachname = ? WHERE SVNr = ?">
            <sql:param value="${param.vorname}" />
            <sql:param value="${param.nachname}" />
            <sql:param value="${param.svnr}" />
        </sql:update>

        <sql:update var="updateKuenstlerDetail"
                    sql="UPDATE KUENSTLER SET Kuenstlername = ? WHERE SVNr = ?">
            <sql:param value="${param.kuenstlername}" />
            <sql:param value="${param.svnr}" />
        </sql:update>

        <c:if test="${updateKuenstler == 1 && updateKuenstlerDetail == 1}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Daten des K&uuml;stlers wurden erfolgreich aktualisiert!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <c:if test="${updateKuenstler != 1 && updateKuenstlerDetail != 1}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Es ist ein Fehler beim speichern aufgetretten!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
    </c:if>

    <c:if test="${!empty param.deleteKuenstler}">
        <sql:update var="deleteKuenstlerDetail1"
                    sql="DELETE FROM KOMMT_NICH_AUS WHERE K1_KUENSTLERNAME = ? OR K2_KUENSTLERNAME = ?">
            <sql:param value="${param.svnrDel}" />
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteKuenstlerDetail2"
                    sql="DELETE FROM KUENSTLER_SPIELT_AUFFUEHRUNG WHERE K_SVNR = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteKuenstlerDetail3"
                    sql="DELETE FROM KUENSTLER_KANN_SPIELEN WHERE KUENSTLERSVNR = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteKuenstlerDetail4"
                    sql="DELETE FROM PERSON_WOHNT_ADRESSE WHERE SVNR = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteKuenstlerDetail5"
                    sql="DELETE FROM PERSON_ERREICHBAR_TEL WHERE SVNR = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteKuenstlerDetail6"
                    sql="DELETE FROM KUENSTLER WHERE SVNr = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteKuenstlerDetail7"
                    sql="DELETE FROM ANGESTELLTER WHERE SVNr = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteKuenstler"
                    sql="DELETE FROM PERSON WHERE SVNr = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <c:if test="${deleteKuenstler == 1 && deleteKuenstlerDetail7 == 1}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Daten des K&uuml;stlers wurden erfolgreich gel&ouml;scht!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <c:if test="${deleteKuenstler != 1 && deleteKuenstlerDetail7 != 1}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Es ist ein Fehler beim l&ouml;schen aufgetretten!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
    </c:if>

    <sql:query var="personen"
               sql="select * from person natural join kuenstler">
    </sql:query>

    <table class="table table-striped mt-4">
        <thead>
        <tr>
            <th scope="col">SVNr</th>
            <th scope="col">Vorname</th>
            <th scope="col">Nachname</th>
            <th scope="col">K&uuml;nstlername</th>
            <th scope="col">Einstelldatum</th>
            <th scope="col">
                <button
                    type="button"
                    class="btn btn-success">
                <i class="fa fa-fw fa-plus"></i>&nbsp;Neu
                </button>
            </th>
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
                    <button
                            type="button"
                            class="btn btn-danger"
                            data-toggle="modal"
                            data-target="#deleteModal"
                            data-svnr="${person.SVNr}"
                            data-vorname="${person.Vorname}"
                            data-nachname="${person.Nachname}">
                        <i class="fa fa-fw fa-trash"></i>
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="modal fade" id="kuenstlerModal" tabindex="-1" role="dialog" aria-labelledby="kuenstlerModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="kuenstlerModalLabel">Edit kuenstler</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="kuenstlerEditForm" action="index.jsp" method="post">
                        <input type="hidden" name="svnr" id="svnr">
                        <input type="hidden" name="updateKuenstler" value="1">
                        <input type="hidden" name="menu" value="kuenstler">
                        <div class="form-group">
                            <label for="vorname" class="col-form-label">Vorname:</label>
                            <input type="text" class="form-control" id="vorname" name="vorname">
                        </div>
                        <div class="form-group">
                            <label for="nachname" class="col-form-label">Nachname:</label>
                            <input type="text" class="form-control" id="nachname" name="nachname">
                        </div>
                        <div class="form-group">
                            <label for="kuenstlername" class="col-form-label">K&uuml;nstlername:</label>
                            <input type="text" class="form-control" id="kuenstlername" name="kuenstlername">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="submitEditKuenstler">Speichern</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Schlie&szlig;en</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Delete</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Wollen Sie diesen K&uuml;nstler wirklich l&ouml;schen?</p>
                    <form id="kuenstlerDeleteForm" action="index.jsp" method="post">
                        <input type="hidden" name="svnrDel" id="svnrDel">
                        <input type="hidden" name="deleteKuenstler" value="1">
                        <input type="hidden" name="menu" value="kuenstler">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="submitDeleteKuenstler">L&ouml;schen</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Schlie&szlig;en</button>
                </div>
            </div>
        </div>
    </div>
</div>