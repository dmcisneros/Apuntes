<div class="content-body tutorial-content" data-growable-markdown="">
      <h3 id="introducción">Introducción</h3>

<p>Docker es una aplicación que hace que sea sencillo y fácil de ejecutar procesos de aplicación en un contenedor, que son como máquinas virtuales, sólo más portátil, más amigable con los recursos y más dependiente del sistema operativo del host. Para una introducción detallada a los diferentes componentes de un contenedor Docker, eche un vistazo a <a href="https://www.digitalocean.com/community/tutorials/the-docker-ecosystem-an-introduction-to-common-components">el ecosistema Docker: introducción a los componentes comunes</a>.</p>

<p>Existen dos métodos para instalar Docker en Ubuntu 16.04. Un método consiste en instalarlo en una instalación existente del sistema operativo. El otro implica correr un servidor con una herramienta llamada <a href="https://www.digitalocean.com/community/tutorials/how-to-provision-and-manage-remote-docker-hosts-with-docker-machine-on-ubuntu-16-04">Docker Machine</a> que instala automáticamente Docker en él.</p>

<p>En este tutorial, aprenderá cómo instalarlo y utilizarlo en una instalación existente de Ubuntu 16.04.</p>

<div name="requisitos-previos" data-unique="requisitos-previos"></div><h2 id="requisitos-previos">Requisitos Previos</h2>

<p>Para seguir este tutorial, necesitará lo siguiente:</p>

<ul>
<li>Un Droplet con Ubuntu 16.04 de 64-bit</li>
<li>Una cuenta de usuario que no sea root, con privilegios de <code>sudo</code>, en la <a href="https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04">guía de configuración inicial para Ubuntu 16.04</a> se explica cómo configurar esto.</li>
</ul>

<p><span class="note"><strong>Nota:</strong> Docker requiere una versión de 64 bits de Ubuntu, así como una versión del kernel igual o superior a 3.10. El Droplet de Ubuntu 16.04 64-bit por defecto cumple con estos requisitos.<br></span></p>

<p>Todos los comandos de este tutorial deben ejecutarse como un usuario no root. Si se requiere acceso root para el comando, éste será precedido por <code>sudo</code>. La <a href="https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04">guía de configuración Inicial para Ubuntu 16.04</a> explica cómo agregar usuarios y cómo darles acceso a sudo.</p>

<div name="paso-1-—-instalación-de-docker" data-unique="paso-1-—-instalación-de-docker"></div><h2 id="paso-1-—-instalación-de-docker">Paso 1 — Instalación de Docker</h2>

<p>El paquete de instalación de Docker disponible en el repositorio oficial de Ubuntu 16.04 puede no ser la última versión. Para obtener la última y mejor versión, instale Docker desde el repositorio oficial de Docker. Esta sección le muestra cómo hacerlo.</p>

<p>Pero primero, vamos a actualizar la base de datos de paquetes:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">sudo apt-get update
</li></ul></code></pre>
<p>Ahora vamos a instalar Docker. Agregue la clave GPG para el repositorio oficial de Docker al sistema:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
</li></ul></code></pre>
<p>Agregue el repositorio Docker a fuentes APT:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
</li></ul></code></pre>
<p>Actualice la base de datos de paquetes, con los paquetes Docker desde el repositorio recién agregado:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">sudo apt-get update
</li></ul></code></pre>
<p>Asegúrese de que está a punto de instalar desde el repositorio de Docker en lugar del repositorio predeterminado de Ubuntu 16.04:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">apt-cache policy docker-engine
</li></ul></code></pre>
<p>Debería ver una salida similar a la siguiente:</p>
<div class="code-label " title="Output of apt-cache policy docker-engine">Output of apt-cache policy docker-engine</div><pre class="code-pre "><code langs="">docker-engine:
  Installed: (none)
  Candidate: 1.11.1-0~xenial
  Version table:
     1.11.1-0~xenial 500
        500 https://apt.dockerproject.org/repo ubuntu-xenial/main amd64 Packages
     1.11.0-0~xenial 500
        500 https://apt.dockerproject.org/repo ubuntu-xenial/main amd64 Packages
