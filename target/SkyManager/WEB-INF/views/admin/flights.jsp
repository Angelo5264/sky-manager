<%-- 
    Document   : flights
    Created on : 12 may 2026, 13:00:15
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Gestion de Vuelos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .sidebar { min-height: 100vh; background: #2c3e50; }
        .sidebar .nav-link { color: #bdc3c7; padding: 1rem 1.5rem; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: #34495e; color: white; }
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/flights">
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
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3><i class="bi bi-airplane"></i> Gestion de Vuelos</h3>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addFlightModal">
                        <i class="bi bi-plus-circle"></i> Nuevo Vuelo
                    </button>
                </div>

                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Numero</th>
                                    <th>Aerolinea</th>
                                    <th>Origen → Destino</th>
                                    <th>Salida</th>
                                    <th>Asientos</th>
                                    <th>Precio</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${flights}" var="flight">
                                    <tr>
                                        <td><strong>${flight.numeroVuelo}</strong></td>
                                        <td>${flight.nombreAerolinea}</td>
                                        <td>${flight.origenCiudad} → ${flight.destinoCiudad}</td>
                                        <td>${flight.fechaSalida.toLocalDate()}<br><small>${flight.fechaSalida.toLocalTime()}</small></td>
                                        <td>${flight.asientosDisponibles}/${flight.capacidadTotal}</td>
                                        <td>$${flight.precioBase}</td>
                                        <td>
                                            <span class="badge bg-${flight.estado == 'PROGRAMADO' ? 'success' : flight.estado == 'CANCELADO' ? 'danger' : 'warning'}">
                                                ${flight.estado}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <form action="${pageContext.request.contextPath}/admin/flights/delete" method="post" class="d-inline">
                                                    <input type="hidden" name="id" value="${flight.idVuelo}">
                                                    <button type="submit" class="btn btn-outline-danger" 
                                                            onclick="return confirm('¿Eliminar este vuelo?')">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
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

    <!-- Add Flight Modal -->
    <div class="modal fade" id="addFlightModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Nuevo Vuelo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/flights" method="post">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Numero de Vuelo</label>
                                <input type="text" name="numeroVuelo" class="form-control" placeholder="AV1234" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Aerolinea</label>
                                <select name="idAerolinea" class="form-select" required>
                                    <option value="">Seleccionar...</option>
                                    <c:forEach items="${airlines}" var="airline">
                                        <option value="${airline.idAerolinea}">${airline.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Aeropuerto Origen</label>
                                <select name="idOrigen" class="form-select" required>
                                    <option value="">Seleccionar...</option>
                                    <c:forEach items="${airports}" var="airport">
                                        <option value="${airport.idAeropuerto}">${airport.ciudad} (${airport.codigoIata})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Aeropuerto Destino</label>
                                <select name="idDestino" class="form-select" required>
                                    <option value="">Seleccionar...</option>
                                    <c:forEach items="${airports}" var="airport">
                                        <option value="${airport.idAeropuerto}">${airport.ciudad} (${airport.codigoIata})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Fecha/Hora Salida</label>
                                <input type="datetime-local" name="fechaSalida" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Fecha/Hora Llegada</label>
                                <input type="datetime-local" name="fechaLlegada" class="form-control" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Capacidad Total</label>
                                <input type="number" name="capacidad" class="form-control" min="1" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Precio Base</label>
                                <input type="number" name="precio" class="form-control" step="0.01" min="0" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Estado</label>
                                <select name="estado" class="form-select">
                                    <option value="PROGRAMADO">Programado</option>
                                    <option value="EN_VUELO">En Vuelo</option>
                                    <option value="ATERRIZADO">Aterrizado</option>
                                    <option value="CANCELADO">Cancelado</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary"><i class="bi bi-check"></i> Guardar Vuelo</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
