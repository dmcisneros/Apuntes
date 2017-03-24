Instalación desde rpm.

1º Debemos subir el fichero jdk-7u79-linux-x64.rpm a una ruta conocida y luego ejecutar como root el comando siguiente : 
<blockquote>
<pre><strong>
rpm -ivh jdk-7u79-linux-x64.rpm
</strong></pre>
</blockquote>


2º Ahora hay que seleccionar la versión de java que acabamos de instalar:
<blockquote>
<pre><strong>
sudo alternatives --config java
</strong></pre>
</blockquote>


3º En caso de que no se liste la versión que acabamos de instalar, se ejecuta el comando siguiente (y posteriormente el comando anterior): 
<blockquote>
<pre><strong>
sudo alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_79/bin/java 10
</strong></pre>
</blockquote>

4º Verificacion
<blockquote>
<pre><strong>
java -version
</strong></pre>
</blockquote>