</code></pre>
<p>Observe que <code>docker-engine</code> no está instalado, pero el candidato para la instalación es del repositorio de Docker para Ubuntu 16.04. El número de versión de <code>docker-engine</code> puede ser diferente.</p>

<p>Por último, instale Docker:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">sudo apt-get install -y docker-engine
</li></ul></code></pre>
<p>Docker ahora debe estar instalado, el daemon iniciado, y el proceso habilitado para iniciar en el arranque. Compruebe que se está ejecutando:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">sudo systemctl status docker
</li></ul></code></pre>
<p>La salida debe ser similar a la siguiente, mostrando que el servicio está activo y en ejecución:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
   Active: <span class="highlight">active (running)</span> since Sun 2016-05-01 06:53:52 CDT; 1 weeks 3 days ago
     Docs: https://docs.docker.com
 Main PID: 749 (docker)
</code></pre>
<p>La instalación de Docker ahora le ofrece no sólo el servicio Docker (daemon), sino también la utilidad de línea de comandos <code>docker</code> o el cliente Docker. Exploraremos cómo utilizar el comando <code>docker</code> más adelante en este tutorial.</p>

<div name="paso-2-—-ejecutar-el-comando-docker-sin-sudo-(opcional)" data-unique="paso-2-—-ejecutar-el-comando-docker-sin-sudo-(opcional)"></div><h2 id="paso-2-—-ejecutar-el-comando-docker-sin-sudo-opcional">Paso 2 — Ejecutar el Comando Docker Sin Sudo (Opcional)</h2>

<p>De forma predeterminada, ejecutar el comando <code>docker</code> requiere privilegios de root, es decir, tiene que prefijar el comando con <code>sudo</code>. También puede ser ejecutado por un usuario en el grupo <strong>docker</strong>, que se crea automáticamente durante la instalación de Docker. Si intenta ejecutar el comando <code>docker</code> sin prefijarlo con <code>sudo</code> o sin estar en el grupo docker, obtendrá una salida como esta:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>docker: Cannot connect to the Docker daemon. Is the docker daemon running on this host?.
See 'docker run --help'.
</code></pre>
<p>Si desea evitar escribir <code>sudo</code> cada vez que ejecute el comando <code>docker</code>, añada su nombre de usuario al grupo docker:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">sudo usermod -aG docker $(whoami)
</li></ul></code></pre>
<p>Deberá cerrar la sesión del Droplet y regresar como el mismo usuario para habilitar este cambio.</p>

<p>Si necesita agregar un usuario al grupo <code>docker</code> en el que no ha iniciado sesión, declare explícitamente el nombre de usuario utilizando:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">sudo usermod -aG docker <span class="highlight">username</span>
</li></ul></code></pre>
<p>El resto de este artículo asume que está ejecutando el comando <code>docker</code> como un usuario en el grupo de usuario <code>docker</code>. Si opta por no hacerlo, por favor agregue los comandos con <code>sudo</code>.</p>

<div name="paso-3-—-uso-del-comando-docker" data-unique="paso-3-—-uso-del-comando-docker"></div><h2 id="paso-3-—-uso-del-comando-docker">Paso 3 — Uso del Comando Docker</h2>

