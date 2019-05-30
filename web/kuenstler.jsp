<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<sql:setDataSource
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@localhost:1521:xe"
        user="bicb19_04"
        password="Oht2Zee2F"
/>
<div class="container">
<h1 class="mt-5">Fahrten</h1>
<sql:query var="personen"
           sql="select * from person" >
    </sql:query>
<table class="table table-striped">
    <thead>
    <tr>
        <th scope="col">SVNr</th>
        <th scope="col">Vorname</th>
        <th scope="col">Nachname</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="person" begin="0" items="${personen.rows}">
    <tr>
        <th scope="row">{person.SVNr}</th>
        <td>{person.Vorname}</td>
        <td>{person.Nachname}</td>
    </tr>
    </c:forEach>
    </tbody>
</table>