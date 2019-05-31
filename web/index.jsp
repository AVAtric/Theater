<!DOCTYPE html>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html class="h-100" lang="de">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Theatermanagement</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/fontawesome.min.css">
    <link rel="stylesheet" href="css/custom.css">
</head>
<body class="d-flex flex-column h-100">
<header>
    <nav class="navbar navbar-expand-md navbar-light fixed-top bg-light">
        <a class="navbar-brand" href="index.jsp">Theatermanagement</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${param.menu=='kuenstler' or param.menu=='arbeiter' ? 'active' : ''}" href="#" id="angestellteDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Angestellte
                    </a>
                    <div class="dropdown-menu" aria-labelledby="angestellteDropdown">
                        <a class="dropdown-item ${param.menu=='kuenstler' ? 'active' : ''}" href="index.jsp?menu=kuenstler">K&uuml;nstler</a>
                        <a class="dropdown-item ${param.menu=='arbeiter' ? 'active' : ''}" href="index.jsp?menu=arbeiter">B&uuml;hnenarbeiter</a>
                    </div>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle ${param.menu=='rollenbuecher' or param.menu=='auffuehrung' ? 'active' : ''}" href="#" id="theaterDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Theaterst&uuml;cke
                    </a>
                    <div class="dropdown-menu" aria-labelledby="theaterDropdown">
                        <a class="dropdown-item ${param.menu=='auffuehrung' ? 'active' : ''}" href="index.jsp?menu=auffuehrung">Auff&uuml;rungen</a>
                        <a class="dropdown-item ${param.menu=='rollenbuecher' ? 'active' : ''}" href="index.jsp?menu=rollenbuecher">Rollenb&uuml;cher</a>
                    </div>
                </li>
                <li class="nav-item ${param.menu=='besucher' ? 'active' : ''}">
                    <a class="nav-link " href="index.jsp?menu=besucher">Besucher</a>
                </li>
            </ul>
        </div>
    </nav>
</header>

<!-- Begin page content -->
<main role="main" class="flex-shrink-0">
        <c:if test="${!empty param.menu}">
            <jsp:include page="${param.menu}.jsp" />
        </c:if>
        <c:if test="${empty param.menu}">
            <jsp:include page="start.jsp" />
        </c:if>
    </div>
</main>

<footer class="footer mt-auto py-3">
    <div class="container">
        <span class="text-muted">&copy;BIC B4</span>
    </div>
</footer>

<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<c:if test="${!empty param.menu}">
    <script src="js/${param.menu}.js"></script>
</c:if>
</body>
</html>
