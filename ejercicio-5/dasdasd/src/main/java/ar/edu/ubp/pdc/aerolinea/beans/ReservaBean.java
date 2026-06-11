package ar.edu.ubp.pdc.aerolinea.beans;

public class ReservaBean {

    private String apellido;
    private String nombre;
    private int nroCliente;
    private String tipoClaseDesc;
    private String tipoClase;
    private String fechaReserva;
    private int nroReserva;

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

    public int getNroCliente() {
        return nroCliente;
    }

    public void setNroCliente(int nroCliente) {
        this.nroCliente = nroCliente;
    }

    public String getTipoClaseDesc() {
        return tipoClaseDesc;
    }

    public void setTipoClaseDesc(String tipoClaseDesc) {
        this.tipoClaseDesc = tipoClaseDesc;
    }

    public String getTipoClase() {
        return tipoClase;
    }

    public void setTipoClase(String tipoClase) {
        this.tipoClase = tipoClase;
    }

    public String getFechaReserva() {
        return fechaReserva;
    }

    public void setFechaReserva(String fechaReserva) {
        this.fechaReserva = fechaReserva;
    }

    public int getNroReserva() {
        return nroReserva;
    }

    public void setNroReserva(int nroReserva) {
        this.nroReserva = nroReserva;
    }
}
