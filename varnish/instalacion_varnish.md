
Instalación desde los repositorios.

1º Revisar las versiones
<blockquote>
<pre><strong>
yum list varnish*
</strong></pre>
</blockquote>


2º Instalar versión específica
<blockquote>
<pre><strong>
yum install varnish.xXX_XX
</strong></pre>
</blockquote>


3º Editar los puertos de arranque
<blockquote>
<pre><strong>
vi /etc/varnish/varnish.params
</strong></pre>
</blockquote>

<blockquote>
<pre><strong>
VARNISH_LISTEN_PORT=${PUERTO_DE_ESCUCHA}
VARNISH_ADMIN_LISTEN_ADDRESS=${IP_SERVER_O_LOCALHOST}
VARNISH_ADMIN_LISTEN_PORT=${PUERTO_DE_ESCUCHA_ADMIN}
</strong></pre>
</blockquote>

4º Editar la información del backend
<blockquote>
<pre><strong>
vi /etc/varnish/default.vcl
</strong></pre>
</blockquote>

5º Editar la información del backend
<blockquote>
<pre><strong>

import directors;

probe healthcheck {
   .url = "/vhb.html";
   .expected_response = 200;
}

# Default backend definition. Set this to point to your content server.
backend apache_nodo1 {
   .host = "ip_host_apache_nodo1";
   .port = "puerto_escucha_apache_nodo1";
   .probe = healthcheck;
}

backend apache_nodo2 {
   .host = "ip_host_apache_nodo2";
   .port = "puerto_escucha_apache_nodo2";
   .probe = healthcheck;
}

sub vcl_init {
     # vcl init, set up the cluster
     new apache_cluster = directors.round_robin();
     apache_cluster.add_backend(apache_nodo1);
     apache_cluster.add_backend(apache_nodo2);
}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
    set req.backend_hint = apache_cluster.backend();

    if (req.http.Range ~ "bytes=") {
        set req.http.x-range = req.http.Range;
    }

   # Contenido NO cacheable
   if (req.url ~ "^/o/content-targeting-web") {
      return (pass);
   }

  # Only cache GET or HEAD requests. This makes sure the POST requests are always passed.
  if (req.method != "GET" && req.method != "HEAD") {
    return (pass);
  }

   # Contenido cacheable
   if ((req.url ~ "\.(js|css|jpg|jpeg|png|gif|gz|tgz|bz2|tbz|mp3|ogg|swf)$")
       || (req.url ~ "\.(js|css|jpg|jpeg|png|gif|gz|tgz|bz2|tbz|mp3|ogg|swf)\?")) {
      return (hash);
   }

   if ((req.url ~ "^/nombre-theme") || (req.url ~ "^/html") || (req.url ~ "^/image") || (req.url ~ "^/documents") || (req.url ~ "^/combo") ) {
      return(hash);
   }


   # Eliminar cookies innecesarias
   if (req.http.cookie ~ "JSESSIONID") {
       return (pass);
   } else {
       unset req.http.cookie;
   }
}


sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
}


</strong></pre>
</blockquote>