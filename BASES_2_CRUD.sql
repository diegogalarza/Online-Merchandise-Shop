CREATE OR REPLACE PROCEDURE INSERTPAIS (PASIID IN INTEGER , PAISNAME IN VARCHAR2 ) AS 
BEGIN
  INSERT INTO pais(idpais,nombrepais)
            VALUES(PASIID, PAISNAME);
        DBMS_OUTPUT.PUT_LINE('Insertado Pais: ' || PASIID || ' : ' || PAISNAME);
        
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('El pais ya existe');
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Se presento un error insertando el pais');
        
END INSERTPAIS;

CREATE OR REPLACE PROCEDURE INSERTDEPT(IDDEPT IN INTEGER, NOMBRE IN VARCHAR2, IDPAIS IN INTEGER ) AS 
BEGIN
    INSERT INTO DEPARTAMENTO (iddepartamento,nombredepartamento, pais_idpais)
        VALUES (IDDEPT,NOMBRE, IDPAIS);
    DBMS_OUTPUT.PUT_LINE('Insertado Departamento: '|| IDDEPT || ' ' || NOMBRE );
    

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' El Departamento ya existe');
  
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el Departamento ');
  
END INSERTDEPT;

CREATE OR REPLACE PROCEDURE INSERTCIUDAD (IDCIUDAD IN INTEGER , NOMBRE IN VARCHAR2 , IDDEPT IN INTEGER ) AS 
BEGIN
  INSERT INTO CIUDAD (idciudad,nombreciudad,departamento_iddepartamento)
    VALUES (IDCIUDAD,NOMBRE, IDDEPT);
    DBMS_OUTPUT.PUT_LINE('Insertada ciudad: '|| IDCIUDAD || ' ' || NOMBRE);
    

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' La ciudad ya existe');
  
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando la ciudad ');
  
END INSERTCIUDAD;

CREATE or REPLACE PROCEDURE INSERTTIPOCLIENTE 
(
  IDTIPO IN INTEGER 
, TIPO IN VARCHAR2 
, DESCUENTO IN INTEGER 
) AS 
BEGIN
  INSERT INTO TIPO_CLIENTE (idtipocliente,tipocliente,descuento)
    VALUES (IDTIPO,TIPO, DESCUENTO);
    DBMS_OUTPUT.PUT_LINE('Insertado tipo de cliente: '|| IDTIPO || ' ' || TIPO);
    

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' El tipo de cliente ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el tipo de ciudad ');
END INSERTTIPOCLIENTE;

CREATE OR REPLACE PROCEDURE INSERTRAZONSOCIAL 
(
  IDRAZON IN INTEGER 
, RAZON IN VARCHAR2 
) AS 
BEGIN
  INSERT INTO tipo_razon_social (idrazon_social,razon_social)
    VALUES (IDRAZON,RAZON);
    DBMS_OUTPUT.PUT_LINE('Insertada razon social: '|| IDRAZON || ' ' || RAZON);
    

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' La razon social ya existe');
  
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando la razon social ');
  
END INSERTRAZONSOCIAL;

CREATE OR REPLACE PROCEDURE INSERTCLIENTE 
(
  IDCLIENTE IN INTEGER 
, TIPO_CLIENTE IN INTEGER 
, TELEFONO IN INTEGER 
, CORREO IN VARCHAR2 
, IDCIUDAD IN INTEGER 
, NOMBRE IN VARCHAR2 
, IDRAZON IN INTEGER 
) AS 
BEGIN
  INSERT INTO cliente (idcliente,tipo_cliente_idtipocliente,telefono, correo,ciudad_idciudad,nombre_cliente,idrazon_social)
    VALUES (IDCLIENTE,TIPO_CLIENTE, TELEFONO,CORREO,IDCIUDAD,NOMBRE,IDRAZON);
    DBMS_OUTPUT.PUT_LINE('Insertado Cliente: '|| IDCLIENTE || ' ' || NOMBRE);

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' El cliente ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el cliente ');
END INSERTCLIENTE;

create or replace NONEDITIONABLE PROCEDURE INSERTPEDIDO(ESTADOPEDIDO IN VARCHAR2 , IDCLIENTE IN INTEGER ) AS 
BEGIN
  INSERT INTO pedidos(idpedido, fechapedido, estadopedido, cliente_idcliente)
    VALUES(SEQUENCE_PEDIDOS.nextval , to_char(sysdate,'dd-mon-yyyy HH:MM'), ESTADOPEDIDO, IDCLIENTE);
  DBMS_OUTPUT.PUT_LINE('EL PEDIDO FUE CREADO EXITOSAMENTE, ID PEDIDO: ' || SEQUENCE_PEDIDOS.CURRVAL || ' ESTADO PEDIDO: ' || ESTADOPEDIDO );

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' El cliente ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el pedido ');
END INSERTPEDIDO;




