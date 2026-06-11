package ar.edu.ubp.pdc.beans;

import java.util.List;

public class PedidoBean {

    private int id;
    private List<ProductoBean> productos;
    private boolean listoEntrega;

    public PedidoBean() {
    }

    public PedidoBean(int id,
                      List<ProductoBean> productos) {
        this.id = id;
        this.productos = productos;
        this.listoEntrega = false;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<ProductoBean> getProductos() {
        return productos;
    }

    public void setProductos(List<ProductoBean> productos) {
        this.productos = productos;
    }

    public boolean isListoEntrega() {
        return listoEntrega;
    }

    public void setListoEntrega(boolean listoEntrega) {
        this.listoEntrega = listoEntrega;
    }

    public boolean isCompleto() {
        for (ProductoBean producto : productos) {
            if (producto.isRechazado()) {
                return false;
            }
        }
        return true;
    }

    public int getCantidadProductos() {
        return this.productos.size();
    }

}