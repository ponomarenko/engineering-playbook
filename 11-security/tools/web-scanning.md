# Web Scanning & Mirroring Tools

## WPScan

Scan a WordPress site for vulnerabilities:

```bash
wpscan --url https://example.com/
```

## Wget Mirroring

Download a full website for offline viewing (mirroring):

Option 1 (Explicit flags):

```bash
wget --mirror --convert-links --adjust-extension --page-requisites --no-parent https://example.com
```

Option 2 (Short flags):

```bash
# -r: recursive
# -np: no parent
# -k: convert links
# -p: page requisites
wget -r -np -k -p https://example.com
```
