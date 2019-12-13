FROM centos:latest

RUN yum install -y openssl && yum clean all
USER 1000

COPY run.sh .
EXPOSE 8080 

ENTRYPOINT ["./run.sh"]
