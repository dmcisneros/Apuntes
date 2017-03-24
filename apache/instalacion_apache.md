1º Instalar desde repositorio
<blockquote>
<pre><strong>
yum install httpd
</strong></pre>
</blockquote>

2º Configuración del puerto de eschucha
<blockquote>
<pre><strong>
vi /etc/httpd/conf/httpd.conf
</strong></pre>
</blockquote>
<blockquote>
<pre><strong>
LISTEN ${NUMERO_PUERTO}
</strong></pre>
</blockquote>

3º Arrancar servicio de apache
<blockquote>
<pre><strong>
service httpd restart
</strong></pre>
</blockquote>
<blockquote>
<pre><strong>
netstat -tanup | grep httpd
</strong></pre>
</blockquote>