<p>Con Docker instalado y funcionando, ahora es el momento de familiarizarse con la utilidad de la línea de comandos. El uso de <code>docker</code> consiste en pasarle una cadena de opciones y comandos seguidos de argumentos. La sintaxis toma esta forma:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker [option] [command] [arguments]
</li></ul></code></pre>
<p>Para ver todos los subcomandos disponibles, ingrese:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker
</li></ul></code></pre>
<p>Como Docker 1.11.1, la lista completa de los subcomandos disponibles incluye:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>    attach    Attach to a running container
    build     Build an image from a Dockerfile
    commit    Create a new image from a container's changes
    cp        Copy files/folders between a container and the local filesystem
    create    Create a new container
    diff      Inspect changes on a container's filesystem
    events    Get real time events from the server
    exec      Run a command in a running container
    export    Export a container's filesystem as a tar archive
    history   Show the history of an image
    images    List images
    import    Import the contents from a tarball to create a filesystem image
    info      Display system-wide information
    inspect   Return low-level information on a container or image
    kill      Kill a running container
    load      Load an image from a tar archive or STDIN
    login     Log in to a Docker registry
    logout    Log out from a Docker registry
    logs      Fetch the logs of a container
    network   Manage Docker networks
    pause     Pause all processes within a container
    port      List port mappings or a specific mapping for the CONTAINER
    ps        List containers
    pull      Pull an image or a repository from a registry
    push      Push an image or a repository to a registry
    rename    Rename a container
    restart   Restart a container
    rm        Remove one or more containers
    rmi       Remove one or more images
    run       Run a command in a new container
    save      Save one or more images to a tar archive
    search    Search the Docker Hub for images
    start     Start one or more stopped containers
    stats     Display a live stream of container(s) resource usage statistics
    stop      Stop a running container
    tag       Tag an image into a repository
    top       Display the running processes of a container
    unpause   Unpause all processes within a container
    update    Update configuration of one or more containers
    version   Show the Docker version information
    volume    Manage Docker volumes
    wait      Block until a container stops, then print its exit code
</code></pre>
<p>Para ver los modificadores disponibles para un comando específico, escriba:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker <span class="highlight">docker-subcommand</span> --help
</li></ul></code></pre>
<p>Para ver información sobre Docker en todo el sistema, utilice:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker info
</li></ul></code></pre>
<h1 id="paso-4-—-trabajar-con-imágenes-de-docker">Paso 4 — Trabajar con Imágenes de Docker</h1>

<p>Los contenedores Docker se ejecutan desde imágenes de Docker. De forma predeterminada, extrae estas imágenes de Docker Hub, un registro de Docker administrado por Docker, la compañía detrás del proyecto Docker. Cualquier persona puede construir y alojar sus imágenes Docker en Docker Hub, por lo que la mayoría de las aplicaciones y distribuciones Linux que necesitará para ejecutar contenedores Docker tienen imágenes alojadas en Docker Hub.</p>

<p>Para comprobar si puede acceder y descargar imágenes de Docker Hub, escriba:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker run hello-world
</li></ul></code></pre>
<p>La salida, que debe incluir lo siguiente, debe indicar que Docker está trabajando correctamente:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>Hello from Docker.
This message shows that your installation appears to be working correctly.
...
</code></pre>
<p>Puede buscar imágenes disponibles en Docker Hub utilizando el comando <code>docker</code> con el subcomando <code>search</code>. Por ejemplo, para buscar la imagen de Ubuntu, escriba:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker search ubuntu
</li></ul></code></pre>
<p>El script rastreará Docker Hub y devolverá una lista de todas las imágenes cuyo nombre coincida con la cadena de búsqueda. En este caso, la salida será similar a esto:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>NAME                              DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
ubuntu                            Ubuntu is a Debian-based Linux operating s...   3808      [OK]       
ubuntu-upstart                    Upstart is an event-based replacement for ...   61        [OK]       
torusware/speedus-ubuntu          Always updated official Ubuntu docker imag...   25                   [OK]
rastasheep/ubuntu-sshd            Dockerized SSH service, built on top of of...   24                   [OK]
ubuntu-debootstrap                debootstrap --variant=minbase --components...   23        [OK]       
nickistre/ubuntu-lamp             LAMP server on Ubuntu                           6                    [OK]
nickistre/ubuntu-lamp-wordpress   LAMP on Ubuntu with wp-cli installed            5                    [OK]
nuagebec/ubuntu                   Simple always updated Ubuntu docker images...   4                    [OK]
nimmis/ubuntu                     This is a docker images different LTS vers...   4                    [OK]
maxexcloo/ubuntu                  Docker base image built on Ubuntu with Sup...   2                    [OK]
admiringworm/ubuntu               Base ubuntu images based on the official u...   1                    [OK]

