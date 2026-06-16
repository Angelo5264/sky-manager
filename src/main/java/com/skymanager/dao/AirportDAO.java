/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.dao;

/**
 *
 * @author maick
 */
import com.skymanager.config.DatabaseConfig;
import com.skymanager.model.Airport;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AirportDAO {
    
    public List<Airport> findAll() {
        List<Airport> airports = new ArrayList<>();
        String sql = "SELECT * FROM aeropuerto ORDER BY pais, ciudad";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                airports.add(mapAirport(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return airports;
    }
    
    public Airport findById(int id) {
        String sql = "SELECT * FROM aeropuerto WHERE id_aeropuerto = ?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapAirport(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean create(Airport airport) {
        String sql = "INSERT INTO aeropuerto (codigo_iata, nombre, ciudad, pais) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, airport.getCodigoIata());
            ps.setString(2, airport.getNombre());
            ps.setString(3, airport.getCiudad());
            ps.setString(4, airport.getPais());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Airport mapAirport(ResultSet rs) throws SQLException {
        Airport airport = new Airport();
        airport.setIdAeropuerto(rs.getInt("id_aeropuerto"));
        airport.setCodigoIata(rs.getString("codigo_iata"));
        airport.setNombre(rs.getString("nombre"));
        airport.setCiudad(rs.getString("ciudad"));
        airport.setPais(rs.getString("pais"));
        return airport;
    }
}