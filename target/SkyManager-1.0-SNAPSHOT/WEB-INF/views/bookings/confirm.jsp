<%-- 
    Document   : confirm
    Created on : 12 may 2026, 12:56:07
    Author     : maick
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyManager - Confirmar Reserva</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .seat-map {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 8px;
            max-width: 300px;
            margin: 0 auto;
        }
        .seat {
            aspect-ratio: 1;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 0.8rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        .seat.available {
            background: #e8f5e9;
            border: 2px solid #4caf50;
            color: #2e7d32;
        }
        .seat.available:hover {
            background: #4caf50;
            color: white;
        }
        .seat.occupied {
            background: #ffebee;
            border: 2px solid #ef5350;
            color: #c62828;
            cursor: not-allowed;
            opacity: 0.6;
        }
        .seat.selected {
            background: #667eea;
            border: 2px solid #5a67d8;
            color: white;
        }
        .seat.executive {
            border-color: #ffd700;
            background: #fff8e1;
        }
        .flight-summary {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            padding: 1.5rem;
        }
        .price-summary {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">✈️ SkyManager</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle"></i> ${user.nombreCompleto}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Cerrar Sesion</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <div class="row">
            <div class="col-lg-8">
                <h3><i class="bi bi-ticket-perforated"></i> Confirmar Reserva</h3>
                
                <div class="flight-summary mb-4">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h5>${flight.nombreAerolinea} ${flight.numeroVuelo}</h5>
                            <p class="mb-1"><strong>${flight.origenCiudad}</strong> → <strong>${flight.destinoCiudad}</strong></p>
                            <p class="text-muted mb-0">
                                <i class="bi bi-calendar"></i> ${flight.fechaSalida.toLocalDate()}<br>
                                <i class="bi bi-clock"></i> ${flight.fechaSalida.toLocalTime()} - ${flight.fechaLlegada.toLocalTime()}<br>
                                <i class="bi bi-hourglass"></i> ${flight.duracion}
                            </p>
                        </div>
                        <div class="col-md-6 text-end">
                            <h4 class="text-primary">$${flight.precioBase}</h4>
                            <small class="text-muted">Precio base por persona</small>
                        </div>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="bi bi-grid-3x3"></i> Seleccion de Asiento</h5>
                    </div>
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <span class="badge bg-success me-2">Disponible</span>
                            <span class="badge bg-danger me-2">Ocupado</span>
                            <span class="badge bg-primary">Seleccionado</span>
                            <span class="badge bg-warning text-dark">Ejecutiva</span>
                        </div>
                        <div class="seat-map mb-3">
                            <c:forEach items="${seats}" var="seat">
                                <div class="seat ${seat.disponible ? 'available' : 'occupied'} ${seat.clase == 'EJECUTIVA' ? 'executive' : ''}"
                                     data-seat="${seat.numeroAsiento}"
                                     data-class="${seat.clase}"
                                     onclick="${seat.disponible ? 'selectSeat(this)' : ''}">
                                    ${seat.numeroAsiento}
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="bi bi-person"></i> Informacion del Pasajero</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Nombre</label>
                                <input type="text" class="form-control" value="${user.nombre}" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Apellido</label>
                                <input type="text" class="form-control" value="${user.apellido}" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Correo</label>
                                <input type="email" class="form-control" value="${user.email}" readonly>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Documento de Identidad</label>
                                <input type="text" class="form-control" placeholder="Ingrese DNI/Pasaporte" required>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="price-summary sticky-top" style="top: 20px; z-index: 100;">
                    <h5 class="mb-3">Resumen de Pago</h5>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Vuelo (1 pasajero)</span>
                        <span>$${flight.precioBase}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Impuestos (18%)</span>
                        <span>$${flight.precioBase * 0.18}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tarifa de servicio</span>
                        <span>$25.00</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between mb-3">
                        <strong>Total</strong>
                        <strong class="text-primary fs-4">$${flight.precioBase * 1.18 + 25}</strong>
                    </div>
                    <form action="${pageContext.request.contextPath}/bookings/confirm" method="post">
                        <input type="hidden" name="flightId" value="${flight.idVuelo}">
                        <input type="hidden" name="seatNumber" id="formSeatNumber" value="">
                        <input type="hidden" name="seatClass" id="formSeatClass" value="">
                        <button type="submit" class="btn btn-primary w-100 btn-lg" id="btnConfirm" disabled>
                            <i class="bi bi-check-circle"></i> Confirmar Reserva
                        </button>
                    </form>
                    <small class="text-muted d-block mt-2 text-center">Simulacion de pago - No se procesara cargo real</small>
                </div>
            </div>
        </div>
    </div>

    <script>
        function selectSeat(element) {
            document.querySelectorAll('.seat').forEach(s => s.classList.remove('selected'));
            element.classList.add('selected');
            document.getElementById('formSeatNumber').value = element.dataset.seat;
            document.getElementById('formSeatClass').value = element.dataset.class;
            document.getElementById('btnConfirm').disabled = false;
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
