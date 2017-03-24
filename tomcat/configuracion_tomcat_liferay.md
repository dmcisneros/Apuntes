1º Editamos la configuración de Tomcat para que incluya una carpeta extra de librerías en el classpath.
<blockquote>
<pre><strong>
vi /usr/share/tomcat/conf/catalina.properties
</strong></pre>
</blockquote>
Cambiar la línea 
<blockquote>
<pre><strong>
common.loader=${catalina.base}/lib,${catalina.base}/lib/*.jar,${catalina.home}/lib,${catalina.home}/lib/*.jar
</strong></pre>
</blockquote>
Por la línea 
<blockquote>
<pre><strong>
common.loader=${catalina.base}/lib,${catalina.base}/lib/*.jar,${catalina.home}/lib,${catalina.home}/lib/*.jar,${catalina.home}/lib/ext,${catalina.home}/lib/ext/*.jar
</strong></pre>
</blockquote>


2º Cambiamos la configuración de Tomcat para que encode con UTF-8 y cambiamos los puertos (puerto http el de apache para compatibilidad con autodiscovery de Liferay).
<blockquote>
<pre><strong>
vi /usr/share/tomcat/conf/server.xml
</strong></pre>
</blockquote>
- Actualizar los conectores AJP  y HTTP :
<blockquote>
<pre><strong>
<!-- A "Connector" represents an endpoint by which requests are received
         and responses are returned. Documentation at :
         Java HTTP Connector: /docs/config/http.html (blocking & non-blocking)
         Java AJP  Connector: /docs/config/ajp.html
         APR (HTTP/AJP) Connector: /docs/apr.html
         Define a non-SSL HTTP/1.1 Connector on port 8080
-->
<Connector port="20080" protocol="HTTP/1.1"
       connectionTimeout="20000"
       redirectPort="8443"
       URIEncoding="UTF-8" />
<!-- Define an AJP 1.3 Connector on port 8009 -->
<Connector port="28009" protocol="AJP/1.3" redirectPort="8443"
URIEncoding="UTF-8" />
</strong></pre>
</blockquote>



3º Editamos Engine con la ruta del nodo (node1 para lvpcri02 y node2 para lvpcri12)

<blockquote>
<pre><strong>
vi /usr/share/tomcat/conf/server.xm
</strong></pre>
</blockquote>

<blockquote>
<pre><strong>
<Engine name="Catalina" defaultHost="localhost" jvmRoute="node1">

- Añadimos deployXML="true" en el host :
<Host name="localhost"  appBase="webapps"
    unpackWARs="true" autoDeploy="true" 
deployXML="true">

</strong></pre>
</blockquote>

4º Creamos el fichero /usr/share/tomcat/conf/Catalina/localhost/ROOT.xml con el descriptor de aplicación de Liferay (aplicación root) con los permisos adecuados.

<blockquote>
<pre><strong>
vi /usr/share/tomcat/conf/Catalina/localhost/ROOT.xml
</strong></pre>
</blockquote>

<blockquote>
<pre><strong>
<Context path="" crossContext="true">

    <!-- JAAS -->

    <!--<Realm
        classNjame="org.apache.catalina.realm.JAASRealm"
        appName="PortalRealm"
        userClassNames="com.liferay.portal.kernel.security.jaas.PortalPrincipal"
        roleClassNames="com.liferay.portal.kernel.security.jaas.PortalRole"
    />-->

    <!--
    Uncomment the following to disable persistent sessions across reboots.
    -->

    <!--<Manager pathname="" />-->

    <!--
    Uncomment the following to not use sessions. See the property
    "session.disabled" in portal.properties.
    -->

    <!--<Manager className="com.liferay.support.tomcat.session.SessionLessManagerBase" />-->
</Context>
</strong></pre>
</blockquote>


6º Cambiamos owner

7º Actualizamos la configuración de arranque de tomcat : 

<blockquote>
<pre><strong>
 vi  /usr/share/tomcat/conf/tomcat.conf 
</strong></pre>
</blockquote>
<blockquote>
<pre><strong>
- Editamos SECURITY_MANAGER="false" a SECURITY_MANAGER="true"
- Y añadimos al final : 
### CUSTOM SETUP
JAVA_HOME=/usr/java/jdk1.7.0_79/

CATALINA_OPTS="-Dfile.encoding=UTF8 -Djava.net.preferIPv4Stack=true  -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false -Duser.timezone=GMT -Xmx3072m -XX:MaxPermSize=512m -Djava.security.manager -Djava.security.policy=$CATALINA_BASE/conf/catalina.policy"

- Editamos /usr/share/tomcat/conf/catalina.policy
#> vi /usr/share/tomcat/conf/catalina.policy ( Añadir al final : )
grant {
    permission java.security.AllPermission;
};

</strong></pre>
</blockquote>
