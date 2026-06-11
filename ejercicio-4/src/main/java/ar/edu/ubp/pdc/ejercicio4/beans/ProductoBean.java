package ar.edu.ubp.pdc.ejercicio4.beans;

public class ProductoBean {

    private short nroDetalle;
    private String codBarra;
    private String nomProducto;
    private double precio;

    public short getNroDetalle() {
        return nroDetalle;
    }

    public void setNroDetalle(short nroDetalle) {
        this.nroDetalle = nroDetalle;
    }

    public String getCodBarra() {
        return codBarra;
    }

    public void setCodBarra(String codBarra) {
        this.codBarra = codBarra;
    }

    public String getNomProducto() {
        return nomProducto;
    }

    public void setNomProducto(String nomProducto) {
        this.nomProducto = nomProducto;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }
}
