
# openshift-tomcat7-svn
FROM docker.io/centos

# TODO: Put the maintainer name in the image metadata
MAINTAINER Nicholas C <gchen@redhat.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building tomcat" \
      io.k8s.display-name="builder tomcat" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,tomcat,java,etc." 

# TODO: Install required packages here:
RUN yum install -y java-1.7.0-openjdk subversion maven tomcat && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i
COPY ./tomcat7/ /opt/app-root/tomcat7

# TODO: Copy the S2I scripts to /usr/local/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /usr/local/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN groupadd -g 1002 jboss && \
    useradd -ms /bin/bash -u 1002 -g 1002 jboss &&\
    chown -R 1002:1002 /opt/app-root && \
    chmod -R a+w /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1002

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# TODO: Set the default CMD for the image
CMD ["uname"]
