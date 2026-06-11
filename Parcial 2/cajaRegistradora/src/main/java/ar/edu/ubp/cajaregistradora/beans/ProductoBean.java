package ar.edu.ubp.cajaregistradora.beans;

public class ProductoBean {
    private int nro_producto;
    private String cod_barra;
    private String nom_producto;
    private float precio;

    public int getNro_producto() {
        return nro_producto;
    }

    public void setNro_producto(int nro_producto) {
        this.nro_producto = nro_producto;
    }

    public String getCod_barra() {
        return cod_barra;
    }

    public void setCod_barra(String cod_barra) {
        this.cod_barra = cod_barra;
    }

    public String getNom_producto() {
        return nom_producto;
    }

    public void setNom_producto(String nom_producto) {
        this.nom_producto = nom_producto;
    }

    public float getPrecio() {
        return precio;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }
}
