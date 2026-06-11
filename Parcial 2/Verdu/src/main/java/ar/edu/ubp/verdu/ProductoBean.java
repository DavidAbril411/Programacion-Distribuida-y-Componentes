package ar.edu.ubp.verdu;

public class ProductoBean {

    private int id;
    private String nombre;
    private float cantidad;
    private boolean rechazado;

    public ProductoBean() {
    }

    public ProductoBean(int id,
                        String nombre,
                        float cantidad) {
        this.id = id;
        this.nombre = nombre;
        this.cantidad = cantidad;
        this.rechazado = false;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public float getCantidad() {
        return cantidad;
    }

    public void setCantidad(float cantidad) {
        this.cantidad = cantidad;
    }

    public boolean isRechazado() {
        return rechazado;
    }

    public void setRechazado(boolean rechazado) {
        this.rechazado = rechazado;
    }

}