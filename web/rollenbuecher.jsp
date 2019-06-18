<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<sql:setDataSource
        driver="oracle.jdbc.driver.OracleDriver"
        url="jdbc:oracle:thin:@localhost:1521:xe"
        user="bic4b19_04"
        password="Oht2Zee2F"
/>

<div class="container">
    <h1 class="mt-5">Rollenb&uuml;cher</h1>

    <sql:query var="rollenbuecher"
               sql="select ISBN, TITEL, THEATERSTUECK, AUTORNAME from ROLLENBUCHTYP">
    </sql:query>

    <table class="table table-striped mt-4">
        <thead>
        <tr>
            <th scope="col">ISBN</th>
            <th scope="col">Titel</th>
            <th scope="col">Theaterst&uuml;ck</th>
            <th scope="col">Autorname</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="rollenbuch" begin="0" items="${rollenbuecher.rows}">
            <tr>
                <th scope="row">${rollenbuch.ISBN}</th>
                <td>${rollenbuch.TITEL}</td>
                <td>${rollenbuch.THEATERSTUECK}</td>
                <td>${rollenbuch.AUTORNAME}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>