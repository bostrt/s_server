#!/bin/bash
_cert_filename=${CERT_FILENAME:="cert.pem"}
_key_filename=${KEY_FILENAME:="key.pem"}
_cert="/tmp/${_cert_filename}"
_key="/tmp/${_key_filename}"

if [ -d "/certs" ]; then
        # Use mounted certificates volume.
        _cert="/certs/${_cert_filename}"
        _key="/certs/${_key_filename}"
else
	openssl req -x509 -newkey rsa:4096 -keyout $_key -out $_cert -days 365 -subj '/CN='$(hostname) -nodes
fi

openssl s_server -cert $_cert -key $_key -accept 8080 -www $@
