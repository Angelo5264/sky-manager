/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.controller;

/**
 *
 * @author maick
 */

import com.skymanager.dao.AirlineDAO;
import com.skymanager.dao.AirportDAO;
import com.skymanager.dao.FlightDAO;
import com.skymanager.model.Airline;
import com.skymanager.model.Airport;
import com.skymanager.model.Flight;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/flights/search", "/flights/list"})
public class FlightServlet extends HttpServlet {
    
    private FlightDAO flightDAO;
    private AirportDAO airportDAO;
    private AirlineDAO airlineDAO;
    
    @Override
    public void init() {
        flightDAO = new FlightDAO();
        airportDAO = new AirportDAO();
        airlineDAO = new AirlineDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        if ("/flights/search".equals(path)) {
            String origenStr = req.getParameter("origen");
            String destinoStr = req.getParameter("destino");
            String fecha = req.getParameter("fecha");
            String pasajerosStr = req.getParameter("pasajeros");
            
            Integer origen = (origenStr != null && !origenStr.isEmpty()) ? Integer.parseInt(origenStr) : null;
            Integer destino = (destinoStr != null && !destinoStr.isEmpty()) ? Integer.parseInt(destinoStr) : null;
            Integer pasajeros = (pasajerosStr != null && !pasajerosStr.isEmpty()) ? Integer.parseInt(pasajerosStr) : null;
            
            List<Flight> flights = flightDAO.search(origen, destino, fecha, pasajeros);
            List<Airport> airports = airportDAO.findAll();
            List<Airline> airlines = airlineDAO.findAll();
            
            req.setAttribute("flights", flights);
            req.setAttribute("airports", airports);
            req.setAttribute("airlines", airlines);
            req.getRequestDispatcher("/WEB-INF/views/flights/search.jsp").forward(req, resp);
        }
    }
}
