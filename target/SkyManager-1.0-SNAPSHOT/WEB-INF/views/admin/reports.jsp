<%-- 
    Document   : reports
    Created on : 12 may 2026, 13:00:58
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Reportes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .sidebar { min-height: 100vh; background: #2c3e50; }
        .sidebar .nav-link { color: #bdc3c7; padding: 1rem 1.5rem; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: #34495e; color: white; }
        .report-card { border: none; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .chart-placeholder {
            height: 250px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                        <i class="bi bi-people"></i> Usuarios
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/reports">
                        <i class="bi bi-graph-up"></i> Reportes
                    </a>
                    <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                        <i class="bi bi-box-arrow-left"></i> Cerrar Sesion
                    </a>
                </nav>
            </div>

            <div class="col-md-9 col-lg-10 p-4">
                <h3 class="mb-4"><i class="bi bi-graph-up"></i> Reportes y Estadisticas</h3>

                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <div class="card report-card">
                            <div class="card-body">
                                <h6 class="text-muted">Ocupacion Promedio</h6>
                                <h2 class="text-primary">78%</h2>
                                <small class="text-success"><i class="bi bi-arrow-up"></i> 5% vs mes anterior</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card report-card">
                            <div class="card-body">
                                <h6 class="text-muted">Tasa de Cancelacion</h6>
                                <h2 class="text-danger">4.2%</h2>
                                <small class="text-success"><i class="bi bi-arrow-down"></i> 1.3% vs mes anterior</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card report-card">
                            <div class="card-body">
                                <h6 class="text-muted">Ingreso Promedio/Vuelo</h6>
                                <h2 class="text-success">$12,450</h2>
                                <small class="text-success"><i class="bi bi-arrow-up"></i> 8% vs mes anterior</small>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="card report-card">
                            <div class="card-header bg-white">
                                <h6 class="mb-0">Reservas por Mes</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-placeholder">
                                    <div class="text-center">
                                        <i class="bi bi-bar-chart fs-1"></i>
                                        <p>Grafico de reservas mensuales</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="card report-card">
                            <div class="card-header bg-white">
                                <h6 class="mb-0">Rutas Mas Populares</h6>
                            </div>
                            <div class="card-body">
                                <div class="chart-placeholder">
                                    <div class="text-center">
                                        <i class="bi bi-pie-chart fs-1"></i>
                                        <p>Grafico de rutas populares</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card report-card">
                    <div class="card-header bg-white">
                        <h6 class="mb-0">Reporte de Ocupacion por Vuelo</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                    <tr>
                                        <th>Vuelo</th>
                                        <th>Ruta</th>
                                        <th>Fecha</th>
                                        <th>Capacidad</th>
                                        <th>Ocupados</th>
                                        <th>% Ocupacion</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${flights}" var="flight">
                                        <tr>
                                            <td>${flight.numeroVuelo}</td>
                                            <td>${flight.origenCiudad} → ${flight.destinoCiudad}</td>
                                            <td>${flight.fechaSalida.toLocalDate()}</td>
                                            <td>${flight.capacidadTotal}</td>
                                            <td>${flight.capacidadTotal - flight.asientosDisponibles}</td>
                                            <td>
                                                <div class="progress" style="height: 20px;">
                                                    <c:set var="pct" value="${(flight.capacidadTotal - flight.asientosDisponibles) * 100 / flight.capacidadTotal}" />
                                                    <div class="progress-bar bg-${pct > 80 ? 'success' : pct > 50 ? 'warning' : 'danger'}" 
                                                         style="width: ${pct}%">${pct}%</div>
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
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
