/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.skymanager.model;

/**
 *
 * @author maick
 */

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Flight {
    private int idVuelo;
    private int idAerolinea;
    private int idAeropuertoOrigen;
    private int idAeropuertoDestino;
    private String numeroVuelo;
    private LocalDateTime fechaSalida;
    private LocalDateTime fechaLlegada;
    private int capacidadTotal;
    private int asientosDisponibles;
    private BigDecimal precioBase;
    private String estado;
    
    private String nombreAerolinea;
    private String codigoAerolinea;
    private String origenCiudad;
    private String origenIata;
    private String destinoCiudad;
    private String destinoIata;
    
    public Flight() {}

    public int getIdVuelo() { return idVuelo; }
    public void setIdVuelo(int idVuelo) { this.idVuelo = idVuelo; }
    
    public int getIdAerolinea() { return idAerolinea; }
    public void setIdAerolinea(int idAerolinea) { this.idAerolinea = idAerolinea; }
    
    public int getIdAeropuertoOrigen() { return idAeropuertoOrigen; }
    public void setIdAeropuertoOrigen(int idAeropuertoOrigen) { this.idAeropuertoOrigen = idAeropuertoOrigen; }
    
    public int getIdAeropuertoDestino() { return idAeropuertoDestino; }
    public void setIdAeropuertoDestino(int idAeropuertoDestino) { this.idAeropuertoDestino = idAeropuertoDestino; }
    
    public String getNumeroVuelo() { return numeroVuelo; }
    public void setNumeroVuelo(String numeroVuelo) { this.numeroVuelo = numeroVuelo; }
    
    public LocalDateTime getFechaSalida() { return fechaSalida; }
    public void setFechaSalida(LocalDateTime fechaSalida) { this.fechaSalida = fechaSalida; }
    
    public LocalDateTime getFechaLlegada() { return fechaLlegada; }
    public void setFechaLlegada(LocalDateTime fechaLlegada) { this.fechaLlegada = fechaLlegada; }
    
    public int getCapacidadTotal() { return capacidadTotal; }
    public void setCapacidadTotal(int capacidadTotal) { this.capacidadTotal = capacidadTotal; }
    
    public int getAsientosDisponibles() { return asientosDisponibles; }
    public void setAsientosDisponibles(int asientosDisponibles) { this.asientosDisponibles = asientosDisponibles; }
    
    public BigDecimal getPrecioBase() { return precioBase; }
    public void setPrecioBase(BigDecimal precioBase) { this.precioBase = precioBase; }
    
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    public String getNombreAerolinea() { return nombreAerolinea; }
    public void setNombreAerolinea(String nombreAerolinea) { this.nombreAerolinea = nombreAerolinea; }
    
    public String getCodigoAerolinea() { return codigoAerolinea; }
    public void setCodigoAerolinea(String codigoAerolinea) { this.codigoAerolinea = codigoAerolinea; }
    
    public String getOrigenCiudad() { return origenCiudad; }
    public void setOrigenCiudad(String origenCiudad) { this.origenCiudad = origenCiudad; }
    
    public String getOrigenIata() { return origenIata; }
    public void setOrigenIata(String origenIata) { this.origenIata = origenIata; }
    
    public String getDestinoCiudad() { return destinoCiudad; }
    public void setDestinoCiudad(String destinoCiudad) { this.destinoCiudad = destinoCiudad; }
    
    public String getDestinoIata() { return destinoIata; }
    public void setDestinoIata(String destinoIata) { this.destinoIata = destinoIata; }
    
    public String getDuracion() {
        if (fechaSalida != null && fechaLlegada != null) {
            long minutos = java.time.Duration.between(fechaSalida, fechaLlegada).toMinutes();
            long horas = minutos / 60;
            long mins = minutos % 60;
            return horas + "h " + mins + "m";
        }
        return "";
    }
}