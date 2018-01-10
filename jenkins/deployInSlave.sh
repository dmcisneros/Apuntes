#!/bin/sh
##Para llamar a este script:
#./deployToEnvironment.sh ‘nombremodulo-1 nombremodulo-2'  $VERSION $ENTORNO $GROUP_ID $RUTA_LIFERAY_HOME $USUARIO_DESPLIEGUE
COMPONENTES=$1
COMPONENTES=$(echo ${COMPONENTES//,/ })
VERSION=$2
ENTORNO=$3
GROUP_ID=$4
#Solicitamos al usuario el nombre del caso y la versión hasta que introduzca un valor
#añadir la ruta de liferay hom, por defecto será /aplicativo/liferay
LIFERAY_HOME=$5
#usuario remoto para hacer la conexión por ss, desa=orange, inte=liferay
USER_DEPLOY=$6
#directorio home del usuario
HOME_USER=/home/$USER_DEPLOY
echo LF_Deploy script version 1.0.1
echo LF_Components: $COMPONENTE
echo LF_Version: $VERSION.
echo LF_Environment: $ENTORNO

remote_deploy(){

if [[ -n "$ENTORNO" ]]; then
	echo `date +%d/%m/%Y-%H:%M:%S` starting deploy in $ENTORNO >> deploy_$ENTORNO.log
	echo starting deploy $ENTORNO
	echo "1-Iterate components"
	cd files
	for i in ${COMPONENTES[@]}
	do
		
		COMPONENTE=${i}
		EXTENSION=.jar
	
			echo "component to download:$COMPONENTE"
			if [[ $COMPONENTE == *layouttpl ]] || [[ $COMPONENTE == *theme ]];
			then
				echo "Downloading war ..."
				ARTIFACT=$COMPONENTE-$VERSION.war
				wget $NEXUS_REPOSITORY/$GROUP_ID/$COMPONENTE/$VERSION/$COMPONENTE-$VERSION.war
				EXTENSION=.war
			else
				echo "Downloading jar ..."
				ARTIFACT=$COMPONENTE-$VERSION.jar
				wget $NEXUS_REPOSITORY/$GROUP_ID/$COMPONENTE/$VERSION/$COMPONENTE-$VERSION.jar
				EXTENSION=.jar
			fi
			echo "2- Copy component downloaded to target environment"
			if [ -e $ARTIFACT ]
			then
				#Comprobamos si hay conexión a la máquina
				ssh $HOST_USER@$HOST_TO_DEPLOY pwd
				valor=$?
				
				if [ $valor = "0" ];
				then
					echo "Conected to environment"
					echo "Starting environment deployment"
				if ssh $HOST_USER@$HOST_TO_DEPLOY stat $LIFERAY_HOME \> /dev/null 2\>\&1;
				then
					echo "Copy artifact to folder"
					if ssh $HOST_USER@$HOST_TO_DEPLOY " [ -e /tmp/liferay/$COMPONENTE/$VERSION ]";	
					then 
						echo Folder $VERSION exist
					else	
						echo Folder $VERSION not found, will be created
						if ssh $HOST_USER@$HOST_TO_DEPLOY " [ -e /tmp/liferay/ ] ";
						then
							echo Folder liferay exist
						else
							echo Folder liferay not found, will be created
							ssh $HOST_USER@$HOST_TO_DEPLOY mkdir '\/tmp\/liferay\/'
						fi
						if ssh $HOST_USER@$HOST_TO_DEPLOY " [ -e /tmp/liferay/$COMPONENTE ] ";
								then
							echo $COMPONENTE liferay exist, creating $VERSION
							ssh $HOST_USER@$HOST_TO_DEPLOY mkdir '\/tmp\/liferay\/'$COMPONENTE'\/'$VERSION
						else
							echo Folder $COMPONENTE not found, will be created with version
							ssh $HOST_USER@$HOST_TO_DEPLOY mkdir '\/tmp\/liferay\/'$COMPONENTE
							ssh $HOST_USER@$HOST_TO_DEPLOY mkdir '\/tmp\/liferay\/'$COMPONENTE'\/'$VERSION
						fi
					fi	
					echo Starting deployment....
					scp $ARTIFACT $HOST_USER@$HOST_TO_DEPLOY:/tmp/liferay/$COMPONENTE/$VERSION/
					echo Changing permissions.
					ssh $HOST_USER@$HOST_TO_DEPLOY chown -R $USER_DEPLOY.$USER_DEPLOY /tmp/liferay/$COMPONENTE/$VERSION/$ARTIFACT
					echo Deploying.....
					ssh $HOST_USER@$HOST_TO_DEPLOY cp '\/'tmp'\/'liferay'\/'$COMPONENTE'\/'$VERSION'\/'$ARTIFACT $LIFERAY_HOME'\/'deploy'\/'$COMPONENTE$EXTENSION
					echo Finished deployment to $ENTORNO
					echo Temporal files will be removed...
					ssh $HOST_USER@$HOST_TO_DEPLOY rm -rf '\/'tmp'\/'liferay'\/'$COMPONENTE'\/'$VERSION'\/'$ARTIFACT
					rm -rf /tmp/liferay/$COMPONENTE
					rm -rf *
				else
					echo Folder deploy not found, check this $ENTORNO environment
					exit 1
				fi
			else
				echo Not connected to environment
				exit 1
			fi
			else
				echo not downloaded from nexus successfully $ARTIFACT
				exit 1
			fi
	done
	

fi
}
echo Deploying to $ENTORNO from jenkins....
if [ $ENTORNO == "DESARROLLO" ];
then
	HOST_TO_DEPLOY="XXX"
	HOST_USER="liferay"
	NEXUS_REPOSITORY="http://XXX:XXX/nexus/service/local/repositories/liferay-releases/content"
	remote_deploy
fi

if [ $ENTORNO == "INTEGRACION" ];
then
	HOST_TO_DEPLOY="XXX"
	HOST_USER="liferay"
	NEXUS_REPOSITORY="http://XXX:XXX/nexus/service/local/repositories/liferay-releases/content"
	remote_deploy
fi

if [ $ENTORNO == "PREPRODUCCION_NODO_1" ];
then
	NEXUS_REPOSITORY="http://XXX:XXX/nexus/service/local/repositories/liferay-releases/content"
	HOST_TO_DEPLOY="XXX"
	HOST_USER="liferay"
	remote_deploy
fi

if [ $ENTORNO == "PREPRODUCCION_NODO_2" ]; 
then
	NEXUS_REPOSITORY="http://XXX:XXX/nexus/service/local/repositories/liferay-releases/content"
	HOST_TO_DEPLOY="XXX"
	HOST_USER="liferay"
	remote_deploy
fi

if [ $ENTORNO == "PRODUCCION_NODO_1" ]; 
then
	#pendiente de definir la url de las máquinas
	NEXUS_REPOSITORY="http://XXX:XXX/nexus/service/local/repositories/liferay-releases/content"
	HOST_TO_DEPLOY="XXX"	
	HOST_USER="liferay"
	remote_deploy
fi	
if [ $ENTORNO == "PRODUCCION_NODO_2" ]; 
then
	#pendiente de definir la url de las máquinas
	NEXUS_REPOSITORY="http://XXX:XXX/nexus/service/local/repositories/liferay-releases/content"
	HOST_TO_DEPLOY="XXX"
	HOST_USER="liferay"
	remote_deploy
fi					

