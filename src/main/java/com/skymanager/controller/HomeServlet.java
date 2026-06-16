/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.controller;

/**
 *
 * @author maick
 */

import com.skymanager.dao.AirportDAO;
import com.skymanager.dao.FlightDAO;
import com.skymanager.model.Airport;
import com.skymanager.model.Flight;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    
    private AirportDAO airportDAO;
    private FlightDAO flightDAO;
    
    @Override
    public void init() {
        airportDAO = new AirportDAO();
        flightDAO = new FlightDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Airport> airports = airportDAO.findAll();
        List<Flight> popularFlights = flightDAO.findAll();
        
        req.setAttribute("airports", airports);
        req.setAttribute("popularFlights", popularFlights);
        req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req, resp);
    }
}