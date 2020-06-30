-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-05-02 02:21:05.349

-- foreign keys
ALTER TABLE back_order
    DROP CONSTRAINT FK_back_order_pedidos;

ALTER TABLE ciudad
    DROP CONSTRAINT FK_ciudad_departamento;

ALTER TABLE cliente
    DROP CONSTRAINT FK_cliente_ciudad;

ALTER TABLE cliente
    DROP CONSTRAINT FK_cliente_tipo_razon_social;

ALTER TABLE departamento
    DROP CONSTRAINT FK_departamento_pais;

ALTER TABLE factura
    DROP CONSTRAINT FK_factura_pedidos;

ALTER TABLE pedidos
    DROP CONSTRAINT FK_pedidos_cliente;

ALTER TABLE prodProveedor
    DROP CONSTRAINT FK_prodProveedor;

ALTER TABLE prodfactura
    DROP CONSTRAINT FK_prodfactura_factura;

ALTER TABLE prodfactura
    DROP CONSTRAINT FK_prodfactura_productos;

ALTER TABLE prodpedidos
    DROP CONSTRAINT FK_prodpedidos_pedidos;

ALTER TABLE prodpedidos
    DROP CONSTRAINT FK_prodpedidos_productos;

ALTER TABLE prodProveedor
    DROP CONSTRAINT FK_prodproveedor_productos;

ALTER TABLE prodXCatalogo
    DROP CONSTRAINT FK_productosXcatalogo_catalogo;

ALTER TABLE productos
    DROP CONSTRAINT FK_productos_catalogo;

ALTER TABLE productos
    DROP CONSTRAINT FK_productos_tempaque;

ALTER TABLE cliente
    DROP CONSTRAINT FK_razon_social_tipo_cliente;

ALTER TABLE prodXCatalogo
    DROP CONSTRAINT FK_rodcatalogo_productos;

-- tables
DROP TABLE back_order;

DROP TABLE catalogo;

DROP TABLE categoria;

DROP TABLE ciudad;

DROP TABLE cliente;

DROP TABLE departamento;

DROP TABLE factura;

DROP TABLE pais;

DROP TABLE pedidos;

DROP TABLE prodProveedor;

DROP TABLE prodXCatalogo;

DROP TABLE prodfactura;

DROP TABLE prodpedidos;

DROP TABLE productos;

DROP TABLE proveedor;

DROP TABLE tempaque;

DROP TABLE tipo_cliente;

DROP TABLE tipo_razon_social;

-- sequences
DROP SEQUENCE Sequence_Factura;

DROP SEQUENCE Sequence_ProdFactura;

DROP SEQUENCE Sequence_pedidos;

DROP SEQUENCE Sequence_prodPedidos;

-- End of file.

