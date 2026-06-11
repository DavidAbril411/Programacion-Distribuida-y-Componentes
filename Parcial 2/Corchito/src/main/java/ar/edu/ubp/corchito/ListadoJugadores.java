package ar.edu.ubp.corchito;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

public class ListadoJugadores {
    private List<JugadorBean> jugadores;

    public ListadoJugadores() {
        this.jugadores = new LinkedList<JugadorBean>();
    }

    public void addJugador(JugadorBean jugador) {
        this.jugadores.add(jugador);
    }

    public List<JugadorBean> getJugadores() {
        return this.jugadores;
    }

    private static final Random RANDOM = new Random();

    public int eliminarJugador() {
        List<JugadorBean> JugadoresVivos = new LinkedList<JugadorBean>();
        for (JugadorBean j : this.jugadores) {
            if (j.isEliminado() == false) {
                JugadoresVivos.add(j);
            }
        }
        int JugadoresVivosSize = JugadoresVivos.size();
        int JugadorAEliminar = RANDOM.nextInt((JugadoresVivosSize));
        JugadorBean elegido = JugadoresVivos.get(JugadorAEliminar);
        elegido.setEliminado(true);
        return this.jugadores.indexOf(elegido);
    }
}
