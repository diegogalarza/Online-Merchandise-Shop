-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-05-02 02:21:05.349

-- tables
-- Table: back_order
CREATE TABLE back_order (
    idbackorder integer  NOT NULL,
    pedidos_idpedido integer  NOT NULL,
    cantidad_pendiente integer  NOT NULL,
    idproducto integer  NOT NULL,
    CONSTRAINT back_order_pk PRIMARY KEY (idbackorder)
) ;

-- Table: catalogo
CREATE TABLE catalogo (
    idcatalogo integer  NOT NULL,
    fecha_inicio date  NOT NULL,
    fecha_final date  NOT NULL,
    CONSTRAINT catalogo_pk PRIMARY KEY (idcatalogo)
) ;

CREATE INDEX ix_fechaInicio 
on catalogo 
(fecha_inicio ASC)
;

CREATE INDEX ix_fechaFin 
on catalogo 
(fecha_final ASC)
;

-- Table: categoria
CREATE TABLE categoria (
    idcategoria integer  NOT NULL,
    nombre_categoria varchar2(20)  NOT NULL,
    CONSTRAINT categoria_pk PRIMARY KEY (idcategoria)
) ;

-- Table: ciudad
CREATE TABLE ciudad (
    idciudad integer  NOT NULL,
    nombreciudad varchar2(20)  NOT NULL,
    departamento_iddepartamento integer  NOT NULL,
    CONSTRAINT ciudad_pk PRIMARY KEY (idciudad)
) ;

CREATE INDEX ix_IdDepartamento 
on ciudad 
(departamento_iddepartamento ASC)
;

-- Table: cliente
CREATE TABLE cliente (
    idcliente integer  NOT NULL,
    tipo_cliente_idtipocliente integer  NOT NULL,
    telefono integer  NOT NULL,
    correo varchar2(30)  NOT NULL,
    ciudad_idciudad integer  NOT NULL,
    nombre_cliente varchar2(30)  NOT NULL,
    idrazon_social integer  NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (idcliente)
) ;

CREATE INDEX ix_idTipoCliente 
on cliente 
(tipo_cliente_idtipocliente ASC)
;

CREATE INDEX ix_idCiudad 
on cliente 
(ciudad_idciudad ASC)
;

CREATE INDEX ix_idRazonSocial 
on cliente 
(idrazon_social ASC)
;

-- Table: departamento
CREATE TABLE departamento (
    iddepartamento integer  NOT NULL,
    nombredepartamento varchar2(20)  NOT NULL,
    pais_idpais integer  NOT NULL,
    CONSTRAINT departamento_pk PRIMARY KEY (iddepartamento)
) ;

CREATE INDEX ix_idPais 
on departamento 
(pais_idpais ASC)
;

-- Table: factura
CREATE TABLE factura (
    idfactura integer  NOT NULL,
    fecha_factura date  NOT NULL,
    fecha_entrega date  NOT NULL,
    pedidos_idpedido integer  NOT NULL,
    CONSTRAINT factura_pk PRIMARY KEY (idfactura)
) ;

CREATE INDEX ix_idPedido 
on factura 
(pedidos_idpedido ASC)
;

-- Table: pais
CREATE TABLE pais (
    idpais integer  NOT NULL,
    nombrepais varchar2(20)  NOT NULL,
    CONSTRAINT pais_pk PRIMARY KEY (idpais)
) ;

-- Table: pedidos
CREATE TABLE pedidos (
    idpedido integer  NOT NULL,
    fechapedido timestamp  NOT NULL,
    estadopedido varchar2(15)  NOT NULL,
    cliente_idcliente integer  NOT NULL,
    CONSTRAINT pedidos_pk PRIMARY KEY (idpedido)
) ;

ALTER TABLE pedidos ADD CONSTRAINT check_estadoPedido CHECK(estadopedido IN ('GENERADO','PROCESADO','FACTURADO'));

CREATE INDEX ix_idCliente 
on pedidos 
(cliente_idcliente ASC)
;

-- Table: prodProveedor
CREATE TABLE prodProveedor (
    idprodproveedores integer  NOT NULL,
    proveedor_idproveedor integer  NOT NULL,
    productos_idproducto integer  NOT NULL,
    CONSTRAINT prodProveedor_pk PRIMARY KEY (idprodproveedores)
) ;

CREATE INDEX ix_idProveedor 
on prodProveedor 
(proveedor_idproveedor ASC)
;

CREATE INDEX ix_idProductoProv 
on prodProveedor 
(productos_idproducto ASC)
;

