<h1 style="margin-left: 40px;">Liferay Performance Tuning&nbsp;</h1>

<p style="margin-left: 40px;">Cuando se realiza la configuración de un cluster en liferay hay que afinar el performance que ofrece a distintos niveles del cluster. A continuación se mostrarán distintos puntos en los que podemos mejorar la respuesta del portal.</p>
<p style="margin-left: 40px; text-align: center;">
<img alt="" width="800px" src="images/cluster.png" /></p>

<h2 style="margin-left: 40px;">1. Apache</h2>

<h3 style="margin-left: 40px;">1.1 Activar Keep Alive en httpd.conf</h3>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);">Éste parámetro permite más de 1 petición por conexión TCP. MaxKeepAliveRequest indica el máximo número de peticiones permitidas por conexiones persistentes.</p>

<p style="margin-left: 40px;"><code>KeepAlive ON</code></p>

<p style="margin-left: 40px;"><code>MaxKeepAliveRequests 100</code></p>

<p style="margin-left: 40px;"><code>KeepAliveTimeout 15</code></p>

<h3 style="margin-left: 40px;">1.2 Activar&nbsp;MPM worker</h3>

<p style="margin-left: 40px;">Éste módulo implementa un servidor híbrido multiproceso/multihilo. Es capáz de servir un numero grande de peticiones con menos recursos del sistema,&nbsp;</p>

<p style="margin-left: 40px;">(a) Activar&nbsp;linea&nbsp;en /etc/sysconfig/httpd</p>

<p style="margin-left: 40px;"><code>HTTPD=/usr/sbin/httpd.worker</code></p>

<h3 style="margin-left: 40px;">1.3 Configurar MPM worker</h3>

<p style="margin-left: 40px;">/etc/httpd/conf/httpd.conf</p>

<p style="margin-left: 40px;"><code>StartServers 2</code></p>

<p style="margin-left: 40px;"><code>ServerLimit 32</code></p>

<p style="margin-left: 40px;"><code>MaxClients 800</code></p>

<p style="margin-left: 40px;"><code>MinSpareThreads 25</code></p>

<p style="margin-left: 40px;"><code>MaxSpareThreads 75</code></p>

<p style="margin-left: 40px;"><code>ThreadsPerChild 25</code></p>

<p style="margin-left: 40px;"><code>MaxRequestsPerChild 0</code></p>

<h3 style="margin-left: 40px;">1.4 Change LogLevel</h3>

<p style="margin-left: 40px;">(a) /etc/httpd/conf/httpd.conf</p>

<p style="margin-left: 40px;"><code>LogLevel error</code></p>

<p style="margin-left: 40px;">(b) /etc/httpd/conf.d/ssl.conf</p>

<p style="margin-left: 40px;"><code>LogLevel error</code></p>

<p style="margin-left: 40px;">1.5 Configure ETag</p>

<p style="margin-left: 40px;">(a) /etc/httpd/conf/httpd.conf</p>

<p style="margin-left: 40px;"><code>FileETag none</code></p>

<p style="margin-left: 40px;">1.6 Usar&nbsp;mod_jk en lugar de mod_proxy para conectar al tomcat desde Apache.</p>

<p style="margin-left: 40px;">Asegurar que el modulo JK está habilitado y configurado en el apache. El uso de mod_jk es recomendado al tener el mod_proxy problemas de rendimiento.&nbsp;</p>

<p style="margin-left: 40px;">(a) /etc/httpd/conf/httpd.conf</p>

<p style="margin-left: 40px;"><code>Include conf/mod-jk.conf</code></p>

<p style="margin-left: 40px;">(b) /etc/httpd/conf/worker.properties</p>

<p style="margin-left: 40px;"><code>worker.list=loadbalancer,status #JVM Host Settings</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.port=8009</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.host=IPAddress</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.type=ajp13</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.lbfactor=1</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.socket_timeout=60</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.socket_keepalive=1</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.connection_pool_timeout=60</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.ping_mode=A</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.ping_timeout=20000</code></p>

<p style="margin-left: 40px;"><code>worker.jvm1.connect_timeout=20000</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.port=8009</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.host=IPAddress</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.type=ajp13</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.lbfactor=1</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.socket_timeout=60</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.socket_keepalive=1</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.connection_pool_timeout=60</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.ping_mode=A</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.ping_timeout=20000</code></p>

<p style="margin-left: 40px;"><code>worker.jvm2.connect_timeout=20000</code></p>

<p style="margin-left: 40px;"># Load-balancing behaviour</p>

<p style="margin-left: 40px;"><code>worker.loadbalancer.method=B</code></p>

