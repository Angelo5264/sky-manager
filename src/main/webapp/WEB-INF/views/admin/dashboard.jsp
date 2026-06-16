<%-- 
    Document   : dashboard
    Created on : 12 may 2026, 12:59:45
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Panel de Administracion</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .sidebar { min-height: 100vh; background: #2c3e50; }
        .sidebar .nav-link { color: #bdc3c7; padding: 1rem 1.5rem; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: #34495e; color: white; }
        .stat-card { border: none; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .chart-container {
            height: 300px;
            background: #f8f9fa;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/flights">
                        <i class="bi bi-airplane"></i> Gestion de Vuelos
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
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
                <h3 class="mb-4"><i class="bi bi-speedometer2"></i> Dashboard</h3>
                
                <div class="row mb-4">
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card">
                            <div class="card-body d-flex align-items-center">
                                <div class="stat-icon bg-primary bg-opacity-10 text-primary me-3 rounded p-3">
                                    <i class="bi bi-airplane fs-4"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-0">Vuelos Activos</h6>
                                    <h3 class="mb-0">${totalFlights}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card">
                            <div class="card-body d-flex align-items-center">
                                <div class="stat-icon bg-success bg-opacity-10 text-success me-3 rounded p-3">
                                    <i class="bi bi-ticket-perforated fs-4"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-0">Reservas</h6>
                                    <h3 class="mb-0">${totalBookings}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card">
                            <div class="card-body d-flex align-items-center">                                
                                <div class="stat-icon bg-info bg-opacity-10 text-info me-3 rounded p-3">
                                    <i class="bi bi-people fs-4"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-0">Usuarios</h6>
                                    <h3 class="mb-0">${totalUsers}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="card stat-card">
                            <div class="card-body d-flex align-items-center">
                                <div class="stat-icon bg-warning bg-opacity-10 text-warning me-3 rounded p-3">
                                    <i class="bi bi-currency-dollar fs-4"></i>
                                </div>
                                <div>
                                    <h6 class="text-muted mb-0">Ingresos</h6>
                                    <h3 class="mb-0">$${totalRevenue}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0"><i class="bi bi-clock-history"></i> Reservas Recientes</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Codigo</th>
                                        <th>Pasajero</th>
                                        <th>Vuelo</th>
                                        <th>Ruta</th>
                                        <th>Fecha</th>
                                        <th>Estado</th>
                                        <th>Monto</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${recentBookings}" var="booking" varStatus="loop">
                                        <c:if test="${loop.index < 5}">
                                            <tr>
                                                <td><span class="badge bg-secondary">${booking.codigoConfirmacion}</span></td>
                                                <td>${booking.pasajeroNombre}</td>
                                                <td>${booking.numeroVuelo}</td>
                                                <td>${booking.origenCiudad} → ${booking.destinoCiudad}</td>
                                                <td>${booking.fechaReserva.toLocalDate()}</td>
                                                <td>
                                                    <span class="badge bg-${booking.estadoReserva == 'CONFIRMADA' ? 'success' : 'danger'}">
                                                        ${booking.estadoReserva}
                                                    </span>
                                                </td>
                                                <td>$${booking.precioFinal}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h6 class="mb-0">Ocupacion por Ruta</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <p class="text-muted">Grafico de ocupacion (requiere libreria de charts)</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h6 class="mb-0">Ingresos Mensuales</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <p class="text-muted">Grafico de ingresos (requiere libreria de charts)</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
