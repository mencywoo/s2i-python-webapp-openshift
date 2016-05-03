
# sti-simple-shell
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
MAINTAINER Mency Woo <mency.woo@gmail.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building python webapp" \
      io.k8s.display-name="builder 0.0.1" \
      io.openshift.expose-services="5000:http" \
      io.openshift.tags="builder,python-webapp-base."


# TODO: Install required packages here:
RUN yum update -y
RUN yum install -y python-pip sudo &&  yum clean all -y

ADD ./webapp/requirements.txt requirements.txt

RUN pip install -r requirements.txt

RUN chown -R 1001:1001 /opt/app-root

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ /usr/libexec/s2i

USER 1001


EXPOSE 5000
