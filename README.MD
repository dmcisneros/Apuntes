Comenzar indicando que el objetivo de la ponencia es que conozcan git y github además de las operaciones comunes que se utilizan en el día a día en un proyecto de desarrollo. Hacer referencia que es como un facebook para desarrolladores del que se puede aprender mucho y de los mejores.

1º Que es un sistema de control de versiones. // Preguntar quien conoce los SCV
2º Operaciones comunes de los SCV (Update, Checkout, Commit, Revert).
3º Que es git: working directory, storage index, repositorios.  // Preguntar quien ha trabajado con git 
4º Que es github: asociandolo a la explicacion anterior de repositorios. // Preguntar quien ha trabajado con github
5º Git + github: Instalación: indicar que hay diferentes editores gráficos, pero para no limitarnos a un cliente mejor utilizar la consola para poder 
6º Añadir un repositorio en github: 
	repositorio_punta_del_verde
7º Crear carpeta en local:
	mkdir punta_del_verde
8º Conectar dicho repositorio con git:
	git init
9º Conectar con el repositorio de github: 
	git remote pdv_repo https://github.com/dmcisneros/repositorio_punta_del_verde.git
10º Crear un fichero:
	echo "Hola punta del verde" > README.MD
11º Añadir al storage index:
	git add README.MD
12º Hacer commit al repositorio local: Explicar que hemos hecho un commit al repositorio local para posteriormente enviarlo al remoto con push
	git commit -m "mi primer commit" README.MD
13º Hacer un push al repositorio remoto
	git push pdv_repo master
14º Modificar el fichero_con_conflictohero: 
	git echo "fichero modificado" > README.MD
15º Repetir desde el paso 11 al 13 para subirlo al repositorio remoto.
16º Hacer un cambio en github del fichero y actualizar el local.
	git pull pdv_repo master
17º Editar el fichero para producir un conflicto.
18º Repetir desde el paso 11 al 13 para subirlo al repositorio remoto, al hacer el push tendremos un conflicto. 
	git pull pdv_repo master	// Intenta hacer un merge y si no lo consigue marca el fichero con conflictos.
	//Subsanar el error en el fichero y: 
	git add README.MD
	git commit -m "error en README.MD subsanado" 
	git push pdv_repo master

-------------BEGIN BRANCHES----------

19º Explicar el motivo por el que se utilizan las ramas y crear una.
	git checkout -b feature_01
20 Modificar el fichero README.MD y hacer un push
	git add README.MD
	git commit -m "fichero modificado desde branch" .
	git push pdv_repo feature_01

21º Cambiar de ramas y revisar como cambia el contenido.
	git checkout master -> abrir el fichero
	git checkout feature_01 -> abrir el fichero

22º Actualizar la rama master con la nueva característica. Nos situamos en la rama destino y hacemos el merge. No hay conflictos al no haber cambiado el fichero.
	git checkout master
	git merge feature_01
	git add README.MD
	git commit -m "fichero modificado desde master con cambios actualizados desde branch" .
	git push pdv_repo master

22º Actualizar la rama master con la nueva característica con conflictos.
	git checkout feature_01
	Editar el contenido
	git add README.MD
	git commit -m "fichero modificado desde branch para provocar conflicto" .
	git push pdv_repo feature_01
	//Cambio a la otra rama
	git checkout master
	Editar el contenido
	git add README.MD
	git commit -m "fichero modificado desde master para provocar conflicto" .
	git push pdv_repo master

23º Realizar merge para resolver conflictos:
	git merge pdv_repo feature_01
	editar el fichero y resolverlos
	git add README.md
	git commit "from feature_01 to master" 
	git push pdv_repo master

24º Eliminar la rama si no es relevante guardarla en el repositorio:
	git branch -d feature_01 
	git push --delete pdv_repo feature_01
	Ir a github y mostrar que se ha eliminado

-------------END BRANCHES----------

-------------BEGIN TAGS----------


25º Explicar el uso de Tags y crear alguna desde algun commit: 
	git log
	git tag 1.0.0 XXXXXXX ó git tag 1.0.0 -m "nombre comentario"
	git push pdv_repo 1.0.0


-------------END TAGS----------


//Útil Instalar git
1º Instalar git:
http://git-scm.com/download/win 
2º Añadir git a las variables de entorno:
C:\Program Files\Git\bin;
git --version
3º git init
4º Añadir datos de usuario:
	git config --global user.name "Daniel Martinez Cisneros"
	git config --global user.email dmcisneros@example.com

5º configuración de proxy:
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
git config --global --unset http.proxy

//Posibles preguntas: 
Diferencia entre fetch y pull: git fetch trae los cambios, pero los deja en otro branch, hasta que se hace el git merge para traerlos al branch local.