<p style="margin-left: 40px;"><code>worker.loadbalancer.type=lb</code></p>

<p style="margin-left: 40px;"><code>worker.loadbalancer.balance_workers=jvm1,jvm2</code></p>

<p style="margin-left: 40px;"><code>worker.loadbalancer.sticky_session=1</code></p>

<p style="margin-left: 40px;"># Status worker for managing load balancer</p>

<p style="margin-left: 40px;"><code>worker.status.type=status</code></p>

<p style="margin-left: 40px;">(c) /etc/httpd/conf.d/mod-jk.conf</p>

<p style="margin-left: 40px;"><code>LoadModule jk_module modules/mod_jk.so</code></p>

<p style="margin-left: 40px;"><code>JkWorkersFile conf/worker.properties</code></p>

<p style="margin-left: 40px;"><code>JkLogFile logs/mod_jk.log</code></p>

<p style="margin-left: 40px;"><code>JkLogLevel error</code></p>

<p style="margin-left: 40px;"><code>JkLogStampFormat “[%a %b %d %H:%M:%S %Y]”</code></p>

<p style="margin-left: 40px;"><code>JkUnMount /liferay-theme/js/*.js loadbalancer</code></p>

<p style="margin-left: 40px;"><code>JkUnMount /liferay-theme/css/*.css loadbalancer</code></p>

<p style="margin-left: 40px;"><code>JkUnMount /liferay-theme/images/*.gif loadbalancer</code></p>

<p style="margin-left: 40px;"><code>JkUnMount /liferay-theme/images/*.png loadbalancer</code></p>

<p style="margin-left: 40px;"><code>JkUnMount /liferay-theme/images/*.jpg loadbalancer</code></p>

<p style="margin-left: 40px;"><code>JkUnMount /liferay-theme/images/*.ico loadbalancer</code></p>

<p style="margin-left: 40px;"><code>JkUnMount /html/js/barebone.jsp loadbalancer</code></p>

<p style="margin-left: 40px;"><code>JkUnMount /html/js/everything.jsp loadbalancer</code></p>

<p style="margin-left: 40px;"><code>JkMount /* loadbalancer</code></p>

<h3 style="margin-left: 40px;">1.7 Gzip en Apache</h3>

<p style="margin-left: 40px;">Asegurar que el módulo deflate está activo</p>

<p style="margin-left: 40px;">(a) /etc/httpd/conf/httpd.conf</p>

<p style="margin-left: 40px;"><code>SetOutputFilter DEFLATE</code></p>

<p style="margin-left: 40px;"><code>SetEnvIfNoCase Request_URI \.(?:exe|t?gz|zip|bz2|sit|rar)$ no-gzip dont-vary</code></p>

<p style="margin-left: 40px;"><code>SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png)$ no-gzip dont-vary</code></p>

<h3 style="margin-left: 40px;">1.8 Caché en Apache</h3>

<p style="margin-left: 40px;">Asegurar que el módulo de expirity está activo, hemos activado el cachéo para las jsp</p>

<p style="margin-left: 40px;">(a) /etc/httpd/conf/httpd.conf</p>

<p style="margin-left: 40px;"><code># Turn on Expires and set default to 0</code></p>

<p style="margin-left: 40px;"><code>ExpiresActive On</code></p>

<p style="margin-left: 40px;"><code>ExpiresDefault A0</code></p>

<p style="margin-left: 40px;"><code># Set up caching on media files for 1 year (forever?)</code></p>

<p style="margin-left: 40px;"><code>&lt;filesmatch “\.(flv|ico|pdf|avi|mov|ppt|doc|mp3|wmv|wav)$”=””&gt;</code></p>

<p style="margin-left: 40px;"><code>ExpiresDefault A29030400</code></p>

<p style="margin-left: 40px;"><code>Header append Cache-Control “public”</code></p>

<p style="margin-left: 40px;"><code># Set up caching on media files for 1 week</code></p>

<p style="margin-left: 40px;"><code>&lt;filesmatch “\.(gif|jpg|jpeg|png|swf)$”=””&gt;</code></p>

<p style="margin-left: 40px;"><code>ExpiresDefault A604800</code></p>

<p style="margin-left: 40px;"><code>Header append Cache-Control “public”</code></p>

<p style="margin-left: 40px;"><code># Set up caching on media files for 1 week</code></p>

<p style="margin-left: 40px;"><code>&lt;filesmatch “\.(xml|txt|html|js|jsp|css)$”=””&gt;</code></p>

<p style="margin-left: 40px;"><code>ExpiresDefault A604800</code></p>

<p style="margin-left: 40px;"><code>Header append Cache-Control “proxy-revalidate”</code></p>

<p style="margin-left: 40px;"><code># Force no caching for dynamic files</code></p>

<p style="margin-left: 40px;"><code>&lt;filesmatch “\.(php|cgi|pl|htm)$”=””&gt;</code></p>

<p style="margin-left: 40px;"><code>ExpiresActive Off</code></p>

<p style="margin-left: 40px;"><code>Header set Cache-Control “private, no-cache, no-store, proxy-revalidate, no-transform” Header set Pragma “no-cache”</code></p>

<p style="margin-left: 40px;">&nbsp;</p>

<h2 style="margin-left: 40px;">2. Tomcat</h2>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);">Cada petición de entrada al servidor de aplicaciones consumirá un hilo del worker durante la petición. Cuando no haya hilos disponibles para procesar la petición, ésta será encolada a la espera de la siguiente hilo disponible. En un sistema que tenga un tunning correcto el número de hilos en la pila debería ser relativamente balanceado con el número total de peticiones concurrentes sin haber un número significante de hilos. Liferay recomienda configurar inicialmente 50 hilos y posteriormente monitorizar el comportamiento y si el tiempo de respuesta de una página es superior a 2-3 segundos elevarlo.</p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">(a) $CATALINA_HOME /conf/server.xml</em></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">acceptCount=”100″</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">connectionTimeout=”20000″</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">enableLookups=”false”</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">maxThreads=”450″</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">minSpareThreads=”50″</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">port=”8009″</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">protocol=”AJP/1.3″</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">redirectPort=”8443″</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">disableUploadTimeout=”true”</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><code><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">maxHttpHeaderSize=”8192″/&gt;</em></code></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);">&nbsp;</p>

<h2 style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);">2.2 Tunning de la JVM recomendada por&nbsp;Liferay.</h2>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">(a) $CATALINA_HOME /bin/setenv.sh</em></p>

<p style="box-sizing: border-box; margin: 0.85em 0px 0.85em 40px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);"><em style="box-sizing: border-box; margin: 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant: inherit; font-weight: inherit; font-stretch: inherit; font-size: inherit; line-height: inherit; font-family: inherit; vertical-align: baseline;">J<code>AVA_OPTS=”$JAVA_OPTS -Dfile.encoding=UTF8 -Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false -Duser.timezone=GMT -server -d64 -XX:NewSize=2048m -XX:MaxNewSize=2048m -Xms6144m -Xmx6144m -XX:PermSize=200m -XX:MaxPermSize=512m -XX:SurvivorRatio=20 -XX:TargetSurvivorRatio=90 -XX:MaxTenuringThreshold=15 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:ParallelGCThreads=8 -XX:ReservedCodeCacheSize=512m -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+CMSCompactWhenClearAllSoftRefs -XX:CMSInitiatingOccupancyFraction=85 -XX:+CMSScavengeBeforeRemark -XX:+CMSConcurrentMTEnabled -XX:ParallelCMSThreads=2 -XX:+UseCompressedOops -XX:+DisableExplicitGC -XX:-UseBiasedLocking -XX:+BindGCTaskThreadsToCPUs -XX:+UseFastAccessorMethods -Djava.net.preferIPv4Stack=true -Djava.rmi.server.hostname=10.154.14.71 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.port=5000 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -XX:+UseLargePages”</code></em></p>

<div>
<h3 style="margin-left: 40px;">2.3 Eliminar Aplicaciones que no se utilizarán del&nbsp;Tomcat</h3>

<p style="margin-left: 40px;">Liferay tiene multitud de módulos que si tenemos la certeza que no serán utilizados se recomienda eliminarlos para mejorar el performance.</p>

<h3 style="margin-left: 40px;">2.4 Optimize Database Thread pool</h3>

<p style="margin-left: 40px;">El pool de conexión de la base de datos suele ser el 20-30 % del tamaño del pool. El pool de conexiones provee una conexión en cualquier momento que la aplicación necesite consumir algún dato de la base de datos. Si el tamaño es muy pequeño las peticiones se encolarán esperando que se liberen conexiones de la base de datos. Sin embargo si definimos valores muy grandes estariamos perdiendo recursos en las conexiones abiertas.&nbsp;</p>

<p style="margin-left: 40px;">(a) $CATALINA_HOME /conf/context.xml</p>

<p style="margin-left: 40px;"><code>testOnBorrow=”true”</code></p>

<p style="margin-left: 40px;"><code>testWhileIdle=”true”</code></p>

<p style="margin-left: 40px;"><code>numTestsPerEvictionRun=”10″</code></p>

<p style="margin-left: 40px;"><code>timeBetweenEvictionRunsMillis=”1800000″</code></p>

<p style="margin-left: 40px;"><code>minEvictableIdleTimeMillis=”3600000″</code></p>

<p style="margin-left: 40px;"><code>logAbandoned=”true”</code></p>

<p style="margin-left: 40px;"><code>removeAbandonedTimeout=”20″</code></p>

<p style="margin-left: 40px;"><code>removeAbandoned=”true”</code></p>

<p style="margin-left: 40px;"><code>url=”jdbc:mysql://192.168.100.1/db_name?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8&amp;useFastDateParsing=false”</code></p>

<p style="margin-left: 40px;"><code>driverClassName=”com.mysql.jdbc.Driver”</code></p>

<p style="margin-left: 40px;"><code>username=”user”</code></p>

<p style="margin-left: 40px;"><code>password=”password”</code></p>

<p style="margin-left: 40px;"><code>maxWait=”20000″</code></p>

<p style="margin-left: 40px;"><code>maxIdle=”120″</code></p>

<p style="margin-left: 40px;"><code>minIdle=”3″</code></p>

<p style="margin-left: 40px;"><code>validationQuery=”select 1″</code></p>

<p style="margin-left: 40px;"><code>maxActive=”750″</code></p>

<p style="margin-left: 40px;"><code>type=”javax.sql.DataSource”</code></p>

<p style="margin-left: 40px;"><code>auth=”Container”</code></p>

<p style="margin-left: 40px;"><code>name=”jdbc/LiferayPool” /&gt;</code></p>

<h2 style="margin-left: 40px;">3. Liferay</h2>

<h3 style="margin-left: 40px;">3.1 Optimizar el&nbsp; web.xml</h3>

<h3 style="margin-left: 40px;">3.2 Portal-ext.properties</h3>

<p style="margin-left: 40px;">jdbc.default.jndi.name=jdbc/LiferayPool</p>

<p style="margin-left: 40px;">theme.images.fast.load = true</p>

<p style="margin-left: 40px;">theme.css.fast.load = true</p>

<p style="margin-left: 40px;">layout.template.cache.enable = true</p>

<p style="margin-left: 40px;">javascript.fast.load = true</p>

<p style="margin-left: 40px;">com.liferay.portal.servlet.filters.gzip.GZipFilter=false</p>

<p style="margin-left: 40px;">com.liferay.portal.servlet.filters.strip.StripFilter=false</p>

<p style="margin-left: 40px;">com.liferay.portal.servlet.filters.sso.cas.CASFilter=false</p>

<p style="margin-left: 40px;">com.liferay.portal.servlet.filters.sso.ntlm.NtlmFilter=false</p>

<p style="margin-left: 40px;">com.liferay.portal.servlet.filters.sso.opensso.OpenSSOFilter=false</p>

<p style="margin-left: 40px;">com.liferay.portal.sharepoint.SharepointFilter=false</p>

<p style="margin-left: 40px;">com.liferay.portal.servlet.filters.validhtml.ValidHtmlFilter=false</p>

<p style="margin-left: 40px;">session.tracker.memory.enabled=false</p>

<p style="margin-left: 40px;">counter.increment=2000</p>

<p style="margin-left: 40px;">portlet.css.enabled=false</p>

<p style="margin-left: 40px;">javadoc.manager.enabled=false</p>

<p style="margin-left: 40px;">direct.servlet.context.reload=false</p>

<p style="margin-left: 40px;">blogs.pingback.enabled=false</p>

<p style="margin-left: 40px;">blogs.trackback.enabled=false</p>

<p style="margin-left: 40px;">blogs.ping.google.enabled=false</p>

<p style="margin-left: 40px;">message.boards.pingback.enabled=false</p>

<p style="margin-left: 40px;">permissions.inline.sql.check.enabled=false</p>

<p style="margin-left: 40px;">look.and.feel.modifiable=false</p>

<p style="margin-left: 40px;">layout.user.public.layouts.enabled=false</p>

<p style="margin-left: 40px;">dl.file.rank.enabled=false</p>

<p style="margin-left: 40px;">dl.file.entry.read.count.enabled=false</p>

<p style="margin-left: 40px;">&nbsp;</p>

<p style="box-sizing: border-box; margin: 0.85em 0px; padding: 0px; border: 0px rgb(225, 225, 225); font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; font-size: 16px; line-height: 30px; font-family: &quot;Open Sans&quot;, sans-serif; vertical-align: baseline; color: rgb(0, 39, 84);">&nbsp;</p>
</div>