-- Table: prodXCatalogo
CREATE TABLE prodXCatalogo (
    idprodcatalogo integer  NOT NULL,
    precio_catalogo number(20,2)  NOT NULL,
    cantidad_catalogo integer  NOT NULL,
    catalogo_idcatalogo integer  NOT NULL,
    productos_idproducto integer  NOT NULL,
    CONSTRAINT prodXCatalogo_pk PRIMARY KEY (idprodcatalogo)
) ;

CREATE INDEX ix_idCatalogo 
on prodXCatalogo 
(catalogo_idcatalogo ASC)
;

CREATE INDEX ix_idProducto 
on prodXCatalogo 
(productos_idproducto ASC)
;

-- Table: prodfactura
CREATE TABLE prodfactura (
    idprodfactura integer  NOT NULL,
    precio_facturado number(30,2)  NOT NULL,
    cantidad_facturado number(20,2)  NOT NULL,
    productos_idproducto integer  NOT NULL,
    factura_idfactura integer  NOT NULL,
    CONSTRAINT prodfactura_pk PRIMARY KEY (idprodfactura)
) ;

CREATE INDEX ix_idProductoProd 
on prodfactura 
(productos_idproducto ASC)
;

CREATE INDEX ix_idFactura 
on prodfactura 
(factura_idfactura ASC)
;

-- Table: prodpedidos
CREATE TABLE prodpedidos (
    idprodpedidos integer  NOT NULL,
    precio_total integer  NOT NULL,
    cantidad_pedida integer  NOT NULL,
    productos_idproducto integer  NOT NULL,
    pedidos_idpedido integer  NOT NULL,
    CONSTRAINT prodpedidos_pk PRIMARY KEY (idprodpedidos)
) ;

CREATE INDEX ix_idProductoProdPed 
on prodpedidos 
(productos_idproducto ASC)
;

CREATE INDEX ix_idPedidoProdPed 
on prodpedidos 
(pedidos_idpedido ASC)
;

-- Table: productos
CREATE TABLE productos (
    idproducto integer  NOT NULL,
    nombre_producto varchar2(25)  NOT NULL,
    descripcion_producto varchar2(60)  NOT NULL,
    peso_producto integer  NOT NULL,
    catalogo_idcategoria integer  NOT NULL,
    tempaque_idtempaque integer  NOT NULL,
    cantidad_total integer  NOT NULL,
    CONSTRAINT productos_pk PRIMARY KEY (idproducto)
) ;

CREATE INDEX ix_idCategoria 
on productos 
(catalogo_idcategoria ASC)
;

CREATE INDEX ix_idEmpaque 
on productos 
(tempaque_idtempaque ASC)
;

-- Table: proveedor
CREATE TABLE proveedor (
    idproveedor integer  NOT NULL,
    nombre_proveedor varchar2(30)  NOT NULL,
    correo_proveedor varchar2(50)  NOT NULL,
    telefono_proveedor integer  NOT NULL,
    CONSTRAINT proveedor_pk PRIMARY KEY (idproveedor)
) ;

-- Table: tempaque
CREATE TABLE tempaque (
    idtempaque integer  NOT NULL,
    nombre_empaque varchar2(15)  NOT NULL,
    material varchar2(25)  NOT NULL,
    CONSTRAINT tempaque_pk PRIMARY KEY (idtempaque)
) ;

-- Table: tipo_cliente
CREATE TABLE tipo_cliente (
    idtipocliente integer  NOT NULL,
    tipocliente varchar2(20)  NOT NULL,
    descuento integer  NOT NULL,
    CONSTRAINT tipo_cliente_pk PRIMARY KEY (idtipocliente)
) ;

-- Table: tipo_razon_social
CREATE TABLE tipo_razon_social (
    idrazon_social integer  NOT NULL,
    razon_social varchar2(20)  NOT NULL,
    CONSTRAINT tipo_razon_social_pk PRIMARY KEY (idrazon_social)
) ;

-- foreign keys
-- Reference: FK_back_order_pedidos (table: back_order)
ALTER TABLE back_order ADD CONSTRAINT FK_back_order_pedidos
    FOREIGN KEY (pedidos_idpedido)
    REFERENCES pedidos (idpedido);

-- Reference: FK_ciudad_departamento (table: ciudad)
ALTER TABLE ciudad ADD CONSTRAINT FK_ciudad_departamento
    FOREIGN KEY (departamento_iddepartamento)
    REFERENCES departamento (iddepartamento);

-- Reference: FK_cliente_ciudad (table: cliente)
ALTER TABLE cliente ADD CONSTRAINT FK_cliente_ciudad
    FOREIGN KEY (ciudad_idciudad)
    REFERENCES ciudad (idciudad);

-- Reference: FK_cliente_tipo_razon_social (table: cliente)
ALTER TABLE cliente ADD CONSTRAINT FK_cliente_tipo_razon_social
    FOREIGN KEY (idrazon_social)
    REFERENCES tipo_razon_social (idrazon_social);