...

</code></pre>
<p>En la columna <strong>OFICIAL</strong>, <strong>OK</strong> indica una imagen creada y apoyada por la empresa detrás del proyecto. Una vez que haya identificado la imagen que desea utilizar, puede descargarla a su computadora mediante el subcomando <code>pull</code>, así:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker pull ubuntu
</li></ul></code></pre>
<p>Después de descargar una imagen, puede ejecutar un contenedor usando la imagen descargada con el subcomando <code>run</code>. Si no se ha descargado una imagen cuando se ejecuta <code>docker</code> con el subcomando <code>run</code>, el cliente Docker descargará primero la imagen y luego ejecutará un contenedor utilizando:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker images
</li></ul></code></pre>
<p>La salida debería ser algo similar a esto:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              latest              c5f1cf30c96b        7 days ago          120.8 MB
hello-world         latest              94df4f0ce8a4        2 weeks ago         967 B
</code></pre>
<p>Como veremos más adelante en este tutorial, las imágenes que utilice para ejecutar contenedores pueden modificarse y utilizarse para generar nuevas imágenes, que luego pueden cargarse (<em>pushed</em> es el término técnico) a Docker Hub u otros registros de Docker.</p>

<div name="paso-5-—-ejecutar-un-contenedor-docker" data-unique="paso-5-—-ejecutar-un-contenedor-docker"></div><h2 id="paso-5-—-ejecutar-un-contenedor-docker">Paso 5 — Ejecutar un Contenedor Docker</h2>

<p>El contenedor <code>hello-world</code> que se ejecutó en el anterior es un ejemplo de un contenedor que se ejecuta y sale, después de emitir un mensaje de prueba. Los contenedores, sin embargo, pueden ser mucho más útiles que eso, y pueden ser interactivos. Después de todo, son similares a las máquinas virtuales, sólo que más amigable con los recursos.</p>

<p>Como ejemplo, vamos a ejecutar un contenedor utilizando la última imagen de Ubuntu. La combinación de los switches <strong>-i</strong> y <strong>-t</strong> le ofrece acceso interactivo a shell en el contenedor:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker run -it ubuntu
</li></ul></code></pre>
<p>Su símbolo del sistema debe cambiar para reflejar el hecho de que ahora está trabajando dentro del contenedor y debe tomar esta forma:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>root@d9b100f2f636:/#
</code></pre>
<p><strong>Importante:</strong> Observe el identificador del contenedor en el símbolo del sistema. En el ejemplo anterior, es <code>d9b100f2f636</code>.</p>

<p>Ahora puede ejecutar cualquier comando dentro del contenedor. Por ejemplo, actualicemos la base de datos del paquete dentro del contenedor. No hay necesidad de prefijar ningún comando con <code>sudo</code>, porque estás operando dentro del contenedor con privilegios de root:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">apt-get update
</li></ul></code></pre>
<p>A continuación, instale cualquier aplicación en él. Vamos a instalar NodeJS, por ejemplo.</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">apt-get install -y nodejs
</li></ul></code></pre>
<div name="paso-6-—-hacer-cambios-en-un-contenedor-a-una-imágen-de-docker" data-unique="paso-6-—-hacer-cambios-en-un-contenedor-a-una-imágen-de-docker"></div><h2 id="paso-6-—-hacer-cambios-en-un-contenedor-a-una-imágen-de-docker">Paso 6 — Hacer Cambios en un Contenedor a una Imágen de Docker</h2>

<p>Cuando inicia una imagen de Docker, puede crear, modificar y eliminar archivos de la misma forma que puede hacerlo con una máquina virtual. Los cambios que realice sólo se aplicarán a ese contenedor. Puede iniciarlo y detenerlo, pero una vez que lo destruya con el comando <code>docker rm</code>, los cambios se perderán definitivamente.</p>

