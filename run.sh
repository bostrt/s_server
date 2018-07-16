#!/bin/bash
openssl s_server -cert cert.pem -key key.pem -accept 8443 -www
