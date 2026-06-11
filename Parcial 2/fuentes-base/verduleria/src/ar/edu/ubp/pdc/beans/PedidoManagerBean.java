package ar.edu.ubp.pdc.beans;

import java.util.LinkedList;
import java.util.List;

public class PedidoManagerBean {

    private List<PedidoBean> pedidos;

    public PedidoManagerBean() {
        pedidos = new LinkedList<>();
        generarDatos();
    }

    public List<PedidoBean> getPedidos() {
        return pedidos;
    }

    public void quitarProducto(int idPedido,int idProducto) throws Exception {
        PedidoBean pedido = getPedidoById(idPedido);
        for (ProductoBean producto : pedido.getProductos()) {
            if (producto.getId() == idProducto) {
                if (producto.isRechazado()) {
                    throw new Exception("El producto ya fue rechazado.");
                }
                producto.setRechazado(true);
                return;
            }
        }
        throw new Exception("El producto no existe.");
    }

    public void marcarEntrega(int idPedido, boolean listoEntrega) throws Exception {
        PedidoBean pedido = getPedidoById(idPedido);
        pedido.setListoEntrega(listoEntrega);
    }

    private PedidoBean getPedidoById(int idPedido) throws Exception {
        for (PedidoBean pedido : pedidos) {
            if (pedido.getId() == idPedido) {
                return pedido;
            }
        }
        throw new Exception("El pedido no existe.");
    }

    private void generarDatos() {
        /*
         * PEDIDO 1
         */
        List<ProductoBean> productosPedido1 = new LinkedList<>();

        productosPedido1.add(
            new ProductoBean(
                1,
                "Tomates",
                3
            )
        );

        productosPedido1.add(
            new ProductoBean(
                2,
                "Bananas",
                2
            )
        );

        productosPedido1.add(
            new ProductoBean(
                3,
                "Peras",
                1.5f
            )
        );

        productosPedido1.add(
            new ProductoBean(
                4,
                "Naranjas",
                3
            )
        );

        productosPedido1.add(
            new ProductoBean(
                5,
                "Manzanas",
                2.5f
            )
        );

        productosPedido1.add(
            new ProductoBean(
                6,
                "Kiwi",
                2
            )
        );

        productosPedido1.add(
            new ProductoBean(
                7,
                "Frutillas",
                1.5f
            )
        );

        PedidoBean pedido1 =
            new PedidoBean(
                1001,
                productosPedido1
            );

        pedidos.add(pedido1);

        /*
         * PEDIDO 2
         */
        List<ProductoBean> productosPedido2 = new LinkedList<>();

        productosPedido2.add(
            new ProductoBean(
                10,
                "Lechuga",
                3
            )
        );

        productosPedido2.add(
            new ProductoBean(
                11,
                "Zanahoria",
                1.5f
            )
        );

        productosPedido2.add(
            new ProductoBean(
                12,
                "Papa",
                3
            )
        );

        productosPedido2.add(
            new ProductoBean(
                13,
                "Cebolla",
                1.2f
            )
        );

        productosPedido2.add(
            new ProductoBean(
                14,
                "Batata",
                2
            )
        );

        productosPedido2.add(
            new ProductoBean(
                15,
                "Zapallo",
                5
            )
        );

        PedidoBean pedido2 =
            new PedidoBean(
                1002,
                productosPedido2
            );

        pedidos.add(pedido2);

        /*
         * PEDIDO 3
         */
        List<ProductoBean> productosPedido3 = new LinkedList<>();

        productosPedido3.add(
            new ProductoBean(
                20,
                "Mandarina",
                2
            )
        );

        productosPedido3.add(
            new ProductoBean(
                21,
                "Pera",
                1
            )
        );

        productosPedido3.add(
            new ProductoBean(
                22,
                "Uva",
                1.4f
            )
        );

        PedidoBean pedido3 =
            new PedidoBean(
                1003,
                productosPedido3
            );

        pedidos.add(pedido3);

        /*
         * PEDIDO 4
         */
        List<ProductoBean> productosPedido4 = new LinkedList<>();

        productosPedido4.add(
            new ProductoBean(
                30,
                "Pepino",
                1.2f
            )
        );

        productosPedido4.add(
            new ProductoBean(
                31,
                "Acelga",
                1
            )
        );

        productosPedido4.add(
            new ProductoBean(
                32,
                "Espinaca",
                0.5f
            )
        );

        PedidoBean pedido4 =
            new PedidoBean(
                1004,
                productosPedido4
            );

        pedidos.add(pedido4);
    }

}