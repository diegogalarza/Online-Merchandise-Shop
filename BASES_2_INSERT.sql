set serveroutput on;

EXEC INSERTPAIS(1, 'Colombia');
EXEC INSERTPAIS(2,  'Argentina');
EXEC INSERTPAIS(3,  'USA');
EXEC INSERTPAIS(4,  'Reino Unido');
EXEC INSERTPAIS(5,  'España');

EXEC INSERTDEPT(1,'Valle del Cauca'  , 1);
EXEC INSERTDEPT(   2   ,'Cauca'    , 1);

EXEC    INSERTCIUDAD    (   1   ,'Cali',    1   );
EXEC    INSERTCIUDAD    (   2   ,'Palmira', 1   );
EXEC    INSERTCIUDAD    (   3   ,'Jamundi', 1   );
EXEC    INSERTCIUDAD    (   4   ,'Suarez',  2   );


EXEC    INSERTTIPOCLIENTE   (   1   ,'NATURAL', 0   );
EXEC    INSERTTIPOCLIENTE   (   2   ,'JURIDICA',    10  );

EXEC    INSERTRAZONSOCIAL   (   1   ,'PEPSI'    );
EXEC    INSERTRAZONSOCIAL   (   2   ,'MC DONALDS'   );
EXEC    INSERTRAZONSOCIAL   (   3   ,'AMAZON'   );
EXEC    INSERTRAZONSOCIAL   (   4   ,'GOOGLE' );

EXEC    INSERTCLIENTE   (   1   ,   1   ,   302825959   ,'prueba@gmail.com' ,   1   ,'PEPITO'   ,   1   );
EXEC    INSERTCLIENTE   (   2  ,   1   ,   32455545    ,'prueba1@gmail.com'    ,   2   ,'JAIME'    ,   2   );
EXEC    INSERTCLIENTE   (   3    ,   2   ,   3564265989  ,'prueba2@gmail.com'    ,   4   ,'ROBERTO'  ,   2   );
EXEC    INSERTCLIENTE   (   4 ,   1   ,   3256356 ,'prueba3@gmail.com'    ,   1   ,'DIEGO'    ,   3   );
EXEC    INSERTCLIENTE   (   5  ,   2   ,   32656493    ,'prueba4@gmail.com'    ,   2   ,'VICTOR'   ,   4   );
EXEC    INSERTCLIENTE   (   6  ,   1   ,   326468  ,'prueba5@gmail.com'    ,   2   ,'NICOLAS'  ,   4   );
EXEC    INSERTCLIENTE   (   7   ,   1   ,   32465896    ,'prueba6@gmail.com'    ,   1   ,'ANDREA'   ,   4   );
EXEC    INSERTCLIENTE   (   8   ,   2   ,   3156533 ,'prueba7@gmail.com'    ,   1   ,'NATALIA'  ,   2   );
EXEC    INSERTCLIENTE   (   9    ,   1   ,   3254896 ,'prueba8@gmail.com'    ,   2   ,'TANIA'    ,   1   );
EXEC    INSERTCLIENTE   (   10   ,   1   ,   3258225 ,'prueba9@gmail.com'    ,   4   ,'WILLIAM'  ,   2   );

EXEC    INSERTCATEGORIA (   1   ,'CONSTRUCCION' );
EXEC    INSERTCATEGORIA (   2   ,'JARDINERIA'   );
EXEC    INSERTCATEGORIA (   3   ,'TECNOLOGIA'   );
EXEC    INSERTCATEGORIA (   4   ,'COCINA'   );

EXEC    INSERTTEMPAQUE  (   1   ,'BOLSA'    ,'PLASTICO' );
EXEC    INSERTTEMPAQUE  (   2   ,'CAJA' ,'CARTON'   );
EXEC    INSERTTEMPAQUE  (   3   ,'BOLSO'    ,'DIAMANTE' );

EXEC    INSERTCATA  (   1   ,'02-02-1998'   ,'02-02-2010'   );
EXEC    INSERTCATA  (   2   ,'02-02-2010'   ,'02-02-2019'   );
EXEC    INSERTCATA  (   3   ,'02-02-2019'   ,'02-02-2025'   );

EXEC    INSERTPRODUCTOS (   1   ,'MARTILLO' ,'MARTILLO PARA MARTILLAR'  ,   14  ,   1   ,   1   ,   200 );
EXEC    INSERTPRODUCTOS (   2   ,'TIJERAS'  ,'PARA CORTAR'  ,   14  ,   2   ,   1   ,   200 );
EXEC    INSERTPRODUCTOS (   3   ,'DIAMENTE' ,'MATERIAL EXOTICO' ,   1457    ,   3   ,   1   ,   200 );
EXEC    INSERTPRODUCTOS (   4   ,'REDSTONE' , 'PARA CIRCUITOS'  ,   14  ,   3   ,   1   ,   5   );
EXEC    INSERTPRODUCTOS (   5   ,'REPETIDORES'  , 'REPITEN' ,   14  ,   3   ,   1   ,   200 );
EXEC    INSERTPRODUCTOS (   6   ,'PC'   , 'PARA JUGAR MAINCRA'  ,   14  ,   3   ,   1   ,   200 );
EXEC    INSERTPRODUCTOS (   7   ,'ZOMBIE'   , 'MATARLOS'    ,   14  ,   1   ,   1   ,   10  );


EXEC    INSERTPRODCATA  (   1   ,   15  ,   100 ,   3   ,   1   );
EXEC    INSERTPRODCATA  (   2   ,   89  ,   100 ,   3   ,   2   );
EXEC    INSERTPRODCATA  (   3   ,   29  ,   100 ,   3   ,   3   );
EXEC    INSERTPRODCATA  (   4   ,   34  ,   100 ,   3   ,   4   );
EXEC    INSERTPRODCATA  (   5   ,   8   ,   100 ,   2   ,   5   );
EXEC    INSERTPRODCATA  (   6   ,   3   ,   5   ,   1   ,   6   );
EXEC    INSERTPRODCATA  (   7   ,   16  ,   10  ,   1   ,   7   );