CREATE OR REPLACE FUNCTION EXISTEPEDIDO (IDPEDIDO IN INTEGER ) RETURN BOOLEAN AS 
idpedidoTemporal INTEGER;
BEGIN
  SELECT idpedido
  INTO idpedidoTemporal
  FROM PEDIDOS
  WHERE idpedido = IDPEDIDO;
  RETURN True;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END EXISTEPEDIDO;

CREATE OR REPLACE FUNCTION EXISTECLIENTE 
(
  IDCL IN VARCHAR2 
) RETURN BOOLEAN AS 
IDTEMPORAL INTEGER;
BEGIN
  SELECT idcliente
  INTO IDTEMPORAL
  FROM CLIENTE
  WHERE idcliente = IDCL;
  RETURN True;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END EXISTECLIENTE;

CREATE OR REPLACE PROCEDURE INSERTCATEGORIA 
(
  IDCAT IN INTEGER 
, NOMBRECAT IN VARCHAR2 
) AS 
BEGIN
  INSERT INTO CATEGORIA (idcategoria,nombre_categoria)
    VALUES (IDCAT,NOMBRECAT);
    DBMS_OUTPUT.PUT_LINE('Insertada Categoria: '|| IDCAT || ' ' || NOMBRECAT);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' La categoria ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando la categoria ');
END INSERTCATEGORIA;

CREATE OR REPLACE PROCEDURE INSERTTEMPAQUE 
(
  IDEM IN INTEGER 
, NOMBRE IN VARCHAR2 
, MATERIAL IN VARCHAR2 
) AS 
BEGIN
  INSERT INTO TEMPAQUE (idtempaque,nombre_empaque,material)
    VALUES (IDEM,NOMBRE,MATERIAL);
    DBMS_OUTPUT.PUT_LINE('Insertado Empaque: '|| IDEM || ' ' || NOMBRE || ' ' || MATERIAL);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' EL empaque ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el empaque ');
END INSERTTEMPAQUE;

CREATE OR REPLACE PROCEDURE INSERTCATA 
(
  IDCAT IN INTEGER 
, FECHAIN IN DATE 
, FECHAFIN IN DATE 
) AS 
BEGIN
  INSERT INTO CATALOGO (idcatalogo,fecha_inicio,fecha_final)
    VALUES (IDCAT,FECHAIN,FECHAFIN);
    DBMS_OUTPUT.PUT_LINE('Insertado catalogo: '|| IDCAT || ' ' || FECHAIN || ' ' || FECHAFIN);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' EL CATALOGO ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el catalogo ');
END INSERTCATA;

CREATE OR REPLACE PROCEDURE INSERTPRODUCTOS 
(
  IDPROD IN INTEGER 
, NOMBRE IN VARCHAR2 
, DESCRIP IN VARCHAR2 
, PESO IN INTEGER 
, IDCAT IN INTEGER 
, IDEMPA IN INTEGER 
, CANTIDAD IN INTEGER 
) AS 
BEGIN
  INSERT INTO PRODUCTOS (idproducto,nombre_producto,descripcion_producto, peso_producto, catalogo_idcategoria, tempaque_idtempaque,cantidad_total)
    VALUES (IDPROD,NOMBRE,DESCRIP,PESO,IDCAT,IDEMPA,CANTIDAD);
    DBMS_OUTPUT.PUT_LINE('Insertado Producto: '|| IDPROD || ' ' || NOMBRE || ' ' || CANTIDAD);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' EL prodcuto ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el producto ');
END INSERTPRODUCTOS;

CREATE OR REPLACE PROCEDURE INSERTPRODCATA 
(
  IDPRODCATA IN INTEGER 
, PRECIOCAT IN NUMBER 
, CANTCAT IN INTEGER 
, IDCAT IN INTEGER 
, IDPROD IN INTEGER 
) AS 
BEGIN
  INSERT INTO PRODXCATALOGO (idprodcatalogo,precio_catalogo,cantidad_catalogo, catalogo_idcatalogo, productos_idproducto)
    VALUES (IDPRODCATA,PRECIOCAT,CANTCAT,IDCAT,IDPROD);
    DBMS_OUTPUT.PUT_LINE('Insertado Producto: '|| IDPROD || ' ' || CANTCAT || ' ' || IDCAT);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' EL prodcuto ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el producto ');
END INSERTPRODCATA;


