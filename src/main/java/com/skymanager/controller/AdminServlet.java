/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.controller;

/**
 *
 * @author maick
 */

import com.skymanager.model.Flight;
import com.skymanager.model.Booking;
import com.skymanager.model.User;
import com.skymanager.dao.BookingDAO;
import com.skymanager.dao.UserDAO;
import com.skymanager.dao.FlightDAO;
import com.skymanager.dao.AirportDAO;
import com.skymanager.dao.AirlineDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(urlPatterns = {
    "/admin/dashboard", "/admin/flights", "/admin/users", "/admin/reports",
    "/admin/flights/delete", "/admin/users/toggle", "/admin/users/delete"
})
public class AdminServlet extends HttpServlet {
    
    private FlightDAO flightDAO;
    private AirportDAO airportDAO;
    private AirlineDAO airlineDAO;
    private UserDAO userDAO;
    private BookingDAO bookingDAO;
    
    @Override
    public void init() {
        flightDAO = new FlightDAO();
        airportDAO = new AirportDAO();
        airlineDAO = new AirlineDAO();
        userDAO = new UserDAO();
        bookingDAO = new BookingDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        switch (path) {
            case "/admin/dashboard" -> {
                req.setAttribute("totalFlights", flightDAO.countFlights());
                req.setAttribute("totalBookings", bookingDAO.countBookings());
                req.setAttribute("totalUsers", userDAO.countUsers());
                
                BigDecimal revenue = BigDecimal.ZERO;
                List<Booking> allBookings = bookingDAO.findAll();
                for (Booking b : allBookings) {
                    if ("CONFIRMADA".equals(b.getEstadoReserva())) {
                        revenue = revenue.add(b.getPrecioFinal());
                    }
                }
                req.setAttribute("totalRevenue", revenue);
                req.setAttribute("recentBookings", allBookings);
                req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
            }
            case "/admin/flights" -> {
                req.setAttribute("flights", flightDAO.findAll());
                req.setAttribute("airports", airportDAO.findAll());
                req.setAttribute("airlines", airlineDAO.findAll());
                req.getRequestDispatcher("/WEB-INF/views/admin/flights.jsp").forward(req, resp);
            }
            case "/admin/users" -> {
                req.setAttribute("users", userDAO.findAll());
                req.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(req, resp);
            }
            case "/admin/reports" -> {
                req.setAttribute("flights", flightDAO.findAll());
                req.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp").forward(req, resp);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        switch (path) {
            case "/admin/flights" -> {
                Flight flight = new Flight();
                flight.setIdAerolinea(Integer.parseInt(req.getParameter("idAerolinea")));
                flight.setIdAeropuertoOrigen(Integer.parseInt(req.getParameter("idOrigen")));
                flight.setIdAeropuertoDestino(Integer.parseInt(req.getParameter("idDestino")));
                flight.setNumeroVuelo(req.getParameter("numeroVuelo"));
                flight.setFechaSalida(LocalDateTime.parse(req.getParameter("fechaSalida")));
                flight.setFechaLlegada(LocalDateTime.parse(req.getParameter("fechaLlegada")));
                flight.setCapacidadTotal(Integer.parseInt(req.getParameter("capacidad")));
                flight.setAsientosDisponibles(Integer.parseInt(req.getParameter("capacidad")));
                flight.setPrecioBase(new BigDecimal(req.getParameter("precio")));
                flight.setEstado(req.getParameter("estado"));
                
                if (flightDAO.create(flight)) {
                    req.setAttribute("success", "Vuelo creado exitosamente");
                } else {
                    req.setAttribute("error", "Error al crear el vuelo");
                }
                doGet(req, resp);
            }
            case "/admin/flights/delete" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                flightDAO.delete(id);
                resp.sendRedirect(req.getContextPath() + "/admin/flights");
            }
            case "/admin/users/toggle" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                User user = userDAO.findById(id);
                user.setEstado("ACTIVO".equals(user.getEstado()) ? "INACTIVO" : "ACTIVO");
                userDAO.update(user);
                resp.sendRedirect(req.getContextPath() + "/admin/users");
            }
            case "/admin/users/delete" -> {
                int id = Integer.parseInt(req.getParameter("id"));
                userDAO.delete(id);
                resp.sendRedirect(req.getContextPath() + "/admin/users");
            }
        }
    }
}