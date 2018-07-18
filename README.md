# openssl s_server container image

CentOS-based container image with `openssl` installed. The default `ENTRYPOINT` is the `openssl s_server`
command which starts up a simple SSL/TLS server. Self-signed certificates are generated on container start-up and 
used by `s_server`. You can also specify your own certificates by mounting a volume at `/certs` containing a 
`cert.pem` and `key.pem` which are automatically picked up by the container. If you want to use different filenames
for the customer certs, you can override them using the environment variables `CERT_FILENAME` and `KEY_FILENAME`.

# Usage

## Most basic

```
# docker run -d --rm -it -p 8080:8080 bostrt/s_server
# curl -k https://localhost:8080/
```

## Custom certificates

Generate certificates (or just use your own):
```
# mkdir /tmp/mycerts
# openssl req -x509 -newkey rsa:4096 -keyout /tmp/mycerts/key.pem -out /tmp/mycerts/cert.pem -days 365 -subj '/CN=localhost' -nodes
```

Start up container
```
# docker run -v /tmp/mycerts:/certs -d --rm -it -p 8080:8080 s_server
# curl -k https://localhost:8080/
```

## Extra startup arguments

The `ENTRYPOINT` script accepts arguments from command line which are passed to `openssl s_server`. For example, forcing a specific TLS protocol:
```
# docker run -d --rm -it -p 8080:8080 bostrt/s_server -no_tls1 -no_tls1_1
# curl --tlsv1.1 -k https://localhost:8080/
curl: (35) Peer using unsupported version of security protocol.
```

See man page (`man s_server`) or this webpage for available options: <https://www.openssl.org/docs/man1.0.2/apps/openssl-s_server.html>.

# OpenShift

Using this container image is OpenShift is very easy and you can get going with one command.

```
# oc new-app bostrt/s_server
# oc create route passthrough --service=sserver
# oc get routes
```
