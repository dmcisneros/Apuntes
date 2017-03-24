Instalación desde rpm.

1º Buscar versiones
<blockquote>
<pre><strong>
yum search java | grep 'java-'
</strong></pre>
</blockquote>

2º Instalar:
<blockquote>
<pre><strong>
yum install java-1.7.0-openjdk*
</strong></pre>
</blockquote>

3º Ahora hay que seleccionar la versión de java que acabamos de instalar:
<blockquote>
<pre><strong>
sudo alternatives --config java
</strong></pre>
</blockquote>


4º En caso de que no se liste la versión que acabamos de instalar, se ejecuta el comando siguiente (y posteriormente el comando anterior): 
<blockquote>
<pre><strong>
sudo alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_79/bin/java 10
</strong></pre>
</blockquote>

5º Verificacion
<blockquote>
<pre><strong>
java -version
</strong></pre>
</blockquote>
