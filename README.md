## Laboratorio de Programación y Lenguajes

### Departamento de Informática - FI-UNPSJB-PM

# Trabajo Práctico Nº 2

## Instalación y configuración del entorno de desarrollo

El primer paso es instalar el entorno que utilizaremos para el desarrollo.
Este será configurado utilizando Docker para asegurar un ambiente homogéneo para toda la clase.

1. Instalar [Docker](https://www.docker.com/products/docker-desktop)
1. Abrir una terminal en el directorio de trabajo
1. Ejecutar `docker pull labprog:glassfish`
1. Verificar que la imagen haya sido bajada con éxito ejecutando `docker run -it --rm labprog:glassfish`

Si la instalación fue correcta debería abrirse una terminal dentro del contenedor Linux, en la ubicación home de root.
Con el comando `ls` debería listarse una sola carpeta vacia llamada `app`.

## Registrarse en el repositorio Git

Para regisrtarse en el repositorio Git deberá crear una cuenta en fipmgit.ddns.net:8102 y solicitar a la cátedra ser agregados al grupo de la materia.

## Adquirir el código base para el desarrollo

Para comenzar con el desarrollo es necesario adquirir el código base y verificar la funcionalidad de los ejemplos.

Desde la línea de comandos en el directorio de trabajo:
1. Crear una carpeta `tp2-base`
1. Crear el volumen para persistir los datos creados en el contenedor: `docker volume create labprog`
1. Ejecutar el comando para iniciar el contenedor
```
docker run -it --rm -p 8080:8080 -p 4848:4848 --mount type=bind,source="$(pwd)"/tp2-base,target=/root/app -v labprog:/usr/local/glassfish5/glassfish labprog/glassfish
```
> La opción `--mount` hace accesible la carpeta local desde el contenedor. La opción `-v` direcciona el volumen creado con el directorio correspondiente en el contenedor y `-p` indica los puestos expuestos.

2. En la terminar que se abra ejecutar 
```
git clone http://fipmgit.ddns.net:8102/labprog/TP2-ejemplos.git app
```
> Este paso se encarga de clonar el código base del TP2 dentro de la carpeta `app`, que puede ser accedida desde el filesystem y ver los archivos en el directorio `tp2-base` que fue montado.

## Iniciar el servidor por primera vez

Para la primera ejecución del servidor es preciso crear la base de datos y las conexiones necesarias.

1. Dirigirse a la carpeta de uno de los ejemplos `cd app/ejemplos/CH3-EmployeeService`
1. Iniciar el servidor y la base de datos ejecutando el comando `ant start`.
  > Para detener el servidor y la base de datos `ant stop`. Los comandos disponibles se encuentran en `app/build.xml` y su detalle de implementación en `app/config/common.xml`.

1. Una vez iniciado el servidor se puede verificar su correcta configuración ingresando desde el navegador a http://localhost:8080/.


### Preparar los ejemplos para ser ejecutados

En el mismo directorio del ejemplo:

1. Crear la base de datos `ant createdb`.

1. Para compilar el ejemplo `ant compile`.

1. Para correr los tests del ejemplo y verificar el funcionamiento `ant test`.

1. Para ejecutar el ejemplo `ant deploy`. Luego abrir el navegador y entrar en la dirección `http://localhost:8080/<EXAMPLE_NAME>`

> En este último comando, <EXAMPLE_NAME> debe ser reemplazado por el nombre del ejemplo. Este puede encontrarse ejecutando `ant name`

Si se puede observar la aplicación corriendo todo fue configurado correctamente y el ambiente está listo para desarrollar.


**¡FELICITACIONES!**