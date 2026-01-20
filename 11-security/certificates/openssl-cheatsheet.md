# OpenSSL Certificate Cheatsheet

## Generate Self-Signed Certificates

Generate a new RSA 2048-bit key and self-signed certificate (valid for 10 years):

```bash
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem
```

Using a specific config file:

```bash
openssl req -config "openssl.cnf" -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem
```

## Serving with HTTP-Server

Serve a PWA or static site with SSL using `http-server`:

```bash
http-server -S -C cert.pem -o -c-1 ./dist/pwa
```
