package ar.edu.ubp.corchito;

import java.util.LinkedList;
import java.util.List;

public class JugadorBean {
    private String nombre;
    private boolean eliminado;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public boolean isEliminado() {
        return eliminado;
    }

    public void setEliminado(boolean eliminado) {
        this.eliminado = eliminado;
    }
}