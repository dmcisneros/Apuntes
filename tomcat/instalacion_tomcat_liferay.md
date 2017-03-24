Descomprimir liferay-portal-6.2-ee-sp14-20151105114451508.war en /usr/share/tomcat/webapps/ROOT 

<blockquote>
<pre><strong>
mkdir /usr/share/tomcat/webapps/ROOT
cd /usr/share/tomcat/webapps/ROOT
unzip /tmp/liferay/liferay-portal-6.2-ee-sp14-20151105114451508.war -d .
</strong></pre>
</blockquote>
Descomprimir sp14-webapps.zip en /usr/share/tomcat/webapps/*
<blockquote>
<pre><strong>
cd /usr/share/tomcat/webapps
unzip /tmp/liferay/20160728/liferay/sp14-webapps.zip -d .
</strong></pre>
</blockquote>

Aquí hay que mover las subcarpetas de la nueva carpeta sp14-webapps un nivel superior y eliminar esta carpeta

<blockquote>
<pre><strong>
mv sp14-webapps/* .
rm -Rf sp14-webapps/
</strong></pre>
</blockquote>

Añadimos los ficheros portal-ext.properties, system-ext.properties y renfe-ext.properties
<blockquote>
<pre><strong>
cp *.properties /usr/share/tomcat/webapps/ROOT/WEB-INF/classes/
</strong></pre>
</blockquote>


- Es muy importante revisar completamente la configuración del fichero portal-ext.properties para configurar la base de datos, directorios. En este caso, la instalación se va a realizar en clúster directamente. Si se hubiera realizado anteriormente una instalación de un nodo, habría que eliminar las tablas "QUARTZ_" de la base de datos antes de hacer el cambio a cluster.
######################################################
## Permisos/propietarios extras para Tomcat / Liferay
######################################################

- Permisos/Propietario para la carpeta webapps
#> chown -R tomcat.tomcat /usr/share/tomcat/webapps
#> cd /usr/share/tomcat/webapps
- Ajustar permisos de ficheros : (OJO que debemos estar en la carpeta webapps).
#> find . -type f -exec chmod 644 {} \;
- Ajustar permisos de carpetas : (OJO que debemos estar en la carpeta webapps).
#> find . -type d -exec chmod 755 {} \;

- Permisos/Propietario para la carpeta lib/ext
#> chown -R tomcat.tomcat /usr/share/tomcat/lib/ext
#> chmod 755 /usr/share/tomcat/lib/ext
#> chmod 644 /usr/share/tomcat/lib/ext/*

######################################################
## AJUSTAR LOGS TOMCAT / LIFERAY
######################################################
- La carpeta por defecto de Tomcat es /usr/share/tomcat y aquí existen múltiples subdirectorios que son enlaces simbólicos. 
- En caso de ser necesario, se deberán cambiar estos enlaces por otros en rutas a filesystems con mayor espacio.

- Creamos el directorio de logs /var/apps/liferay/logs y asignamos permisos)
#> mkdir /var/apps/liferay/logs
#> chown -R root.tomcat /var/apps/liferay/logs
#> chmod 770 /var/apps/liferay/logs

- Cambiamos el enlace simbólico actual por nuestro filesystem (por defecto  logs -> /var/log/tomcat).
#> cd /usr/share/tomcat
#> rm logs
rm: remove symbolic link ‘logs’? y
#> ln -s /var/apps/liferay/logs logs
#> chown root.tomcat /usr/share/tomcat/logs

# LOGS DE LIFERAY
- Copiar los ficheros log4j.dtd, portal-log4j-ext.xml a /usr/share/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/ (y comprobar que los permisos estén ok).
#> cp log4j.dtd portal-log4j-ext.xml /usr/share/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/
- Revisar portal-log4j-ext.xml para ver que ahora la ruta del fichero de log es /var/log/tomcat/liferay.log
#> vi /usr/share/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/portal-log4j-ext.xml
(VER SU CONTENIDO)


