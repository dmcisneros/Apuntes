<div  style="
    overflow-x: hidden;"><p><strong>Jenkins Liferay Pipeline:</strong></p>
<p>En los &uacute;ltimos meses tras asistir a algunos eventos y charlas sobre integraci&oacute;n continua conoc&iacute; la flexibilidad y los beneficios que puede aportar los pipelines como alternativa al uso de flow en jenkins y la implementaci&oacute;n de groovy declarativos. En los proyectos en los que normalmente participo principalmente detect&eacute; que podr&iacute;amos disminuir el tiempo de compilaci&oacute;n y despliegue haciendo uso de algunas caracter&iacute;sticas de los pipelines como pueden ser la ejecuci&oacute;n de los procesos en paralelo. A continuaci&oacute;n voy a detallar el uso que hacemos de jenkins en liferay 7.</p>
<p>Contenedores:</p>
<p style="padding-left: 30px;"><img style="height: 30%;" src="sources/slave.png" /></p>
<ul>
<li><strong>Jenkins-maestro:</strong></li>
</ul>
<pre>https://hub.docker.com/_/jenkins/ docker run --name myjenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home jenkins</pre>
<ul>
<li><strong>Jenkins-slave:</strong> Hemos partido de un centos7 como base y a&ntilde;adido algunas configuraciones para poder enlazar desde el contenedor jenkins-master. Dependiendo de cada proyecto que se utilice &eacute;ste esclavo requerir&aacute; unas aplicaciones u otras, en nuestro caso generamos el dockerfile (A&ntilde;adir el dockerfile y los recursos asociados).</li>
</ul>
<p>Una vez que tengamos arrancados los dos contenedores podremos configurar nuestro jenkins y su esclavo:</p>
<ul>
<li><strong>A&ntilde;adir el nodo esclavo de jenkins: </strong></li>
</ul>
<p>Administrar Jenkins -&gt; Administrar nodos -&gt; A&ntilde;adir nodo:</p>
<p><img src="sources/jenkins_slave_01.png" />&nbsp;</p>
<ul>
<li><strong>Creaci&oacute;n de job del tipo pipeline parametrizable:</strong> Vamos a crear dos jobs que se ejecutar&aacute;n autom&aacute;ticamente, cada uno de ellos se ejecutar&aacute; de manera autom&aacute;tica cuando hagamos un push en la rama de develop y cuando realicemos un push de un nuevo tag con las versiones de Release candidate o release final. Para ambos la configuraci&oacute;n es similar salvo el trigger que los llama y el jenkinsfile declarativo que se invoca. En nuestro vamos a realizar todos los steps en el jenkinsfile declarativo pero podr&iacute;amos haber optado por otras estrat&eacute;gias como podr&iacute;a ser crear los jobs parametrizables independientemente para poder invocarlos individualmente o a todos desde un pipeline. Los jobs que utilizaremos para la segunda opci&oacute;n ser&iacute;an los siguientes:
<ul>
<li><strong>Task_Update_Repository:</strong> Actualizar&aacute; el c&oacute;digo del repositorio.</li>
<li><strong>Task_QA:</strong>  Ejecuci&oacute;n de an&aacute;lisis est&aacute;tico de c&oacute;digo.</li>
<li><strong>Task_Sonar:</strong>  Env&iacute;o de c&oacute;digo a analizar por sonar.</li>
<li><strong>Task_Junit:</strong>  Ejecuci&oacute;n de pruebas unitarias</li>
<li><strong>Task_Build_Layouts:</strong>  Compilaci&oacute;n con gulp de layouts</li>
<li><strong>Task_Build_Modules:</strong>  Compilaci&oacute;n con gradle de m&oacute;dulos</li>
<li><strong>Task_Build_Themes:</strong>  Compilaci&oacute;n gulp</li>
<li><strong>Task_Upload_Nexus:</strong>  Subida a nexus</li>
<li><strong>Task_Deploy:</strong>  Invocaci&oacute;n de .sh para el despliegue al servidor liferay Continuando con la opci&oacute;n que vamos a utilizar de un jenkinsFile declarativo desde un repositorio de control de versiones que contenga todos los steps como conjunto debemos en a&ntilde;adir un job del tipo pipeline:</li>
</ul>
</li>
</ul>
<p style="padding-left: 30px;"><img src="sources/jenkins_pipeline_01.png" /></p>
<p style="padding-left: 30px;">Los parametros de entrada que utilizaremos ser&aacute;n los siguientes:</p>
<ul>
<li style="padding-left: 30px;">URL_GIT</li>
<li style="padding-left: 30px;">BRANCH</li>
<li style="padding-left: 30px;">NEXUS_SNAPSHOTS</li>
</ul>
<p style="padding-left: 30px;">A&ntilde;adiendo la configuraci&oacute;n para obtener el pipeline del repositorio:</p>
<p style="padding-left: 30px;"><img src="sources/jenkins_pipeline_02.png" /></p>
<ul>
<li style="padding-left: 30px;">JENKINS FILE BUILD: Se subira a nexus una versi&oacute;n snapshot del artefacto <a href="Jenkinsfile">VER</a></li>
<li style="padding-left: 30px;">JENKINS FILE RELEASE PREPARE: Se subira a nexus una versi&oacute;n -RC o final del artefacto <a href="JenkinsfileReleasePrepare">VER</a>&nbsp;</li>
</ul>
<p style="padding-left: 30px;">Las etapas por las que pasa el pipeline declarativo son las siguientes:</p>
<ul>
<li style="padding-left: 30px;">LIF_Download: Descarga del c&oacute;digo fuente</li>
<li style="padding-left: 30px;">Stage_Compile: Compilaci&oacute;n con un proceso paralelo de m&oacute;dulos, layouts y theme.</li>
<li style="padding-left: 30px;">Stage_QUALITY: Validaci&oacute;n de la calidad del c&oacute;digo con sonar, pmd, checkstyle y pruebas unitarias.</li>
<li style="padding-left: 30px;">LIF_Upload_Artifactory: Subida de los artefactos a un repositorio(en nuestro caso nexus).</li>
</ul>
<p style="padding-left: 30px;"><img src="sources/jenkins_pipeline_03.png" /></p>
<p style="padding-left: 30px;">Una vez ejecutadas todas las etapas del pipeline tendremos todos los artefactos subidos al nexus para poder desplegarlos en los entornos dependiendo de la versi&oacute;n que indiquemos en un job que definiremos a continuaci&oacute;n.</p>
<p style="padding-left: 30px;"><img src="sources/jenkins_pipeline_04.png" /></p>
<ul>
<li><strong>Job de despliegue:</strong> Para los despliegues en nuestros entornos hemos creido conveniente que siempre se ejecute manualmente, aunque o bien podr&iacute;a planificarse o podr&iacute;a incluirse el despliegue en el propio jenkinsfile declarativo. Los par&aacute;metros de entrada del job ser&iacute;an los siguientes:
<ul>
<li><strong>BUILD_ENVIRONMENT:</strong>  Entorno en el que desplegar local development integration preproduction production</li>
<li><strong>BUILD_VERSION:</strong>  versi&oacute;n de los artefactos a desplegar</li>
<li><strong>NEXUS_URL:</strong>  Repositorio de artefactos</li>
<li><strong>NEXUS_USER:</strong>  Usuario de nexus</li>
<li><strong>NEXUS_PASSWORD:</strong>  Password de nexus</li>
<li><strong>PROJECT_REPOSITORY:</strong>  Ruta de liferay home El script que invocaremos ser&aacute; el siguiente:</li>
</ul>
</li>
</ul>
<pre>/home/jenkins/scripts/deploy/deployInSlave.sh ${BUILD_ENVIRONMENT} ${BUILD_VERSION} ${NEXUS_URL} ${NEXUS_USER} ${NEXUS_PASSWORD} ${PROJECT_REPOSITORY}</pre>
<p style="padding-left: 30px;">El contenido del .sh se puede visualizar <a href="deployInSlave.sh">aqu&iacute;</a></p>
<p style="padding-left: 30px;"><img src="sources/jenkins_deploy_01.png" /></p>
</div>