<%-- 
    Document   : error
    Created on : 12 may 2026, 13:01:20
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        }
        .error-container {
            text-align: center;
            color: white;
        }
        .error-code {
            font-size: 8rem;
            font-weight: 700;
            opacity: 0.3;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-container">
            <div class="error-code">
                <c:choose>
                    <c:when test="${pageContext.errorData.statusCode == 404}">404</c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">500</c:when>
                    <c:otherwise>!</c:otherwise>
                </c:choose>
            </div>
            <h2 class="mb-3">
                <c:choose>
                    <c:when test="${pageContext.errorData.statusCode == 404}">Pagina no encontrada</c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">Error del servidor</c:when>
                    <c:otherwise>Ha ocurrido un error</c:otherwise>
                </c:choose>
            </h2>
            <p class="lead mb-4">
                <c:choose>
                    <c:when test="${pageContext.errorData.statusCode == 404}">La pagina que buscas no existe o ha sido movida.</c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">Ha ocurrido un error interno. Por favor intenta mas tarde.</c:when>
                    <c:otherwise>Algo salio mal. Por favor intenta nuevamente.</c:otherwise>
                </c:choose>
            </p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-light btn-lg">
                <i class="bi bi-house"></i> Volver al Inicio
            </a>
        </div>
    </div>
</body>
</html>
