1º Crear un virtualhost específico para cada instancia
<blockquote>
<pre><strong>
vi /etc/httpd/conf.d/nombre_dominio.conf
</strong></pre>
</blockquote>
<blockquote>
<pre><strong>
AddDefaultCharset utf-8
#<IfModule mod_proxy_balancer>
<Proxy "balancer://apache-cluster">
       BalancerMember "ajp://ip_o_dominio_tomcat_nodo1:puerto_ajp_tomcat" route=node1 min=10 max=150 smax=50 loadfactor=1 timeout=40 retry=300
       BalancerMember "ajp://ip_o_dominio_tomcat_nodo2:puerto_ajp_tomcat" route=node2 min=10 max=150 smax=50 loadfactor=1 timeout=40 retry=300
</Proxy>
#</IfModule>

#<IfModule mod_proxy_ajp>
   ProxyRequests On

   ProxyPass "/vhb.html" "!"
   ProxyPassReverse "/vhb.html" "!"

   ProxyPass / "balancer://apache-cluster/" stickysession=JSESSIONID
   ProxyPassReverse / "balancer://apache-cluster/" stickysession=JSESSIONID
#</IfModule>
</strong></pre>
</blockquote>