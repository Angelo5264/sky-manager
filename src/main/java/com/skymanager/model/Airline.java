/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.model;

/**
 *
 * @author maick
 */


public class Airline {
    private int idAerolinea;
    private String nombre;
    private String codigoIata;
    private String paisOrigen;
    
    public Airline() {}
    
    public Airline(int idAerolinea, String nombre, String codigoIata, String paisOrigen) {
        this.idAerolinea = idAerolinea;
        this.nombre = nombre;
        this.codigoIata = codigoIata;
        this.paisOrigen = paisOrigen;
    }

    public int getIdAerolinea() { return idAerolinea; }
    public void setIdAerolinea(int idAerolinea) { this.idAerolinea = idAerolinea; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getCodigoIata() { return codigoIata; }
    public void setCodigoIata(String codigoIata) { this.codigoIata = codigoIata; }
    
    public String getPaisOrigen() { return paisOrigen; }
    public void setPaisOrigen(String paisOrigen) { this.paisOrigen = paisOrigen; }
}