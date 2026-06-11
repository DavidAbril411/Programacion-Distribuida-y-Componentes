package ar.edu.ubp.pdc.jstlcore;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CategoriasBean {

	private List<String> categorias;

    public CategoriasBean() {
    	this.categorias = new ArrayList<String>();
    }

    public String[] getCategorias() {
    	return this.categorias.toArray(new String[0]);
    }
    
    public void setCategorias(String[] categorias) {
    	this.categorias = Arrays.asList(categorias);
    }
	
}
