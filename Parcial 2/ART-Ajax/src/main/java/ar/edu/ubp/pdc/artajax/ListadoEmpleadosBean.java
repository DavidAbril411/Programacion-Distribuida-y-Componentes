package ar.edu.ubp.pdc.artajax;

import java.util.LinkedList;
import java.util.List;

public class ListadoEmpleadosBean {

    private List<EmpleadoBean> empleados;

    public ListadoEmpleadosBean() {
        this.empleados = new LinkedList<EmpleadoBean>();
    }

    public void addEmpleado(EmpleadoBean empleado){
        this.empleados.add(empleado);
    }

    public List<EmpleadoBean> getEmpleados() {
        return empleados;
    }
}