CREATE OR REPLACE PROCEDURE INSERTPRODPEDIDOS 
(
  PRECIO IN INTEGER 
, CANTIDAD IN INTEGER 
, IDPROD IN INTEGER 
, IDPEDIDO IN INTEGER 
) AS 
BEGIN
  INSERT INTO prodpedidos (idprodpedidos,precio_total,cantidad_pedida, productos_idproducto, pedidos_idpedido)
    VALUES (SEQUENCE_PRODPEDIDOS.nextval,PRECIO,CANTIDAD,IDPROD,IDPEDIDO);
    DBMS_OUTPUT.PUT_LINE('Insertado detalle pedido : '|| SEQUENCE_PRODPEDIDOS.CURRVAL || ' CANTIDAD: ' || CANTIDAD || ' PRECIO : ' || PRECIO || ' ID PEDIDO : ' || SEQUENCE_PRODPEDIDOS.CURRVAL);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' EL Detalle ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el Detalle ');
END INSERTPRODPEDIDOS;

CREATE OR REPLACE PROCEDURE DELETEPRODPEDIDOS 
(
  IDPROPED IN INTEGER 
) AS 
BEGIN
  DELETE FROM prodpedidos WHERE idprodpedidos = IDPROPED;
  DBMS_OUTPUT.PUT_LINE(' Borrado Exitosamente ');
EXCEPTION
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error borrando el Detalle ');
END DELETEPRODPEDIDOS;

CREATE OR REPLACE PROCEDURE INSERTFACTURA (IDPED IN INTEGER ) AS 
BEGIN
    INSERT INTO factura(idfactura, fecha_factura, fecha_entrega, pedidos_idpedido)
    VALUES(SEQUENCE_FACTURA.nextval , to_char(sysdate,'dd-mon-yyyy'), to_char(sysdate + 15,'dd-mon-yyyy'), IDPED);
  DBMS_OUTPUT.PUT_LINE('LA FACTURA FUE CREADA EXITOSAMENTE, ID FACTURA: ' || SEQUENCE_FACTURA.CURRVAL || '  IDPED: ' || IDPED );

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' La factura ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando la factura ');
END INSERTFACTURA;

CREATE OR REPLACE FUNCTION EXISSTEFACTURA 
(
  IDFAC IN INTEGER 
) RETURN BOOLEAN AS 
IDFACTEMP INTEGER;
BEGIN
    SELECT idfactura
    INTO IDFACTEMP
    FROM factura
    WHERE idfactura = IDFAC;
  RETURN True;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN False;
END EXISSTEFACTURA;


CREATE OR REPLACE PROCEDURE INSERTPRODFACTURA 
(
  PRECIO IN INTEGER 
, CANTIDAD IN INTEGER 
, IDPROD IN INTEGER 
, IDFAC IN INTEGER 
) AS 
BEGIN
  INSERT INTO prodfactura(idprodfactura, precio_facturado, cantidad_facturado, productos_idproducto,factura_idfactura)
    VALUES(SEQUENCE_PRODFACTURA.nextval , PRECIO, CANTIDAD, IDPROD,IDFAC );
  DBMS_OUTPUT.PUT_LINE('EL DETALLE DE FACTURA FUE CREADO EXITOSAMENTE, ID DETALLE: ' || SEQUENCE_PRODFACTURA.CURRVAL);

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
  DBMS_OUTPUT.PUT_LINE(' El detalle de factura ya existe');
WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(' Se presento un error insertando el detalle de factura ');
END INSERTPRODFACTURA;

CREATE OR REPLACE PROCEDURE READPEDIDO(IDPED IN INTEGER) AS 
CURSOR REPORTE
IS
SELECT P.fechapedido, P.estadopedido ,
        p.cliente_idcliente, pr.idproducto,
        pr.nombre_producto, PP.cantidad_pedida, PP.precio_total 
FROM pedidos P INNER JOIN prodpedidos PP
        ON(P.idpedido = PP.pedidos_idpedido)
    INNER JOIN productos pr
        ON(PP.productos_idproducto = pr.idproducto)
WHERE idpedido = IDPED;
BEGIN
FOR DATO IN REPORTE
LOOP
    DBMS_OUTPUT.PUT_LINE('/*----------------------------PEDIDO A DIEGOS SHOP----------------------------*/');
    DBMS_OUTPUT.PUT_LINE('FECHA PEDIDO: ' || DATO.fechapedido || ' ESTADO PEDIDO: ' || DATO.estadopedido || ' IDENTIFICACION CLIENTE: ' || DATO.cliente_idcliente); 
    DBMS_OUTPUT.PUT_LINE( 'ID PRODUCTO: ' || DATO.idproducto || ' NOMBRE PRODUCTO: ' || DATO.nombre_producto || ' CANTIDAD PEDIDA: ' || DATO.cantidad_pedida|| ' PRECIO TOTAL: ' || DATO.precio_total);
END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(' El pedido no esta registrado en la base de datos');
END READPEDIDO;

