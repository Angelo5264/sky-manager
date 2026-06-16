/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.model;

/**
 *
 * @author maick
 */

public class Seat {
    private int idAsiento;
    private int idVuelo;
    private String numeroAsiento;
    private String clase;
    private boolean disponible;
    private Integer idReserva;
    
    public Seat() {}

    public int getIdAsiento() { return idAsiento; }
    public void setIdAsiento(int idAsiento) { this.idAsiento = idAsiento; }
    
    public int getIdVuelo() { return idVuelo; }
    public void setIdVuelo(int idVuelo) { this.idVuelo = idVuelo; }
    
    public String getNumeroAsiento() { return numeroAsiento; }
    public void setNumeroAsiento(String numeroAsiento) { this.numeroAsiento = numeroAsiento; }
    
    public String getClase() { return clase; }
    public void setClase(String clase) { this.clase = clase; }
    
    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }
    
    public Integer getIdReserva() { return idReserva; }
    public void setIdReserva(Integer idReserva) { this.idReserva = idReserva; }
}