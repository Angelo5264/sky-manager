/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.model;

public class Airport {
    private int idAeropuerto;
    private String codigoIata;
    private String nombre;
    private String ciudad;
    private String pais;
    
    public Airport() {}
    
    public Airport(int idAeropuerto, String codigoIata, String nombre, String ciudad, String pais) {
        this.idAeropuerto = idAeropuerto;
        this.codigoIata = codigoIata;
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.pais = pais;
    }

    public int getIdAeropuerto() { return idAeropuerto; }
    public void setIdAeropuerto(int idAeropuerto) { this.idAeropuerto = idAeropuerto; }
    
    public String getCodigoIata() { return codigoIata; }
    public void setCodigoIata(String codigoIata) { this.codigoIata = codigoIata; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getCiudad() { return ciudad; }
    public void setCiudad(String ciudad) { this.ciudad = ciudad; }
    
    public String getPais() { return pais; }
    public void setPais(String pais) { this.pais = pais; }
    
    public String getDisplayName() {
        return ciudad + " (" + codigoIata + ") - " + nombre;
    }
}