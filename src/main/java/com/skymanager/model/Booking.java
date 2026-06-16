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

public class Booking {
    private int idReserva;
    private int idUsuario;
    private int idVuelo;
    private LocalDateTime fechaReserva;
    private String numeroAsiento;
    private String clase;
    private BigDecimal precioFinal;
    private String estadoReserva;
    private String codigoConfirmacion;
    
    private String numeroVuelo;
    private String origenCiudad;
    private String destinoCiudad;
    private LocalDateTime fechaSalida;
    private String nombreAerolinea;
    private String pasajeroNombre;
    
    public Booking() {}

    public int getIdReserva() { return idReserva; }
    public void setIdReserva(int idReserva) { this.idReserva = idReserva; }
    
    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }
    
    public int getIdVuelo() { return idVuelo; }
    public void setIdVuelo(int idVuelo) { this.idVuelo = idVuelo; }
    
    public LocalDateTime getFechaReserva() { return fechaReserva; }
    public void setFechaReserva(LocalDateTime fechaReserva) { this.fechaReserva = fechaReserva; }
    
    public String getNumeroAsiento() { return numeroAsiento; }
    public void setNumeroAsiento(String numeroAsiento) { this.numeroAsiento = numeroAsiento; }
    
    public String getClase() { return clase; }
    public void setClase(String clase) { this.clase = clase; }
    
    public BigDecimal getPrecioFinal() { return precioFinal; }
    public void setPrecioFinal(BigDecimal precioFinal) { this.precioFinal = precioFinal; }
    
    public String getEstadoReserva() { return estadoReserva; }
    public void setEstadoReserva(String estadoReserva) { this.estadoReserva = estadoReserva; }
    
    public String getCodigoConfirmacion() { return codigoConfirmacion; }
    public void setCodigoConfirmacion(String codigoConfirmacion) { this.codigoConfirmacion = codigoConfirmacion; }
    
    public String getNumeroVuelo() { return numeroVuelo; }
    public void setNumeroVuelo(String numeroVuelo) { this.numeroVuelo = numeroVuelo; }
    
    public String getOrigenCiudad() { return origenCiudad; }
    public void setOrigenCiudad(String origenCiudad) { this.origenCiudad = origenCiudad; }
    
    public String getDestinoCiudad() { return destinoCiudad; }
    public void setDestinoCiudad(String destinoCiudad) { this.destinoCiudad = destinoCiudad; }
    
    public LocalDateTime getFechaSalida() { return fechaSalida; }
    public void setFechaSalida(LocalDateTime fechaSalida) { this.fechaSalida = fechaSalida; }
    
    public String getNombreAerolinea() { return nombreAerolinea; }
    public void setNombreAerolinea(String nombreAerolinea) { this.nombreAerolinea = nombreAerolinea; }
    
    public String getPasajeroNombre() { return pasajeroNombre; }
    public void setPasajeroNombre(String pasajeroNombre) { this.pasajeroNombre = pasajeroNombre; }
}