# pwrstat-exporter
CyberPower pwrstat to prometheus exporter.


Run via docker with:

```sh
docker run -d \
    --name pwrstat-exporter \
    --privileged \
    -p 9546:9546 \
    ksanislo/pwrstat-exporter
```

Run via docker compose with:

```yml
version: "3.8"

services:
  pwrstat-exporter:
    build: "./containers/pwrstat-exporter"
    restart: "unless-stopped"
    privileged: true
```

