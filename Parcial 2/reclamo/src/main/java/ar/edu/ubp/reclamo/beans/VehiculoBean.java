package ar.edu.ubp.reclamo.beans;

import java.io.Serializable;

public class VehiculoBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private String nroChasis;
    private String modelo;
    private short ano;
    private String dominio;

    public VehiculoBean() {
    }

    public String getNroChasis() {
        return nroChasis;
    }

    public void setNroChasis(String nroChasis) {
        this.nroChasis = nroChasis;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public short getAno() {
        return ano;
    }

    public void setAno(short ano) {
        this.ano = ano;
    }

    public String getDominio() {
        return dominio;
    }

    public void setDominio(String dominio) {
        this.dominio = dominio;
    }
}