<p>En esta sección se muestra cómo guardar el estado de un contenedor como una nueva imagen de Docker.</p>

<p>Después de instalar nodejs dentro del contenedor de Ubuntu, ahora tiene un contenedor que se ejecuta en una imagen, pero el contenedor es diferente de la imagen que utilizó para crearlo.</p>

<p>Para guardar el estado del contenedor como una nueva imagen, primero salga de ella:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">exit
</li></ul></code></pre>
<p>A continuación, confirme los cambios en una nueva instancia de imagen de Docker mediante el siguiente comando. El modificador <strong>-m</strong> es para el mensaje de confirmación que le ayuda a usted ya los demás a saber qué cambios hizo, mientras que <strong>-a</strong> se utiliza para especificar el autor. El identificador del contenedor es el que anotó anteriormente en el tutorial cuando inició la sesión de docker interactivo. A menos que haya creado repositorios adicionales en Docker Hub, el repositorio suele ser el nombre de usuario de Docker Hub:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker commit -m "What did you do to the image" -a "Author Name" <span class="highlight">container-id repository</span>/<span class="highlight">new_image_name</span>
</li></ul></code></pre>
<p>Por ejemplo:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker commit -m "added node.js" -a "Sunday Ogwu-Chinuwa" d9b100f2f636 finid/ubuntu-nodejs
</li></ul></code></pre>
<p><span class="note"><strong>Nota:</strong> Cuando hace <em>commit</em> a una imagen, la nueva imagen se guarda localmente, es decir, en su computadora. Más adelante en este tutorial, aprenderá cómo hacer push una imagen a un registro de Docker como Docker Hub para que pueda ser evaluada y utilizada por usted y otros.<br></span></p>

<p>Después de que la operación haya terminado, puede listar las imágenes de Docker ahora en su computadora, debe de mostrar la nueva imagen, así como la vieja de la que se derivó:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker images
</li></ul></code></pre>
<p>La salida debe ser similar a esto:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div><span class="highlight">finid/ubuntu-nodejs</span>       latest              62359544c9ba        50 seconds ago      206.6 MB
ubuntu              latest              c5f1cf30c96b        7 days ago          120.8 MB
hello-world         latest              94df4f0ce8a4        2 weeks ago         967 B
</code></pre>
<p>En el ejemplo anterior, <strong>ubuntu-nodejs</strong> es la nueva imagen, que se derivó de la imagen existente de Ubuntu desde Docker Hub. La diferencia de tamaño refleja los cambios que se hicieron. Y en este ejemplo, el cambio fue que NodeJS fue instalado. Así que la próxima vez que necesite ejecutar un contenedor usando Ubuntu con NodeJS preinstalado, sólo puede usar la nueva imagen. Las imágenes también se pueden construir a partir de lo que se llama un Dockerfile. Pero ese es un proceso muy complicado que está fuera del alcance de este artículo.</p>

<div name="paso-7-—-listado-de-contenedores-docker" data-unique="paso-7-—-listado-de-contenedores-docker"></div><h2 id="paso-7-—-listado-de-contenedores-docker">Paso 7 — Listado de Contenedores Docker</h2>

<p>Después de usar Docker por un tiempo, tendrá muchos contenedores activos (en ejecución) e inactivos en su computadora. Para ver los activos, utilice:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker ps
</li></ul></code></pre>
<p>Verá una salida similar a la siguiente:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
f7c79cc556dd        ubuntu              "/bin/bash"         3 hours ago         Up 3 hours                              silly_spence
</code></pre>
<p>Para ver todos los contenedores — activos e inactivos, pase el modificador <code>-a</code>:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker ps -a
</li></ul></code></pre>
<p>Para ver el último contenedor que creó, pase el modificador <code>-l</code>:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker ps -l
</li></ul></code></pre>
<p>Detener un contenedor ejecutándose o activo es tan simple como escribir:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker stop <span class="highlight">container-id</span>
</li></ul></code></pre>
<p>El <code>container-id</code> se puede encontrar en la salida del comando <code>docker ps</code>.</p>

