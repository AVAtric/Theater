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
    <h1 class="mt-5">B&uuml;hnenarbeiter</h1>

    <c:if test="${!empty param.insertArbeiter}">
        <sql:update var="insertArbeiter"
                    sql="INSERT INTO PERSON VALUES (?, ?, ?)">
            <sql:param value="${param.svnrIns}" />
            <sql:param value="${param.vornameIns}" />
            <sql:param value="${param.nachnameIns}" />
        </sql:update>

        <sql:query var="angestellte"
                   sql="select ANGESTELLTENNUMMER + 1 ang_num  from angestellter WHERE ROWNUM = 1 order by ANGESTELLTENNUMMER desc">
        </sql:query>

        <sql:update var="insertArbeiterDetail"
                    sql="INSERT INTO ANGESTELLTER VALUES (?, ?, ?, ?, ?)">
            <sql:param value="${param.svnrIns}" />
            <sql:param value="${angestellte.rows[0].ang_num}" />
            <sql:param value="${param.kontonummerIns}" />
            <sql:param value="${param.kontostandIns}" />
            <sql:param value="${param.blzIns}" />
        </sql:update>

        <sql:update var="insertArbeiterDetail1"
                    sql="INSERT INTO BUEHNENARBEITER VALUES (?)">
            <sql:param value="${param.svnrIns}" />
        </sql:update>

        <c:if test="${insertArbeiter == 1 && insertArbeiterDetail == 1}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Daten des B&uuml;hnenarbeiter wurden erfolgreich gespeichert!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <c:if test="${insertArbeiter != 1 && insertArbeiterDetail != 1}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Es ist ein Fehler beim speichern aufgetretten!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
    </c:if>

    <c:if test="${!empty param.updateArbeiter}">
        <sql:update var="updateArbeiter"
                    sql="UPDATE PERSON SET Vorname = ?, Nachname = ? WHERE SVNr = ?">
            <sql:param value="${param.vorname}" />
            <sql:param value="${param.nachname}" />
            <sql:param value="${param.svnr}" />
        </sql:update>

        <c:if test="${updateArbeiter == 1}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Daten des B&uuml;hnenarbeiter wurden erfolgreich aktualisiert!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <c:if test="${updateArbeiter != 1}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Es ist ein Fehler beim speichern aufgetretten!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
    </c:if>

    <c:if test="${!empty param.deleteArbeiter}">
        <sql:update var="deleteArbeiterDetail3"
                    sql="DELETE FROM PERSON_WOHNT_ADRESSE WHERE SVNR = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteArbeiterDetail2"
                    sql="DELETE FROM PERSON_ERREICHBAR_TEL WHERE SVNR = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteArbeiterDetail1"
                    sql="DELETE FROM BUEHNENARBEITER WHERE SVNr = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteArbeiterDetail"
                    sql="DELETE FROM ANGESTELLTER WHERE SVNr = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <sql:update var="deleteArbeiter"
                    sql="DELETE FROM PERSON WHERE SVNr = ?">
            <sql:param value="${param.svnrDel}" />
        </sql:update>

        <c:if test="${deleteArbeiter == 1 && deleteArbeiterDetail == 1}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Daten des B&uuml;hnenarbeiter wurden erfolgreich gel&ouml;scht!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <c:if test="${deleteArbeiter != 1 && deleteArbeiterDetail != 1}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Es ist ein Fehler beim l&ouml;schen aufgetretten!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
    </c:if>

    <sql:query var="personen"
               sql="select * from person natural join BUEHNENARBEITER">
    </sql:query>

    <table class="table table-striped mt-4">
        <thead>
        <tr>
            <th scope="col">SVNr</th>
            <th scope="col">Vorname</th>
            <th scope="col">Nachname</th>
            <th scope="col">
                <button
                    type="button"
                    data-toggle="modal"
                    data-target="#arbeiterInsertModal"
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
                <td>
                    <button
                            type="button"
                            class="btn btn-primary"
                            data-toggle="modal"
                            data-target="#arbeiterModal"
                            data-svnr="${person.SVNr}"
                            data-vorname="${person.Vorname}"
                            data-nachname="${person.Nachname}">
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

    <div class="modal fade" id="arbeiterModal" tabindex="-1" role="dialog" aria-labelledby="arbeiterModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="arbeiterModalLabel">Edit arbeiter</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="arbeiterEditForm" action="index.jsp" method="post">
                        <input type="hidden" name="svnr" id="svnr">
                        <input type="hidden" name="updateArbeiter" value="1">
                        <input type="hidden" name="menu" value="arbeiter">
                        <div class="form-group">
                            <label for="vorname" class="col-form-label">Vorname:</label>
                            <input type="text" class="form-control" id="vorname" name="vorname">
                        </div>
                        <div class="form-group">
                            <label for="nachname" class="col-form-label">Nachname:</label>
                            <input type="text" class="form-control" id="nachname" name="nachname">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="submitEditArbeiter">Speichern</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Schlie&szlig;en</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="arbeiterInsertModal" tabindex="-1" role="dialog" aria-labelledby="arbeiterInsertModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="arbeiterInsertModalLabel">B&uuml;hnenarbeiter erstellen</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="arbeiterInsertForm" action="index.jsp" method="post">
                        <input type="hidden" name="insertArbeiter" value="1">
                        <input type="hidden" name="menu" value="arbeiter">
                        <div class="form-group">
                            <label for="svnrIns" class="col-form-label">Sozialversicherungsnummer:</label>
                            <input type="text" class="form-control" id="svnrIns" name="svnrIns">
                        </div>
                        <div class="form-group">
                            <label for="vornameIns" class="col-form-label">Vorname:</label>
                            <input type="text" class="form-control" id="vornameIns" name="vornameIns">
                        </div>
                        <div class="form-group">
                            <label for="nachnameIns" class="col-form-label">Nachname:</label>
                            <input type="text" class="form-control" id="nachnameIns" name="nachnameIns">
                        </div>
                        <div class="form-group">
                            <label for="kontonummerIns" class="col-form-label">Kontonummer:</label>
                            <input type="text" class="form-control" id="kontonummerIns" name="kontonummerIns">
                        </div>
                        <div class="form-group">
                            <label for="kontostandIns" class="col-form-label">Kontostand:</label>
                            <input type="text" class="form-control" id="kontostandIns" name="kontostandIns">
                        </div>
                        <div class="form-group">
                            <label for="blzIns" class="col-form-label">BLZ:</label>
                            <input type="text" class="form-control" id="blzIns" name="blzIns">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="submitInsertArbeiter">Speichern</button>
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
                    <p>Wollen Sie diesen B&uuml;hnenarbeiter wirklich l&ouml;schen?</p>
                    <form id="arbeiterDeleteForm" action="index.jsp" method="post">
                        <input type="hidden" name="svnrDel" id="svnrDel">
                        <input type="hidden" name="deleteArbeiter" value="1">
                        <input type="hidden" name="menu" value="arbeiter">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="submitDeleteArbeiter">L&ouml;schen</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Schlie&szlig;en</button>
                </div>
            </div>
        </div>
    </div>
</div>