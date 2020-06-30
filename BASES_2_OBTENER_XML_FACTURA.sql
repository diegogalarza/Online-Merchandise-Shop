create or replace PROCEDURE OBTENER_XML_FACTURA(idFact IN INTEGER) IS
	xmldoc CLOB;
BEGIN

	IF EXISSTEFACTURA(idFact) = TRUE THEN 
		SELECT XMLELEMENT("Factura",
			XMLFOREST(
				f.idfactura AS "id",
				f.fecha_factura AS "fechaFactura",
				f.fecha_entrega AS "fechaEntrega",
				f.pedidos_idpedido AS "idPedido",
                f.valorTotalFactura "precioTotalSinIva",
                f.valorTotalFacturaIva "PrecioTotalConIva",
                c.nombre_cliente AS "nombreCliente",
                c.telefono AS "telefonoCliente",
                ci.nombreciudad AS "nombreCiudad",
                d.nombredepartamento AS "nombreDepartamento",
                pa.nombrepais AS "nombrePais"),
                

			XMLELEMENT("DetalleFactura",
				XMLCONCAT(
					XMLSEQUENCE(
						CURSOR(
							SELECT prod.idproducto "codigoProducto",
                            prod.nombre_producto "nombreProducto", 
                            prod.cantidad_total "cantidadProducto",
                            prod.precioUnitario "precioUnitario",
                            prod.iva "ivaUnitario"
                        
							FROM factura fac JOIN prodfactura pf ON fac.idfactura = pf.factura_idfactura
                            JOIN productos prod ON pf.productos_idproducto = prod.idproducto
                            WHERE f.idfactura = fac.idfactura
						)
					)
				)
			)
		).getClobVal()

		INTO xmldoc
        FROM factura f JOIN pedidos p  ON (f.pedidos_idpedido = p.idpedido) 
                        JOIN cliente c ON p.cliente_idcliente = c.idcliente 
                        JOIN  ciudad ci ON c.ciudad_idciudad= ci.idciudad
                        JOIN departamento d ON ci.departamento_iddepartamento= d.iddepartamento 
                        JOIN pais pa ON d.pais_idpais= pa.idpais 
                        WHERE f.idfactura = idFact;

		dbms_xslprocessor.clob2file(xmldoc, 'DIR_JAVERIANA', 'FACTURA_ID_FACTURA_' || idFact ||'.xml');
	ELSE
		DBMS_OUTPUT.PUT_LINE('El codigo: '|| idFact || ' de la factura no existe en la base de datos');
  	END IF;
END;