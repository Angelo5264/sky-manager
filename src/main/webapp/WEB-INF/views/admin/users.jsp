<%-- 
    Document   : users
    Created on : 12 may 2026, 13:00:38
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Gestion de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .sidebar { min-height: 100vh; background: #2c3e50; }
        .sidebar .nav-link { color: #bdc3c7; padding: 1rem 1.5rem; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: #34495e; color: white; }
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-3 col-lg-2 sidebar p-0">
                <div class="p-4 text-white text-center">
                    <h4>✈️ SkyManager</h4>
                    <small>Panel Admin</small>
                </div>
                <nav class="nav flex-column">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/flights">
                        <i class="bi bi-airplane"></i> Gestion de Vuelos
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
                        <i class="bi bi-people"></i> Usuarios
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">
                        <i class="bi bi-graph-up"></i> Reportes
                    </a>
                    <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                        <i class="bi bi-box-arrow-left"></i> Cerrar Sesion
                    </a>
                </nav>
            </div>

            <div class="col-md-9 col-lg-10 p-4">
                <h3 class="mb-4"><i class="bi bi-people"></i> Gestion de Usuarios</h3>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Lista de Usuarios</h5>
                        <span class="badge bg-primary">${users.size()} usuarios</span>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Usuario</th>
                                    <th>Email</th>
                                    <th>Rol</th>
                                    <th>Fecha Registro</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${users}" var="u">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar me-3">${u.nombre.charAt(0)}${u.apellido.charAt(0)}</div>
                                                <div>
                                                    <strong>${u.nombreCompleto}</strong>
                                                </div>
                                            </div>
                                        </td>
                                        <td>${u.email}</td>
                                        <td>
                                            <span class="badge bg-${u.rol == 'ADMINISTRADOR' ? 'danger' : 'info'}">
                                                ${u.rol}
                                            </span>
                                        </td>
                                        <td>${u.fechaRegistro.toLocalDate()}</td>
                                        <td>
                                            <span class="badge bg-${u.estado == 'ACTIVO' ? 'success' : 'secondary'}">
                                                ${u.estado}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <form action="${pageContext.request.contextPath}/admin/users/toggle" method="post" class="d-inline">
                                                    <input type="hidden" name="id" value="${u.idUsuario}">
                                                    <button type="submit" class="btn btn-outline-${u.estado == 'ACTIVO' ? 'warning' : 'success'}">
                                                        <i class="bi bi-${u.estado == 'ACTIVO' ? 'pause' : 'play'}-circle"></i>
                                                    </button>
                                                </form>
                                                <c:if test="${u.idUsuario != user.idUsuario}">
                                                    <form action="${pageContext.request.contextPath}/admin/users/delete" method="post" class="d-inline">
                                                        <input type="hidden" name="id" value="${u.idUsuario}">
                                                        <button type="submit" class="btn btn-outline-danger" 
                                                                onclick="return confirm('¿Eliminar este usuario?')">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
