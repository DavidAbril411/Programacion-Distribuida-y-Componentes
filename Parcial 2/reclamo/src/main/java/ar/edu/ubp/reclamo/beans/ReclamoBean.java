package ar.edu.ubp.reclamo.beans;

import java.io.Serializable;
import java.sql.Timestamp;

public class ReclamoBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private int nroReclamo;
    private Timestamp fechaHora;
    private String nroChasis;
    private String dominio;
    private Integer km;
    private String apellido;
    private String nombre;
    private String email;
    private String telefono;
    private String contactar; // "S" o "N"
    private String reclamo;

    public ReclamoBean() {
    }

    public int getNroReclamo() {
        return nroReclamo;
    }

    public void setNroReclamo(int nroReclamo) {
        this.nroReclamo = nroReclamo;
    }

    public Timestamp getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(Timestamp fechaHora) {
        this.fechaHora = fechaHora;
    }

    public String getNroChasis() {
        return nroChasis;
    }

    public void setNroChasis(String nroChasis) {
        this.nroChasis = nroChasis;
    }

    public String getDominio() {
        return dominio;
    }

    public void setDominio(String dominio) {
        this.dominio = dominio;
    }

    public Integer getKm() {
        return km;
    }

    public void setKm(Integer km) {
        this.km = km;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getContactar() {
        return contactar;
    }

    public void setContactar(String contactar) {
        this.contactar = contactar;
    }

    public String getReclamo() {
        return reclamo;
    }

    public void setReclamo(String reclamo) {
        this.reclamo = reclamo;
    }
}
