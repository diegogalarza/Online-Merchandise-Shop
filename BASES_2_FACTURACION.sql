create or replace PACKAGE PK_FACTURACION IS
    
    PROCEDURE CrearFactura(IDPED IN INTEGER);
    
    FUNCTION ConsultarProdCatalogo(IDPROD IN INTEGER) RETURN BOOLEAN;
    
    FUNCTION ConsultarCantidadProd(IDPROD IN INTEGER) RETURN INTEGER;
    
    PROCEDURE actualizarEstadoPedido(IDPED IN INTEGER);
    
    PROCEDURE actualizarCantidadCatalogo(IDPROD IN INTEGER, CANT IN INTEGER);
    
    PROCEDURE actualizarCantidadProd(IDPROD IN INTEGER, CANT IN INTEGER);
    
    PROCEDURE CrearDetalleFactura(IDFAC IN INTEGER, IDPED IN INTEGER);
END;

create or replace PACKAGE BODY PK_FACTURACION IS
    
    PROCEDURE CrearFactura(IDPED IN INTEGER) IS
    BEGIN
        IF EXISTEPEDIDO(IDPED) THEN
            DBMS_OUTPUT.PUT_LINE('EXISTE EL PEDIDO');
            INSERTFACTURA(IDPED);
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('EL PEDIDO NO ESTA REGISTRADO EN LA BASE DE DATOS');
            ROLLBACK;
        END IF;
    END;

    FUNCTION ConsultarProdCatalogo(IDPROD IN INTEGER) RETURN BOOLEAN AS
    IDTEMP INTEGER;
    BEGIN
        SELECT productos_idproducto INTO IDTEMP
        FROM catalogo C INNER JOIN prodXCatalogo PC ON(C.idcatalogo = PC.catalogo_idcatalogo)
        WHERE (to_char(sysdate,'dd-mm-yyyy') BETWEEN fecha_inicio AND fecha_final) AND (productos_idproducto = IDPROD);
        RETURN True;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN False;
    END;
    
    FUNCTION ConsultarCantidadProd(IDPROD IN INTEGER) RETURN INTEGER AS
    CANTIDADTEMPORAL INTEGER;
    BEGIN
        SELECT cantidad_catalogo
        INTO CANTIDADTEMPORAL
        FROM PRODXCATALOGO
        WHERE productos_idproducto = IDPROD;
        RETURN CANTIDADTEMPORAL;
    END;
    
    PROCEDURE actualizarEstadoPedido(IDPED IN INTEGER) IS
    BEGIN
        UPDATE pedidos
            SET estadopedido = 'FACTURADO'
        WHERE idpedido = IDPED;
    END;
    
    PROCEDURE actualizarCantidadCatalogo(IDPROD IN INTEGER, CANT IN INTEGER) IS
    BEGIN      
        UPDATE prodXCatalogo
            SET cantidad_catalogo = cantidad_catalogo - CANT
        WHERE productos_idproducto = IDPROD;
    END;
    
    PROCEDURE actualizarCantidadProd(IDPROD IN INTEGER, CANT IN INTEGER) IS
    BEGIN   
        UPDATE productos
            SET cantidad_total = cantidad_total - CANT
        WHERE idproducto = IDPROD;
    END;
    
    PROCEDURE CrearDetalleFactura(IDFAC IN INTEGER, IDPED IN INTEGER) IS
     CANTIDADPRODTEMP INTEGER;
        CURSOR PRODCLI
        IS
            SELECT productos_idproducto, cantidad_pedida, precio_total
            FROM pedidos P INNER JOIN prodpedidos PP
                ON(P.idpedido = PP.pedidos_idpedido)
            WHERE idpedido = IDPED;
    BEGIN
        IF EXISSTEFACTURA(IDFAC) AND EXISTEPEDIDO(IDPED) THEN
            FOR PROD IN PRODCLI
            LOOP
                IF ConsultarProdCatalogo(PROD.productos_idproducto) THEN -- Se valida si el producto aún sigue disponible 
                    CANTIDADPRODTEMP := ConsultarCantidadProd(PROD.productos_idproducto); -- Cantidad disponible
                    IF PROD.cantidad_pedida <= CANTIDADPRODTEMP THEN -- Validaciones de cantidad
                        
                        INSERTPRODFACTURA(PROD.precio_total*PROD.cantidad_pedida, PROD.cantidad_pedida, PROD.productos_idproducto, IDFAC); --Se FACTURO
                        actualizarEstadoPedido(IDPED);
                        actualizarCantidadCatalogo(PROD.productos_idproducto,PROD.cantidad_pedida);
                        actualizarCantidadProd(PROD.productos_idproducto,PROD.cantidad_pedida);
                        DBMS_OUTPUT.PUT_LINE('EL PRODUCTO : ' || PROD.productos_idproducto ||' FUE FACTURADO CON ' || PROD.cantidad_pedida || ' UNIDADES');
                        COMMIT;
                    ELSIF CANTIDADPRODTEMP < PROD.cantidad_pedida AND CANTIDADPRODTEMP != 0 THEN
                        
                        INSERTPRODFACTURA(PROD.precio_total*PROD.cantidad_pedida, CANTIDADPRODTEMP, PROD.productos_idproducto, IDFAC); --Se FACTURO
                        actualizarEstadoPedido(IDPED);
                        actualizarCantidadCatalogo(PROD.productos_idproducto,CANTIDADPRODTEMP);
                        actualizarCantidadProd(PROD.productos_idproducto,CANTIDADPRODTEMP);
                        DBMS_OUTPUT.PUT_LINE('EL PRODUCTO : ' || PROD.productos_idproducto ||' SOLO HAY ' || CANTIDADPRODTEMP || ' UNIDADES FUE FACTURADO CON ESA CANTIDAD');
                        COMMIT;
                    ELSIF CANTIDADPRODTEMP = 0 THEN
                        DBMS_OUTPUT.PUT_LINE('EL PRODUCTO ESTA AGOTADO');
                        ROLLBACK;
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('EL PRODUCTO NO ESTA DISPONIBLE TEMPORALMENTE');
                        ROLLBACK;
                    END IF;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('EL PRODUCTO CON EL ID: '|| PROD.productos_idproducto || ' YA NO SE ENCUENTRA DISPONIBLE');
                END IF;
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('NO ESTA REGISTRADA LA FACTURA O EL PEDIDO EN LA BASE DE DATOS');
        END IF;
    END;
END;