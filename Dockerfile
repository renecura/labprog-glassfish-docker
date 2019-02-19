FROM openjdk:8-jdk-alpine

# Establece el directorio de trabajo
WORKDIR /usr/local

# Agrega Glassfish a la imagen
RUN wget http://ftp.osuosl.org/pub/eclipse/glassfish/web-5.1.0.zip && \
    jar xvf web-5.1.0.zip && \
    chmod +x glassfish5/glassfish/bin/* && \
    rm -f web-5.1.0.zip

# Instala paquetes
RUN apk update && apk add --no-cache apache-ant bash git

## Configura variables de entorno
ENV ANT_HOME /usr/share/java/apache-ant 
ENV PATH /usr/local/glassfish5/glassfish/bin:$ANT_HOME/bin:$PATH

ENV PS1 '\e[1;34mlabprog\e[1;33m@\e[1;31m\W\e[1;33m\$ \e[m'

# Realiza la configuración inicial de glassfish
RUN echo $'AS_ADMIN_PASSWORD=\nAS_ADMIN_NEWPASSWORD=admin\n' > pw && \
    asadmin --user admin --passwordfile pw change-admin-password --domain_name domain1 && \
    asadmin start-domain domain1 && \
    echo $'AS_ADMIN_PASSWORD=admin\n' > pw && \
    asadmin --user admin --passwordfile pw enable-secure-admin && \
    rm -f pw

# Monta el directorio de las bases de datos para persistirlas
VOLUME /usr/local/glassfish5/glassfish

# Establece el home como directorio de trabajo
WORKDIR /root

# Crea el directorio app para montar el código a desarrollar
RUN mkdir app

# Expone los puertos
EXPOSE 8080 4848

# Comando por defecto al ejecutar el contenedor con 'run'
CMD [ "bash" ]
