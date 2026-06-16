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
import com.skymanager.model.Airline;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AirlineDAO {
    
    public List<Airline> findAll() {
        List<Airline> airlines = new ArrayList<>();
        String sql = "SELECT * FROM aerolinea ORDER BY nombre";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                airlines.add(mapAirline(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return airlines;
    }
    
    public Airline findById(int id) {
        String sql = "SELECT * FROM aerolinea WHERE id_aerolinea = ?";
        try (Connection conn = DatabaseConfig.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapAirline(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    private Airline mapAirline(ResultSet rs) throws SQLException {
        Airline airline = new Airline();
        airline.setIdAerolinea(rs.getInt("id_aerolinea"));
        airline.setNombre(rs.getString("nombre"));
        airline.setCodigoIata(rs.getString("codigo_iata"));
        airline.setPaisOrigen(rs.getString("pais_origen"));
        return airline;
    }
}
