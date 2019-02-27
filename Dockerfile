# FROM openjdk:8-jdk-alpine
FROM labprog/tp1-base

# Establece el directorio de trabajo
WORKDIR /usr/local

# Agrega Glassfish a la imagen
RUN wget http://ftp.osuosl.org/pub/eclipse/glassfish/web-5.1.0.zip && \
    jar xvf web-5.1.0.zip && \
    chmod +x glassfish5/glassfish/bin/* && \
    rm -f web-5.1.0.zip

## Configura variables de entorno
ENV PATH /usr/local/glassfish5/glassfish/bin:$PATH

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

# Expone los puertos
EXPOSE 8080 4848

# Comando por defecto al ejecutar el contenedor con 'run'
CMD [ "bash" ]
