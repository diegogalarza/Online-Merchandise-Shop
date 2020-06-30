create or replace PACKAGE PK_PEDIDOS IS
    
    PROCEDURE CrearPedido(IDCLIENTE IN INTEGER);
    
    FUNCTION ConsultarProdCatalogo(IDPROD IN INTEGER) RETURN BOOLEAN;
    
    FUNCTION ConsultarCantidadProd(IDPROD IN INTEGER) RETURN INTEGER;
    
    FUNCTION ConsultarPrecioProd(IDPROD IN INTEGER) RETURN INTEGER;
    
    PROCEDURE actualizarEstadoPedido(IDPED IN INTEGER);
    
    PROCEDURE CrearDetallePedido(IDPEDIDO IN INTEGER, IDPROD IN INTEGER, CANT IN INTEGER);
END;

create or replace PACKAGE BODY PK_PEDIDOS IS
    
    PROCEDURE CrearPedido(IDCLIENTE IN INTEGER) IS
    IDPEDIDO INTEGER;
    BEGIN
        IF EXISTECLIENTE(IDCLIENTE) THEN
            DBMS_OUTPUT.PUT_LINE('EXISTE CLIENTE');
            INSERTPEDIDO('GENERADO',IDCLIENTE);
            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('EL CLIENTE NO ESTA REGISTRADO EN LA BASE DE DATOS');
            ROLLBACK;
        END IF;
    END CrearPedido;
    
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
    
    FUNCTION ConsultarPrecioProd(IDPROD IN INTEGER) RETURN INTEGER AS
    PRECIOPRODTEMP INTEGER;
    BEGIN
        SELECT precio_catalogo
        INTO PRECIOPRODTEMP
        FROM PRODXCATALOGO
        WHERE productos_idproducto = IDPROD;
        RETURN PRECIOPRODTEMP;
    END;
    
    PROCEDURE actualizarEstadoPedido(IDPED IN INTEGER) IS
    BEGIN
        UPDATE pedidos
            SET estadopedido = 'PROCESADO'
        WHERE idpedido = IDPED;
    END;
    
    PROCEDURE CrearDetallePedido(IDPEDIDO IN INTEGER, IDPROD IN INTEGER, CANT IN INTEGER) IS
    CANTIDADTEMPORALPROD INTEGER;
    PRECIOTEMPORALPROD INTEGER;
    BEGIN
        IF EXISTEPEDIDO(IDPEDIDO) THEN -- SE VALIDA SI EXISTE EL PEDIDO
            
            IF ConsultarProdCatalogo(IDPROD) THEN -- SE VALIDA SI EXISTE EL PRODUCTO DENTRO DEL CATALOGO DISPONIBLE 
                CANTIDADTEMPORALPROD := ConsultarCantidadProd(IDPROD);
                PRECIOTEMPORALPROD := ConsultarPrecioProd(IDPROD);
                
                IF CANT <= CANTIDADTEMPORALPROD THEN -- Validaciones de cantidad
                    INSERTPRODPEDIDOS(PRECIOTEMPORALPROD, CANT, IDPROD, IDPEDIDO);
                    actualizarEstadoPedido(IDPEDIDO);
                    COMMIT;
                ELSIF CANTIDADTEMPORALPROD < CANT AND CANTIDADTEMPORALPROD != 0 THEN
                    DBMS_OUTPUT.PUT_LINE('EL PRODUCTO : ' || IDPROD ||' SOLO HAY ' || CANTIDADTEMPORALPROD || ' UNIDADES FUE REGISTRADO CON ESA CANTIDAD');
                    INSERTPRODPEDIDOS(PRECIOTEMPORALPROD, CANTIDADTEMPORALPROD, IDPROD, IDPEDIDO) ;
                    actualizarEstadoPedido(IDPEDIDO);
                    COMMIT;
                ELSIF CANTIDADTEMPORALPROD = 0 THEN
                    DBMS_OUTPUT.PUT_LINE('EL PRODUCTO ESTA AGOTADO');
                ELSE
                    DBMS_OUTPUT.PUT_LINE('EL PRODUCTO NO ESTA DISPONIBLE TEMPORALMENTE');
                END IF;
            
            ELSE
                DBMS_OUTPUT.PUT_LINE('EL PRODUCTO NO ESTA DISPONIBLE TEMPORALMENTE');
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('EL PEDIDO NO ESTA REGISTRADO EN LA BASE DE DATOS');
        END IF;
    END CrearDetallePedido;

END;
