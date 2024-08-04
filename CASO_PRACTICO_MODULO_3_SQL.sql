--CASO PRACTICO MODULO 3 SQL- DIPLOMADO EN ANALITICA Y CIENCIA DE DATOS UDC
--TABLAS FUENTE: menu_items, order_details
/*b) Explorar la tabla “menu_items” para conocer los productos del menú.
1.- Realizar consultas para contestar las siguientes preguntas:*/
--● Encontrar el número de artículos en el menú.
  	Select count(*) as "Cant. de Artículos" From menu_items;  

--● ¿Cuál es el artículo menos caro y el más caro en el menú?
  	Select   item_name,price, 'El menos caro' as Resultado from menu_items where price= (Select Min(price) From menu_items)
  	Union	
  	Select   item_name,price, 'El más caro'  as Resultado from menu_items where price= (Select Max(price) From menu_items)
  	Order by price;	

--● ¿Cuántos platos americanos hay en el menú?
  	Select count(*) as "Cant. de platos Americanos" From menu_items Where category='American';

--● ¿Cuál es el precio promedio de los platos?
  	Select Avg(price) as "precio promedio" From menu_items;

/*c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.
1.- Realizar consultas para contestar las siguientes preguntas:*/
--● ¿Cuántos pedidos únicos se realizaron en total?
  	Select COUNT(DISTINCT ORDER_ID) as "cant. de pedidos únicos" 
	From order_details;
    
--● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
  	select  order_id,count(item_id) as "Num. de Artículos" 
	From order_details
	Group by order_id
	Order by 2 DESC
	LIMIT 5;
	
--● ¿Cuándo se realizó el primer pedido y el último pedido?
	select 	min(order_date+order_time) as "Primer pedido" , 
			max(order_date+order_time) as "Último pedido"  
	from order_details;    

--● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
	Select 	count(DISTINCT order_id) as "Cant. de pedidos 2023-01-01 - 2023-01-05" 
	From order_details 
	Where order_date between '2023-01-01' and '2023-01-05';

/*d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
1.- Realizar un left join entre entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items).*/
	Select * from order_details
	Left join menu_items on item_id = menu_item_id;

/*e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las
preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas. El
objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del
restaurante en el lanzamiento de su nuevo menú. Para ello, crea tus propias consultas y
utiliza los resultados obtenidos para llegar a estas conclusiones.*/

--CONSULTAR LOS 5 PRODUCTOS ESTRELLA MÁS VENDIDOS----------
	select item_name,count(item_id)  from order_details 
	left join menu_items on item_id = menu_item_id
	group by item_name order by 2 desc LIMIT 5;
	/*Punto Clave 1.- Incrementar y garantizar el insumo de ingredientes de estos platillos
                      ya que son los más solicitados
	  Punto Clave 2.- Posibilidad de reducir costos al comprar por mayoreo los ingredientes de estos platillos más solicitados		
	  Punto Clave 3.- Incrementar en un % el precio de estos productos estrella para maximizar ganancias
					   ya que son  garantía de venta			            
	*/		
--CONSULTAR LAS CATEGORIAS/REGION DE PRODUCTOS MÁS VENDIDOS (SABORES DEL MUNDO QUE MAS HAN GUSTADO A LA GENTE)----------
	select category,count(item_id)  from order_details 
	left join menu_items on item_id = menu_item_id
	group by category order by 2 desc;
	/*Punto Clave 4.- La Comida asiática es la de mayor preferencia por la gente proponer incrementar más el menú de esta 
					  categoría e incrementar precios para maximizar ganancias
	*/			

--ANALISIS DE VENTAS DE PLATILLOS "ASIATICOS"----------
	select item_name,count(item_id)  from order_details 
	left join menu_items on item_id = menu_item_id
	WHERE category='Asian'
	group by item_name 	
	order by 2 desc;
	/*Punto Clave 4.1.- Potstickers a pesar de ser asiático tiene poca preferencia, revisar y analizar 
						si es una cuestión de sabor/precio o proponer quitarlo del menú
	*/				

--CONSULTAR LOS 5 PRODUCTOS MENOS VENDIDOS -----------
	select item_name,price,count(item_id)  from order_details 
	left join menu_items on item_id = menu_item_id
	where not item_id is null
	group by item_id,item_name,price order by 3 ASC LIMIT 5;
	/*Punto Clave 5.-Analizar/Revisar si la baja preferencia se debe a un problema de Sabor/Precio
						o ver la posibilidad de quitar platillo del menú
	*/	