-- Reference: FK_departamento_pais (table: departamento)
ALTER TABLE departamento ADD CONSTRAINT FK_departamento_pais
    FOREIGN KEY (pais_idpais)
    REFERENCES pais (idpais);

-- Reference: FK_factura_pedidos (table: factura)
ALTER TABLE factura ADD CONSTRAINT FK_factura_pedidos
    FOREIGN KEY (pedidos_idpedido)
    REFERENCES pedidos (idpedido);

-- Reference: FK_pedidos_cliente (table: pedidos)
ALTER TABLE pedidos ADD CONSTRAINT FK_pedidos_cliente
    FOREIGN KEY (cliente_idcliente)
    REFERENCES cliente (idcliente);

-- Reference: FK_prodProveedor (table: prodProveedor)
ALTER TABLE prodProveedor ADD CONSTRAINT FK_prodProveedor
    FOREIGN KEY (proveedor_idproveedor)
    REFERENCES proveedor (idproveedor);

-- Reference: FK_prodfactura_factura (table: prodfactura)
ALTER TABLE prodfactura ADD CONSTRAINT FK_prodfactura_factura
    FOREIGN KEY (factura_idfactura)
    REFERENCES factura (idfactura);

-- Reference: FK_prodfactura_productos (table: prodfactura)
ALTER TABLE prodfactura ADD CONSTRAINT FK_prodfactura_productos
    FOREIGN KEY (productos_idproducto)
    REFERENCES productos (idproducto);

-- Reference: FK_prodpedidos_pedidos (table: prodpedidos)
ALTER TABLE prodpedidos ADD CONSTRAINT FK_prodpedidos_pedidos
    FOREIGN KEY (pedidos_idpedido)
    REFERENCES pedidos (idpedido);

-- Reference: FK_prodpedidos_productos (table: prodpedidos)
ALTER TABLE prodpedidos ADD CONSTRAINT FK_prodpedidos_productos
    FOREIGN KEY (productos_idproducto)
    REFERENCES productos (idproducto);

-- Reference: FK_prodproveedor_productos (table: prodProveedor)
ALTER TABLE prodProveedor ADD CONSTRAINT FK_prodproveedor_productos
    FOREIGN KEY (productos_idproducto)
    REFERENCES productos (idproducto);

-- Reference: FK_productosXcatalogo_catalogo (table: prodXCatalogo)
ALTER TABLE prodXCatalogo ADD CONSTRAINT FK_productosXcatalogo_catalogo
    FOREIGN KEY (catalogo_idcatalogo)
    REFERENCES catalogo (idcatalogo);

-- Reference: FK_productos_catalogo (table: productos)
ALTER TABLE productos ADD CONSTRAINT FK_productos_catalogo
    FOREIGN KEY (catalogo_idcategoria)
    REFERENCES categoria (idcategoria);

-- Reference: FK_productos_tempaque (table: productos)
ALTER TABLE productos ADD CONSTRAINT FK_productos_tempaque
    FOREIGN KEY (tempaque_idtempaque)
    REFERENCES tempaque (idtempaque);

-- Reference: FK_razon_social_tipo_cliente (table: cliente)
ALTER TABLE cliente ADD CONSTRAINT FK_razon_social_tipo_cliente
    FOREIGN KEY (tipo_cliente_idtipocliente)
    REFERENCES tipo_cliente (idtipocliente);

-- Reference: FK_rodcatalogo_productos (table: prodXCatalogo)
ALTER TABLE prodXCatalogo ADD CONSTRAINT FK_rodcatalogo_productos
    FOREIGN KEY (productos_idproducto)
    REFERENCES productos (idproducto);

-- sequences
-- Sequence: Sequence_Factura
CREATE SEQUENCE Sequence_Factura
      INCREMENT BY 1
      MINVALUE 1
      MAXVALUE 999999
      START WITH 1
      NOCACHE
      CYCLE;

-- Sequence: Sequence_ProdFactura
CREATE SEQUENCE Sequence_ProdFactura
      INCREMENT BY 1
      MINVALUE 1
      MAXVALUE 999999
      START WITH 1
      NOCACHE
      CYCLE;

-- Sequence: Sequence_pedidos
CREATE SEQUENCE Sequence_pedidos
      INCREMENT BY 1
      MINVALUE 1
      MAXVALUE 100000000
      START WITH 1
      NOCACHE
      CYCLE;

-- Sequence: Sequence_prodPedidos
CREATE SEQUENCE Sequence_prodPedidos
      INCREMENT BY 1
      MINVALUE 1
      MAXVALUE 99999
      START WITH 1
      NOCACHE
      CYCLE;

-- End of file.

