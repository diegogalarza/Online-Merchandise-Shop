create or replace PROCEDURE OBTENER_XML_CATALOGO(idCatalogoI IN INTEGER) IS
	xmldoc CLOB;
BEGIN

	IF EXISTECATALOGO(idCatalogoI) = TRUE THEN 
		SELECT XMLELEMENT("catalogo",
			XMLFOREST(
				c.idcatalogo AS "id",
				c.fecha_inicio AS "fechaInicioFactura",
				c.fecha_final AS "fechaFinalFactura"),
			XMLELEMENT("detallesCatalogo",
				XMLCONCAT(
					XMLSEQUENCE(
						CURSOR(
							SELECT p.nombre_producto "nombreProducto", pc.cantidad_catalogo "cantidadProducto", 
							pc.precio_catalogo "precioProducto"
							FROM catalogo cat JOIN prodXCatalogo pc  On cat.idcatalogo = pc.catalogo_idcatalogo
                            JOIN productos p ON pc.productos_idproducto = p.idproducto WHERE cat.idcatalogo = c.idcatalogo
						)
					)
				)
			)
		).getClobVal()

		INTO xmldoc
		FROM catalogo c
		WHERE c.idcatalogo = idCatalogoI;

		dbms_xslprocessor.clob2file(xmldoc, 'DIR_JAVERIANA', 'CATALOGO_ID_CATALOGO_' || idCatalogoI ||'.xml');
	ELSE
		DBMS_OUTPUT.PUT_LINE('El codigo: '|| idCatalogoI || ' del catalogo no existe en la base de datos');
  	END IF;
END;