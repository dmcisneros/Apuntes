<div class="article"><p>Los servidores web utilizan HTTP por defecto, que es un protocolo de texto claro. Como su nombre indica, un protocolo de texto no cifrado que no aplica ningún tipo de encriptación de los datos. Mientras el servidor web basado en HTTP es muy fácil de configurar, tiene una desventaja importante en términos de seguridad. Exponerse a cualquier ataque "man-in-the-middle" capaz de ver el contenido de los paquetes en tránsito con analizadores de paquetes cuidadosamente colocados. En caso de una vulnerabilidad, un usuario malintencionado puede incluso configurar un servidor "impostor" en la ruta de tránsito, que a continuación, se hace pasar por el servidor web de destino. En este caso, los usuarios finales pueden comunicarse realmente con el servidor impostor en lugar del servidor de destino real. De esta manera, el usuario malintencionado puede engañar a los usuarios finales para que entreguen información confidencial, como nombre de usuario y las contraseñas a través de falsos formularios cuidadosamente elaborados.
 
</p><p>Para hacer frente a este tipo de vulnerabilidades, la mayoría de los proveedores a menudo prefieren HTTPS en sus servidores web. Para los sitios donde los usuarios sólo leen el contenido y en realidad no introducen cualquier información, HTTP sigue siendo una opción viable. Sin embargo, para los sitios que mantienen la información y/o sitios donde se conectan usuarios donde obtienen servicios sensibles, HTTPS es una necesidad. HTTPS permite que una página proporcionae los siguientes servicios.
</p><ul>
<li>Asegura que todos los paquetes de tránsito hacia y desde los servidores están cifrados.</li>
</ul>
<ul>
<li>Establece la confianza con un certificado digital oficial, de manera que los servidores impostores no pueden pretender ser el servidor real.</li>
</ul>
<p>La primera cosa necesaria para la creación de HTTPS es un certificado digital. Los certificados digitales se pueden obtener de cualquiera de los métodos siguientes.</p>
<p>Los certificados autofirmados se recomiendan para fines de pruebas y proyectos personales. Los certificados autofirmados son aplicables también para los proveedores de servicios donde los usuarios del cliente son específicas y el círculo de la confianza es limitada. Los certificados autofirmados no cuestan dinero.
</p><p>Los certificados se pueden obtener de proveedores de certificados basados en la comunidad, tales como StartSSL y CACert . Estos certificados no cuestan dinero tampoco, se recomiendan para proyectos personales.
</p><p>Para proyectos comerciales donde se accede a los sitios web a nivel mundial, se recomienda comprar un certificado de una autoridad certificadora de confianza conocido. Estos certificados cuestan dinero, pero aumentan la credibilidad del proveedor de servicios web.
</p><p>Preparación
</p><p>En esta demostración, vamos a utilizar un certificado auto-firmado. Se supone que el servidor web Apache ya está instalado en CentOS. Para generar un certificado auto-firmado, se utiliza openssl. Si openssl no está instalado, se puede instalar para tal uso.
</p><blockquote>
<pre><strong># yum install mod_ssl openssl
</strong></pre>
</blockquote>
<p>Generar un certificado autofirmado
</p><p>Los siguientes comandos se pueden utilizar para generar un certificado auto-firmado.
</p><p>En primer lugar, generar una clave privada con cifrado de 2048 bits.
</p><blockquote>
<pre class="console"><strong>
# openssl genrsa -out ca.key 2048
</strong></pre>
</blockquote>
<p>Luego genere solicitud de firma de certificado (CSR).
</p><blockquote>
<pre><strong># openssl req -new -key ca.key -out ca.csr
</strong></pre>
</blockquote>
<blockquote>
<pre>You are about to be asked to enter information that will be incorporated<br>into your certificate request.<br>What you are about to enter is what is called a Distinguished Name or a DN.<br>There are quite a few fields but you can leave some blank<br>For some fields there will be a default value,<br>If you enter '.', the field will be left blank.<br>-----<br>Country Name (2 letter code) [XX]:es<br>State or Province Name (full name) []:Caceres<br>Locality Name (eg, city) [Default City]:Caceres<br>Organization Name (eg, company) [Default Company Ltd]:LinuxParty<br>Organizational Unit Name (eg, section) []:Prensa<br>Common Name (eg, your name or your server's hostname) []:LinuxParty<br>Email Address []:<span id="cloak30594"><a href="mailto:linux_party@yahoo.es">linux_party@yahoo.es</a></span><script type="text/javascript">
 //<!--
 document.getElementById('cloak30594').innerHTML = '';
 var prefix = '&#109;a' + 'i&#108;' + '&#116;o';
 var path = 'hr' + 'ef' + '=';
 var addy30594 = 'l&#105;n&#117;x_p&#97;rty' + '&#64;';
 addy30594 = addy30594 + 'y&#97;h&#111;&#111;' + '&#46;' + '&#101;s';
 document.getElementById('cloak30594').innerHTML += '<a ' + path + '\'' + prefix + ':' + addy30594 + '\'>' + addy30594+'<\/a>';
 //-->
 </script><br><br>Please enter the following 'extra' attributes<br>to be sent with your certificate request<br>A challenge password []:passworddeprueba<br>An optional company name []:ExtreHost<br><br></pre>
</blockquote>
<p>Por último, generar un certificado auto-firmado de tipo X 509, que tiene una validez de 365 keys.
</p><blockquote>
<pre class="console"><strong># openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt
</strong></pre>
</blockquote>
<p>Una vez creado el certificado, copia los archivos en los directorios necesarios.
</p><blockquote>
<pre># cp ca.crt /etc/pki/tls/certs/<br>
# cp ca.key /etc/pki/tls/private/<br>
# cp ca.csr /etc/pki/tls/private/
</pre>
</blockquote>
<p><strong>Configuración del servidor Web Apache</strong>
</p><p>Ahora que el certificado está listo, es hora de verlo en funcionamiento.
</p><p>En primer lugar, edite el archivo de configuración siguiente.
</p><div class="console">&nbsp;</div>
<blockquote>
<pre><strong># vim /etc/httpd/conf.d/ssl.conf <br></strong><br>### overwrite the following parameters ###
SSLCertificateFile /etc/pki/tls/certs/ca.crt
SSLCertificateKeyFile /etc/pki/tls/private/ca.key

### The following parameter does not need to be modified in case of a self-signed certificate. ###
### If you are using a real certificate, you may receive a certificate bundle. The bundle is added using the following parameters ###
SSLCertificateChainFile /etc/pki/tls/certs/example.com.ca-bundle
</pre>
</blockquote>
<p>A continuación, reinicie el servicio httpd para que los cambios surtan efecto.
</p><blockquote>
<pre class="console"><strong># service httpd restart
</strong></pre>
</blockquote>
<p>El servidor web ya está listo para usar HTTPS.
</p><p>Ajuste de máquinas virtuales
</p><p>El Servidor web Apache se puede configurar para alojar múltiples sitios web. Estos sitios se declaran como hosts virtuales en el archivo de configuración httpd. Por ejemplo, supongamos que nuestro servidor web Apache tendrá 1un sitio "virtual-web.example.com", y todos los archivos del sitio se almacenan en el directorio <tt>/var/www/html/virtual-web</tt>
</p><p>Para el host virtual, la configuración típica para HTTP se vería así.
</p><blockquote>
<pre><strong># vim /etc/httpd/conf/httpd.conf</strong></pre>
</blockquote>
<blockquote>
<pre>NameVirtualHost *:80

&lt;VirtualHost *:80&gt;
    ServerAdmin <span id="cloak38786"><a href="mailto:email@example.com">email@example.com</a></span><script type="text/javascript">
 //<!--
 document.getElementById('cloak38786').innerHTML = '';
 var prefix = '&#109;a' + 'i&#108;' + '&#116;o';
 var path = 'hr' + 'ef' + '=';
 var addy38786 = '&#101;m&#97;&#105;l' + '&#64;';
 addy38786 = addy38786 + '&#101;x&#97;mpl&#101;' + '&#46;' + 'c&#111;m';
 document.getElementById('cloak38786').innerHTML += '<a ' + path + '\'' + prefix + ':' + addy38786 + '\'>' + addy38786+'<\/a>';
 //-->
 </script>
    DocumentRoot /var/www/html/virtual-web
    ServerName virtual-web.example.com
&lt;/VirtualHost&gt;
</pre>
</blockquote>
<p>Tenemos que crear una definición similar para HTTPS también.
</p><blockquote>
<pre><strong>
# vim /etc/httpd/conf/httpd.conf
</strong>
NameVirtualHost *:443

&lt;VirtualHost *:443&gt;
	SSLEngine on
	SSLCertificateFile /etc/pki/tls/certs/ca.crt
	SSLCertificateKeyFile /etc/pki/tls/private/ca.key
	&lt;Directory /var/www/html/virtual-web&gt;
		AllowOverride All
	&lt;/Directory&gt;
	ServerAdmin <span id="cloak97727"><a href="mailto:email@example.com">email@example.com</a></span><script type="text/javascript">
 //<!--
 document.getElementById('cloak97727').innerHTML = '';
 var prefix = '&#109;a' + 'i&#108;' + '&#116;o';
 var path = 'hr' + 'ef' + '=';
 var addy97727 = '&#101;m&#97;&#105;l' + '&#64;';
 addy97727 = addy97727 + '&#101;x&#97;mpl&#101;' + '&#46;' + 'c&#111;m';
 document.getElementById('cloak97727').innerHTML += '<a ' + path + '\'' + prefix + ':' + addy97727 + '\'>' + addy97727+'<\/a>';
 //-->
 </script>
DocumentRoot /var/www/html/virtual-web
ServerName virtual-web.example.com
&lt;/VirtualHost&gt;
</pre>
</blockquote>
<p>Para cada host virtual, etiquetas similares deberían ser definidas. Después de agregar los hosts virtuales, el servicio web se reinicie.
</p><blockquote>
<pre class="console"># service httpd restart
</pre>
</blockquote>
<p>Ahora las máquinas virtuales están listos para usar HTTPS también. Opcional: Forzar Apache Web Server a utilizar siempre HTTPS
</p><p>Si, por alguna razón, usted decide utilizar siempre HTTPS en el servidor web, usted tendrá que redirigir todas las solicitudes HTTP entrantes (puerto 80) hacia el puerto HTTPS (puerto 443).
</p><p>El Servidor web Apache puede ser fácilmente ajustado para hacer esto.
</p><p>1. Forzar el Sitio principal solamente
</p><p>Para forzar el sitio principal para usar siempre HTTPS, modificamos el fichero de configuración httpd.
</p><blockquote># vim /etc/httpd/conf/httpd.conf</blockquote>
<p>&nbsp;
</p><blockquote>
<pre>ServerName www.example.com:80
Redirect permanent / https://www.example.com
</pre>
</blockquote>
<blockquote>
<pre># service httpd restart
</pre>
</blockquote>
<p>&nbsp;
</p><p>2. Forzar Hosts virtuales
</p><p>Si desea forzar HTTPS en algún host virtual, así, la definición de HTTP se puede reescribir como sigue.
</p><blockquote>
<pre><strong>
# vim /etc/httpd/conf/httpd.conf
</strong>
&lt;VirtualHost *:80&gt;
    ServerName virtual-web.example.com
    Redirect permanent / https://virtual-web.example.com/
&lt;/VirtualHost&gt;

# Service httpd restart</pre>
</blockquote>
<p>En resumen, HTTPS siempre se recomienda para los sitios donde se conectan los usuarios. Esto mejora la seguridad tanto en el servidor y los usuarios que lo utilizan. Los certificados pueden ser obtenidos en diversos medios, como los auto-firmado, impulsado por la comunidad o incluso las autoridades comerciales. El administrador debe ser prudente al seleccionar el tipo de certificado que se utilizará.
