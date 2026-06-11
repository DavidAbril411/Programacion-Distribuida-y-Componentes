package ar.edu.ubp.prode;

import java.util.*;

public class EquiposBeans {
    List<List<String>> equipos;


    public EquiposBeans() {
        this.equipos = new ArrayList<List<String>>();
        equipos.add(Arrays.asList("EQUIPO A", "EQUIPO B"));
        equipos.add(Arrays.asList("EQUIPO C", "EQUIPO D"));
        equipos.add(Arrays.asList("EQUIPO E", "EQUIPO F"));
        equipos.add(Arrays.asList("EQUIPO G", "EQUIPO H"));
        equipos.add(Arrays.asList("EQUIPO I", "EQUIPO J"));
        equipos.add(Arrays.asList("EQUIPO K", "EQUIPO L"));
        equipos.add(Arrays.asList("EQUIPO M", "EQUIPO N"));
        equipos.add(Arrays.asList("EQUIPO O", "EQUIPO P"));
        equipos.add(Arrays.asList("EQUIPO Q", "EQUIPO R"));
        equipos.add(Arrays.asList("EQUIPO S", "EQUIPO T"));
    }

    public List<List<String>> getEquipos() {
        return equipos;
    }


    public void Resultados() {
        for (List<String> e : this.equipos) {
            for (String s : e) {
                s.concat(String.valueOf((new Random()).nextInt((6))));
            }

        }
    }
}

