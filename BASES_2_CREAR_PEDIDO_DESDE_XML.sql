create or replace PROCEDURE CREAR_PEDIDO_DESDE_XML
    IS
    
    BEGIN
        INSERT INTO pedido_xml VALUES (XMLType(bfilename('DIR_JAVERIANA','CREARPEDIDODESDEXML.xml'),nls_charset_id('AL32UTF8')));
        
        INSERT INTO PEDIDO_TEMP(idPedidoXML,fecha_pedido, id_cliente, tipo_cliente,nombre_cliente
        ,telefono_,direccion_envio,ciudad_,departamento_,pais_,idCatalogo, idProducto, cantidadProducto)
            
            SELECT (SELECT extractValue(OBJECT_VALUE, '/realizar_pedido_XML/cliente/idPedidoXML') "idPedidoXML" FROM pedido_xml)
            ,x.fecha_pedido, x.id_cliente, x.tipo_cliente,x.nombre_cliente,x.telefono_,x.direccion_envio,x.ciudad_
            ,x.departamento_,x.pais_,z.idCatalogo, z.idProducto, z.cantidadProducto from pedido_xml
            
            , XMLTABLE('/realizar_pedido_XML/cliente'
            PASSING OBJECT_VALUE
            COLUMNS 
            idPedidoXML number PATH '/realizar_pedido_XML/cliente/idPedidoXML'
            
            ,fecha_pedido varchar(100) PATH '/realizar_pedido_XML/cliente/fecha_pedido'
            ,id_cliente number PATH '/realizar_pedido_XML/cliente/id_cliente'
            ,tipo_cliente number PATH '/realizar_pedido_XML/cliente/tipo_cliente'
            ,nombre_cliente varchar(100) PATH '/realizar_pedido_XML/cliente/nombre_cliente'
            ,telefono_ number PATH '/realizar_pedido_XML/cliente/telefono_'
            ,direccion_envio varchar(100) PATH '/realizar_pedido_XML/cliente/direccion_envio'
            ,ciudad_ varchar(100) PATH '/realizar_pedido_XML/cliente/ciudad_'
            ,departamento_ varchar(100) PATH '/realizar_pedido_XML/cliente/departamento_'
            ,pais_ varchar(100) PATH '/realizar_pedido_XML/cliente/pais_'

            ,productos xmltype PATH '/realizar_pedido_XML/cliente/productos') x
            , XMLTABLE('/productos'
            PASSING x.productos
            COLUMNS
            producto xmltype PATH '/realizar_pedido_XML/cliente/productos/producto') y
            , XMLTABLE('/producto'
            PASSING y.producto
            columns
            idCatalogo number path '/producto/idCatalogo'
            , idProducto number path '/producto/idProducto'
            , cantidadProducto number path '/producto/cantidadProducto'
            ) z;

            COMMIT;

end;