#! /bin/bash

APLICACIONES[0]="/usr/share/applications/deepin-screen-recorder.desktop;Captura de pantalla"
APLICACIONES[1]="/usr/share/applications/deepin-picker.desktop;Selector de color"
APLICACIONES[2]="/usr/share/applications/deepin-album.desktop;Álbum"
APLICACIONES[3]="/usr/share/applications/deepin-draw.desktop;Dibujo"
APLICACIONES[4]="/usr/share/applications/deepin-reader.desktop;Visor de documentos"
APLICACIONES[5]="/usr/share/applications/deepin-app-store.desktop;Tienda de aplicaciones"
APLICACIONES[6]="/usr/share/applications/dde-control-center.desktop;Centro de control"
APLICACIONES[7]="/usr/share/applications/deepin-devicemanager.desktop;Administrador de dispositivos"
APLICACIONES[8]="/usr/share/applications/deepin-log-viewer.desktop;Visor de registro"
APLICACIONES[9]="/usr/share/applications/dde-printer.desktop;Impresoras"
APLICACIONES[10]="/usr/share/applications/deepin-font-manager.desktop;Administrador de fuentes"
APLICACIONES[11]="/usr/share/applications/deepin-compressor.desktop;Compresor de archivos"
APLICACIONES[12]="/usr/share/applications/deepin-deb-installer.desktop;Instalador de paquetes"
#APLICACIONES[13]="/usr/share/applications/dde-file-manager.desktop;Administrador de archivos"

for (( i = 0; i < ${#APLICACIONES[@]}; i++ )); do
	
	LANZADOR=$(echo ${APLICACIONES[$i]} | cut -d ";" -f1)
	NOMBRE=$(echo ${APLICACIONES[$i]} | cut -d ";" -f2)

	# Si el lanzador existe
	if [[ -f $LANZADOR ]]; then
		
		# Si GenericName existe en el lanzador, sino agregarlo
		if [[ $(grep "GenericName\[es\]" $LANZADOR) ]]; then
			sed -i "s/GenericName\[es\]=.*/GenericName\[es\]=$NOMBRE/" $LANZADOR
		else
			echo "GenericName[es]=$NOMBRE" | tee -a /usr/share/applications/deepin-album.desktop
		fi

		# Si Name existe en el lanzador, sino agregarlo
		if [[ $(grep "^Name\[es\]" $LANZADOR) ]]; then
			sed -i "s/Name\[es\]=.*/Name\[es\]=$NOMBRE/" $LANZADOR
		else
			echo "Name[es]=$NOMBRE" | tee -a /usr/share/applications/deepin-album.desktop
		fi
	fi

done

# Arreglo para File Manager
sed "s/Gestor de archivos/Administrador de archivos/" /usr/share/applications/dde-file-manager.desktop
