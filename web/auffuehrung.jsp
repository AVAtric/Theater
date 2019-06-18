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
    <h1 class="mt-5">Auff&uuml;rungen</h1>

    <sql:query var="auffuehrungen"
               sql="select * from AUFFUEHRUNG">
    </sql:query>

    <table class="table table-striped mt-4">
        <thead>
        <tr>
            <th scope="col">Termin</th>
            <th scope="col">Regisseur</th>
            <th scope="col">Budget (&euro;)</th>
            <th scope="col">Name</th>
            <th scope="col">Sprache</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="auffuehrung" begin="0" items="${auffuehrungen.rows}">
            <tr>
                <td><fmt:formatDate type="date" value="${auffuehrung.DATUMUHRZEIT}"/></td>
                <td>${auffuehrung.REGISSEUR}</td>
                <td>${auffuehrung.BUDGET}</td>
                <td>${auffuehrung.NAME}</td>
                <td>${auffuehrung.SPRACHE}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>