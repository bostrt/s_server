FROM centos:latest

RUN yum install -y openssl && yum clean all
RUN openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj '/CN=localhost' -nodes

COPY run.sh .
EXPOSE 8080 

ENTRYPOINT ["./run.sh"]
