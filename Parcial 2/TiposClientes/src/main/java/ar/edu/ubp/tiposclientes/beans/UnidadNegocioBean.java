package ar.edu.ubp.tiposclientes.beans;

public class UnidadNegocioBean {
    private String CodUnidadNegocio;
    private String NombreUnidadNegocio;
    private int NroOrden;

    public String getCodUnidadNegocio() {
        return CodUnidadNegocio;
    }

    public void setCodUnidadNegocio(String codUnidadNegocio) {
        CodUnidadNegocio = codUnidadNegocio;
    }

    public String getNombreUnidadNegocio() {
        return NombreUnidadNegocio;
    }

    public void setNombreUnidadNegocio(String nombreUnidadNegocio) {
        NombreUnidadNegocio = nombreUnidadNegocio;
    }

    public int getNroOrden() {
        return NroOrden;
    }

    public void setNroOrden(int nroOrden) {
        NroOrden = nroOrden;
    }
}
