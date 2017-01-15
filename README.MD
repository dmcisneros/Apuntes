Comenzar indicando que el objetivo de la ponencia es que conozcan git y github además de las operaciones comunes que se utilizan en el día a día en un proyecto de desarrollo. Hacer referencia que es como un facebook para desarrolladores del que se puede aprender mucho y de los mejores.

1º Que es un sistema de control de versiones. // Preguntar quien conoce los SCV
<br/>
2º Operaciones comunes de los SCV (Update, Checkout, Commit, Revert).
<br/>
3º Que es git: working directory, storage index, repositorios.  // Preguntar quien ha trabajado con git 
<br/>
4º Que es github: asociandolo a la explicacion anterior de repositorios. // Preguntar quien ha trabajado con github
<br/>
5º Git + github: Instalación: indicar que hay diferentes editores gráficos, pero para no limitarnos a un cliente mejor utilizar la consola para poder 
<br/>
6º Añadir un repositorio en github: 
<br/>
	repositorio_punta_del_verde
<br/>
7º Crear carpeta en local:
<br/>
	mkdir punta_del_verde
<br/>
8º Conectar dicho repositorio con git:
<br/>
	git init
<br/>
9º Conectar con el repositorio de github: 
<br/>
	git remote pdv_repo https://github.com/dmcisneros/repositorio_punta_del_verde.git
<br/>
10º Crear un fichero:
<br/>
	echo "Hola punta del verde" > README.MD
<br/>
11º Añadir al storage index:
<br/>
	git add README.MD
<br/>
12º Hacer commit al repositorio local: Explicar que hemos hecho un commit al repositorio local para posteriormente enviarlo al remoto con push
<br/>
	git commit -m "mi primer commit" README.MD
<br/>
13º Hacer un push al repositorio remoto
<br/>
	git push pdv_repo master
<br/>
14º Modificar el fichero_con_conflictohero: 
<br/>
	git echo "fichero modificado" > README.MD
<br/>
15º Repetir desde el paso 11 al 13 para subirlo al repositorio remoto.
<br/>
16º Hacer un cambio en github del fichero y actualizar el local.
<br/>
	git pull pdv_repo master
<br/>
17º Editar el fichero para producir un conflicto.
<br/>
18º Repetir desde el paso 11 al 13 para subirlo al repositorio remoto, al hacer el push tendremos un conflicto. 
<br/>	git pull pdv_repo master	// Intenta hacer un merge y si no lo consigue marca el fichero con conflictos.
<br/>	//Subsanar el error en el fichero y: 
<br/>	git add README.MD
<br/>	git commit -m "error en README.MD subsanado" 
<br/>	git push pdv_repo master

-------------BEGIN BRANCHES----------
<br/>
19º Explicar el motivo por el que se utilizan las ramas y crear una.
<br/>	git checkout -b feature_01
<br/>
20º Modificar el fichero README.MD y hacer un push
<br/>	git add README.MD
<br/>	git commit -m "fichero modificado desde branch" .
<br/>	git push pdv_repo feature_01
<br/>
21º Cambiar de ramas y revisar como cambia el contenido.
<br/>	git checkout master -> abrir el fichero
<br/>	git checkout feature_01 -> abrir el fichero
<br/>
22º Actualizar la rama master con la nueva característica. Nos situamos en la rama destino y hacemos el merge. No hay conflictos al no haber cambiado el fichero.
<br/>	git checkout master
<br/>	git merge feature_01
<br/>	git add README.MD
<br/>	git commit -m "fichero modificado desde master con cambios actualizados desde branch" .
<br/>	git push pdv_repo master
<br/>
22º Actualizar la rama master con la nueva característica con conflictos.
<br/>	git checkout feature_01
<br/>	Editar el contenido
<br/>	git add README.MD
<br/>	git commit -m "fichero modificado desde branch para provocar conflicto" .
<br/>	git push pdv_repo feature_01
<br/>	//Cambio a la otra rama
<br/>	git checkout master
<br/>	Editar el contenido
<br/>	git add README.MD
<br/>	git commit -m "fichero modificado desde master para provocar conflicto" .
<br/>	git push pdv_repo master
<br/>
23º Realizar merge para resolver conflictos:
<br/>	git merge pdv_repo feature_01
<br/>	editar el fichero y resolverlos
<br/>	git add README.md
<br/>	git commit "from feature_01 to master" 
<br/>	git push pdv_repo master
<br/>
24º Eliminar la rama si no es relevante guardarla en el repositorio:
<br/>	git branch -d feature_01 
<br/>	git push --delete pdv_repo feature_01
<br/>	Ir a github y mostrar que se ha eliminado
<br/>
-------------END BRANCHES----------
<br/>
-------------BEGIN TAGS----------
<br/>

25º Explicar el uso de Tags y crear alguna desde algun commit: 
<br/>	git log
<br/>	git tag 1.0.0 XXXXXXX ó git tag 1.0.0 -m "nombre comentario"
<br/>	git push pdv_repo 1.0.0
<br/>

-------------END TAGS----------
<br/>

//Útil Instalar git
<br/>1º Instalar git:
<br/>http://git-scm.com/download/win 
<br/>2º Añadir git a las variables de entorno:
<br/>C:\Program Files\Git\bin;
<br/>git --version
<br/>3º git init
<br/>4º Añadir datos de usuario:
<br/>	git config --global user.name "Daniel Martinez Cisneros"
<br/>	git config --global user.email dmcisneros@example.com

<br/>5º configuración de proxy:
<br/>git config --global user.name "John Doe"
<br/>git config --global user.email johndoe@example.com
<br/>git config --global --unset http.proxy
<br/>
//Posibles preguntas: 
<br/>Diferencia entre fetch y pull: git fetch trae los cambios, pero los deja en otro branch, hasta que se hace el git merge para traerlos al branch local.