<div name="paso-8-—-subiendo-imágenes-de-docker-a-un-repositorio-docker" data-unique="paso-8-—-subiendo-imágenes-de-docker-a-un-repositorio-docker"></div><h2 id="paso-8-—-subiendo-imágenes-de-docker-a-un-repositorio-docker">Paso 8 — Subiendo Imágenes de Docker a un Repositorio Docker</h2>

<p>El siguiente paso lógico después de crear una nueva imagen de una imagen existente es compartirla con algunos pocos de tus amigos, el mundo entero en Docker Hub u otro registro de Docker al que tenga acceso. Para hacer push de una imagen a Docker Hub o cualquier otro registro de Docker, debe tener una cuenta allí.</p>

<p>Esta sección le muestra cómo hacer push desde una imagen Docker a Docker Hub. Para saber cómo crear su propio registro de Docker privado, consulte <a href="https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-14-04">¿cómo configurar un registro de Docker privado en Ubuntu 14.04?</a>.</p>

<p>Para crear una cuenta en Docker Hub, regístrese en <a href="https://hub.docker.com">Docker Hub</a>. Después, para hacer push a su imagen, primero ingrese en Docker Hub. Se le pedirá que se autentique:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker login -u <span class="highlight">docker-registry-username</span>
</li></ul></code></pre>
<p>Si especificó la contraseña correcta, la autenticación debería tener éxito. Entonces usted puede hacer push a su propia imagen usando:</p>
<pre class="code-pre command"><code langs=""><ul class="prefixed"><li class="line" prefix="$">docker push <span class="highlight">docker-registry-username</span>/<span class="highlight">docker-image-name</span>
</li></ul></code></pre>
<p>Se tardará algún tiempo en completarse, y cuando se complete, la salida será similar a la siguiente:</p>

<p>Después de hacer push de una imagen a un registro, debe aparecer en el tablero de la cuenta, como en la imagen de abajo.</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>The push refers to a repository [docker.io/finid/ubuntu-nodejs]
e3fbbfb44187: Pushed
5f70bf18a086: Pushed
a3b5c80a4eba: Pushed
7f18b442972b: Pushed
3ce512daaf78: Pushed
7aae4540b42d: Pushed

...

</code></pre>
<p>Después de subir una imagen al registro, debería aparecer en la lista de su cuenta, como se muestra en la imagen de abajo.</p>

<p class="growable"><img src="https://assets.digitalocean.com/articles/docker_install/docker_hub_dashboard_ubuntu.png" alt="Dashboard de Docker Hub"></p>

<p>Si un intento de push resulta en un error de este tipo, es probable que no haya iniciado sesión:</p>
<pre class="code-pre "><code langs=""><div class="secondary-code-label " title="Output">Output</div>The push refers to a repository [docker.io/finid/ubuntu-nodejs]
e3fbbfb44187: Preparing
5f70bf18a086: Preparing
a3b5c80a4eba: Preparing
7f18b442972b: Preparing
3ce512daaf78: Preparing
7aae4540b42d: Waiting
unauthorized: authentication required
</code></pre>
<p>Inicie sesión y repita el intento de push.</p>

<div name="conclusión" data-unique="conclusión"></div><h2 id="conclusión">Conclusión</h2>

<p>Hay mucho más de Docker de lo que se ha dado en este artículo, pero esto debería ser suficiente para empezar a trabajar con él en Ubuntu 16.04. Al igual que la mayoría de los proyectos de código abierto, Docker se construye a partir de una base de código de rápido desarrollo, por lo que el hábito de visitar la <a href="https://blog.docker.com">página del blog</a> del proyecto para obtener la información más reciente.</p>

<p>También eche un vistazo a los <a href="https://www.digitalocean.com/community/tags/docker?type=tutorials">otros tutoriales de Docker</a> en la comunidad de DO.</p>

    </div>
