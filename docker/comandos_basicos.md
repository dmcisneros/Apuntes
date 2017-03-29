<article class="post-58 post type-post status-publish format-standard has-post-thumbnail hentry category-docker tag-docker-2">	
				<div class="post-inner group">
					
					<h1 class="post-title">Docker: Comandos utiles</h1>
					<p class="post-byline">by <a href="http://www.blog.teraswap.com/author/teraswapgmail-com/" title="Entradas de Teraswap" rel="author">Teraswap</a> · 09/11/2014</p>
					
										
					<div class="clear"></div>
					
					<div class="entry">	
						<div class="entry-inner">
							<p>Docker a medida que fue evolucionando fue añadiendo comandos para facilitarnos ciertas tareas pero también fue removiendo otros para agrupar esas funcionalidades dentro de otros. Un caso claro de esta situación&nbsp;es&nbsp;&nbsp;el comando&nbsp;<strong>insert </strong>(este comando es el que se usaba para copiar archivos de la maquina host a lo que es el contenedor), esta funcionalidad fue deprecada a partir de la&nbsp;versión&nbsp;0.7 y en su lugar esta funcionalidad fue reemplazada por la ejecución de una serie de comandos pre-existentes en viejas versiones-</p>
<p>Entre los comandos mas útiles se encuentran los siguientes:</p>
<ul>
<li><strong>docker info</strong> nos brinda información acerca de la cantidad de contenedores e&nbsp;imágenes&nbsp;que se encuentran actualmente en nuestra maquina como así también la versión del kernel &nbsp;de Docker que se esta ejecutando.</li>
</ul>
<ul>
<li><strong>docker images</strong> este comando nos brinda información acerca de cada una de las imágenes que se encuentran en nuestra maquina (nombre, id, espacio que ocupa, el tiempo que transcurrió desde que fue creada). Actualmente luego de ejecutar este comando se puede observar una salida como la siguiente:</li>
</ul>
<table style="height: 76px;" border="1" width="749">
<tbody>
<tr style="border-color: #000000; background-color: #7fc7af;">
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">REPOSITORY </span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">TAG</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">IMAGE ID</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">CREATED</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">VIRTUAL SIZE</span></th>
</tr>
<tr class="alt">
<td style="padding-left: 30px; ">mongo</td>
<td style="padding-left: 30px;">2.6.4</td>
<td style="padding-left: 30px;">37ee18fca8d2</td>
<td style="padding-left: 30px;">6 days ago</td>
<td style="padding-left: 30px;">391.23MB</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>
<ul>
<li><strong>docker ps</strong>&nbsp;nos indicará que&nbsp;contenedores&nbsp;están actualmente corriendo en nuestra máquina. &nbsp;Existe la posibilidad de añadir el parámetro <strong>-a</strong> a este comando el cual nos brindara la información de todos los contenedores que existen actualmente, en que estado se encuentran como así también cuando fueron apagados. Vale mencionar que por mas que los contenedores no estén corriendo siguen ocupando lugar físico por lo cual se recomienda cada cierto tiempo ejecutar el comando para eliminar los contenedores que no estan en uso. La salida de la consola al ejecutar el comando <strong>docker ps -a</strong> es la siguiente:</li>
</ul>
<table style="height: 100px;" border="1" width="752">
<tbody>
<tr style="border-color: #000000; background-color: #7fc7af;">
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">CONTAINER</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">ID IMAGE</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">COMMAND</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">CREATED</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">STATUS</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">PORTS</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">NAMES</span></th>
</tr>
<tr class="alt">
<td style="padding-left: 30px; text-align: center;">
<p style="text-align: left;">cfa5f386cf28</p>
</td>
<td style="text-align: center;">custom-postgres:lates</td>
<td style="text-align: center;">
<p style="text-align: center;">“/bin/bash”</p>
</td>
<td style="text-align: center;">7&nbsp;days ago</td>
<td style="text-align: center;">Exited (0) 7&nbsp;days ago</td>
<td style="text-align: center;">5432/tcp</td>
<td style="text-align: center;">distracted_sammet</td>
</tr>
<tr>
<td style="padding-left: 30px; text-align: center;">
<p style="text-align: left;">bd8bb41d6361</p>
</td>
<td style="text-align: center;">ubuntu:latest</td>
<td style="text-align: center;">
<p style="text-align: center;">“/bin/bash”</p>
</td>
<td style="text-align: center;">7&nbsp;days ago</td>
<td style="text-align: center;">Exited (0) 7&nbsp;days ago</td>
<td style="text-align: center;">–</td>
<td style="text-align: center;">condescending_ritchie</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>
<ul>
<li><strong><b>docker pull &lt;imagen&gt;:&lt;version&gt;</b> </strong>esto nos descargara la imagen con la version que se ha seleccionado. En caso de no indicar la versión nos descargara todas las que se encuentren disponibles, por medio de este <a title="Repositorio Docker" href="https://registry.hub.docker.com/">enlace</a> &nbsp;se pueden ver que imagenes se encuentran actualmente disponibles en el repositorio de Docker.</li>
</ul>
<ul>
<li><strong><b>docker run &lt;<strong><b>imagen</b></strong>&gt;<strong><b>:&lt;version&gt;</b></strong></b> </strong>este comando nos permite crear un contenedor a traves de una imagen. Por ejemplo para poner en funcionamiento una imagen de ubuntu por linea de comando se deberia ejecutar <em><strong>docker run -i -r ubuntu:latest /bin/bash</strong></em> esto lo que hara es primero chequear que la imagen se encuentra en el repositorio (en caso de que asi no sea la descargara) y luego lanzar la consola (esto ultimo esta relacionado con el parametro -t que se encarga de integrar la consola de la maquina host con la del contenedor).</li>
</ul>
<ul>
<li><strong><b>docker rm &lt;<strong><b>imagen</b></strong>&gt;<strong><b><strong><b>:&lt;version&gt;</b></strong></b></strong></b></strong> este comando nos permitirá eliminar un imagen. En caso de no informar la version/tag procedera a borrar todas las que tengan el mismo nombre sin importar la version.</li>
</ul>
<ul>
<li><b>docker commit &lt;<strong><b>imagen</b></strong>&gt;<strong><b><strong><b><strong><b>:&lt;version&gt;</b></strong></b></strong></b></strong></b> por medio de este comando persistimos los cambios realizados &nbsp;en un contenedor y creamos una imagen &nbsp;nueva evitando de esta manera que los cambios realizados en el contenedor se pierdan.</li>
</ul>
<ul>
<li><strong>docker save &lt;<b><strong><b>imagen</b></strong></b>&gt; &nbsp;&nbsp;&gt; &nbsp;&lt;archivo&gt;.tar </strong>con este comando podremos exportar una imagen dentro de un un archivo tar el cual puede ser importado en cualquier otra máquina.</li>
</ul>
<ul>
<li><strong><b>docker load &lt; &lt;archivo&gt;.tar </b></strong>permite cargar una imagen que se encuentra dentro del archivo tar y ser usado en el entorno de Docker.</li>
</ul>
<p>Estos son los comandos que mas se usan en Docker pero existen muchos mas los cuales pueden encontrarse en este <a title="Mas comandos" href="https://docs.docker.com/reference/commandline/cli/">enlace</a>,</p>
<p>Ademas de estos operaciones hay algunas otras que no son pero si son muy importantes de saber como realizarlas:</p>
<ul>
<li><strong>Borrado de contenedores</strong>: Si los cambios que se realizan a cada imagen no son persistidos en la maquina lo que si se guarda es una instancia de esa imagen (que como se menciona a lo largo de los post se llama contenedor) por lo cual cada cierto tiempo deberiamos borrarlas para que no ocupen espacio. Esta operacion la podemos realizar por medio de la ejecucion de <strong><b>docker rm $(sudo docker ps -a -q).</b></strong></li>
</ul>
<ul>
<li><strong>Copiado de archivos entre la maquina y el contenedor</strong>: Como ya lo hemos mencionado al principio de este post la forma de realizar esta accion ha ido cambiando a lo largo de las versiones de Docker (en un comienzo era por medio de <strong>docker insert origen destino</strong>) pero desde la version 0.7 en adelante para hacerlo hay que seguir los siguientes pasos:Averiguamos el ID del contenedor que esta corriendo actualmente para eso ejecutamos <strong>docker ps </strong>lo cual nos arroja:</li>
</ul>
<table style="height: 100px;" border="1" width="752">
<tbody>
<tr style="border-color: #000000; background-color: #7fc7af;" class="alt">
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">CONTAINER</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">ID IMAGE</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">COMMAND</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">CREATED</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">STATUS</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">PORTS</span></th>
<th style="text-align: center; vertical-align: middle;"><span style="color: #ffffff;">NAMES</span></th>
</tr>
<tr>
<td style="padding-left: 30px; text-align: center;">
<p style="text-align: left;">cfa5f386cf28</p>
</td>
<td style="text-align: center;">custom-postgres:lates</td>
<td style="text-align: center;">
<p style="text-align: center;">“/bin/bash”</p>
</td>
<td style="text-align: center;">7&nbsp;days ago</td>
<td style="text-align: center;">Exited (0) 7&nbsp;days ago</td>
<td style="text-align: center;">5432/tcp</td>
<td style="text-align: center;">distracted_sammet</td>
</tr>
</tbody>
</table>
<p style="padding-left: 30px;">
</p><p style="padding-left: 30px;">Luego con el id del contenedor hacemos un inspect para poder obtener el id con el que guarda docker esa imagen en nuestro disco duro.</p>
<p>docker cp ${origen} ${nombre_o_id_container}:${ruta_destino}</p>

<ul>
<li><strong>No usar el comando docker export</strong>: A la hora de ver la lista de comandos con los que cuenta Docker y ver el comando export instintivamente cualquiera pensaria que seria la opcion mas logica para poder exportar las imagenes que se tienen pero no lo es asi. El comando en cuestion solo sirve para hacer un export del contenedor y volverlo a cargar en caso de que algo se rompa antes de que hagamos commit de los cambios o dicho de otra forma el export sirve para exportar contenedores y cargarlos nuevamente solo el contenedor sigue corriendo.</li>
</ul>
<p>A grandes rasgos con estos comandos y haciendo estas ultimas salvedades se pueden cubrir las operaciones basicas dentro de lo que es el mundo de Docker</p>
						<div class="clear"></div>				
					</div><!--/.entry-->
					
				</div><!--/.post-inner-->	
			</article>