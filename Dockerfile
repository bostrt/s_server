FROM centos:latest

RUN yum install -y openssl && yum clean all

COPY run.sh .
EXPOSE 8080 

ENTRYPOINT ["./run.sh"]
