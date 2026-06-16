/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.controller;

/**
 *
 * @author maick
 */

import com.skymanager.dao.BookingDAO;
import com.skymanager.dao.FlightDAO;
import com.skymanager.dao.SeatDAO;
import com.skymanager.model.Booking;
import com.skymanager.model.Flight;
import com.skymanager.model.Seat;
import com.skymanager.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(urlPatterns = {"/bookings/confirm", "/bookings/history", "/bookings/receipt", "/bookings/cancel"})
public class BookingServlet extends HttpServlet {
    
    private BookingDAO bookingDAO;
    private FlightDAO flightDAO;
    private SeatDAO seatDAO;
    
    @Override
    public void init() {
        bookingDAO = new BookingDAO();
        flightDAO = new FlightDAO();
        seatDAO = new SeatDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        switch (path) {
            case "/bookings/confirm" -> {
                String flightIdStr = req.getParameter("flightId");
                if (flightIdStr != null) {
                    int flightId = Integer.parseInt(flightIdStr);
                    Flight flight = flightDAO.findById(flightId);
                    List<Seat> seats = seatDAO.findByFlightId(flightId);
                    
                    req.setAttribute("flight", flight);
                    req.setAttribute("seats", seats);
                    req.getRequestDispatcher("/WEB-INF/views/bookings/confirm.jsp").forward(req, resp);
                }
            }
            case "/bookings/history" -> {
                List<Booking> bookings = bookingDAO.findByUserId(user.getIdUsuario());
                req.setAttribute("bookings", bookings);
                req.getRequestDispatcher("/WEB-INF/views/bookings/history.jsp").forward(req, resp);
            }
            case "/bookings/receipt" -> {
                String code = req.getParameter("code");
                Booking booking = bookingDAO.findByConfirmationCode(code);
                req.setAttribute("booking", booking);
                req.getRequestDispatcher("/WEB-INF/views/bookings/receipt.jsp").forward(req, resp);
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        switch (path) {
            case "/bookings/confirm" -> {
                int flightId = Integer.parseInt(req.getParameter("flightId"));
                String seatNumber = req.getParameter("seatNumber");
                String seatClass = req.getParameter("seatClass");
                
                Flight flight = flightDAO.findById(flightId);
                
                Booking booking = new Booking();
                booking.setIdUsuario(user.getIdUsuario());
                booking.setIdVuelo(flightId);
                booking.setNumeroAsiento(seatNumber);
                booking.setClase(seatClass);
                
                BigDecimal price = flight.getPrecioBase();
                if ("EJECUTIVA".equals(seatClass)) price = price.multiply(new BigDecimal("2.5"));
                if ("PRIMERA".equals(seatClass)) price = price.multiply(new BigDecimal("4"));
                price = price.multiply(new BigDecimal("1.18")).add(new BigDecimal("25"));
                
                booking.setPrecioFinal(price);
                
                if (bookingDAO.create(booking)) {
                    flightDAO.updateAvailableSeats(flightId, -1);
                    resp.sendRedirect(req.getContextPath() + "/bookings/history");
                } else {
                    req.setAttribute("error", "Error al procesar la reserva");
                    doGet(req, resp);
                }
            }
            case "/bookings/cancel" -> {
                int bookingId = Integer.parseInt(req.getParameter("bookingId"));
                Booking booking = bookingDAO.findById(bookingId);
                
                if (bookingDAO.cancel(bookingId)) {
                    seatDAO.releaseSeat(bookingId);
                    flightDAO.updateAvailableSeats(booking.getIdVuelo(), 1);
                }
                resp.sendRedirect(req.getContextPath() + "/bookings/history");
            }
        }
    }
}
