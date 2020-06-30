create or replace PROCEDURE OBTENER_XML_BACKORDER(idPedidoI IN INTEGER) IS
	xmldoc CLOB;
BEGIN

	IF EXISTEPEDIDOBACKORDER(idPedidoI) = TRUE THEN 
        
        SELECT 
        XMLELEMENT("BACKORDER", 
        XMLELEMENT("idPedido",idPedidoI),
                    XMLCONCAT(
                        XMLSEQUENCE(
                            CURSOR(
                                SELECT bac.idproducto "idProducto", bac.cantidad_pendiente "cantidadPendiente" 
                                FROM back_order bac WHERE bac.pedidos_idpedido=idpedidoI
                                    )
                                )
                            )
                ).getClobVal()
            INTO xmldoc
            FROM DUAL;
        
            dbms_xslprocessor.clob2file(xmldoc, 'DIR_JAVERIANA', 'BACKORDER_ID_PEDIDO_' || idPedidoI ||'.xml');
	ELSE
		DBMS_OUTPUT.PUT_LINE('El codigo: '|| idPedidoI || ' del pedido no tiene productos pendientes por despachar');
  	END IF;
END;