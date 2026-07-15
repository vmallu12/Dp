# Ubuntu Desktop Docker (Railway Optimized)

A lightweight Ubuntu 24.04 Desktop using XFCE4, TigerVNC, and noVNC.

## Features

- Ubuntu 24.04 LTS
- XFCE4 Desktop
- Firefox
- TigerVNC
- noVNC
- Clipboard Support
- PulseAudio
- Dynamic Resolution
- Railway Ready
- Docker Ready
- Low RAM Usage
- Fast Startup
- Optimized for Low Latency

---

## Requirements

- Docker 24+
- Docker Compose (optional)
- 2 CPU
- 2 GB RAM Minimum
- 4 GB RAM Recommended

---

## Build

```bash
docker build -t ubuntu-desktop .
```

---

## Run

```bash
docker run -d \
--name ubuntu-desktop \
-p 6080:6080 \
-p 5901:5901 \
-e VNC_RESOLUTION=1366x768 \
-e TZ=UTC \
--shm-size=1g \
ubuntu-desktop
```

---

## Docker Compose

```bash
docker compose up -d
```

---

## Open Desktop

Open:

```
http://localhost:6080/vnc.html
```

or

```
http://YOUR_SERVER_IP:6080/vnc.html
```

---

## Railway

Railway automatically assigns the web port using the `PORT` environment variable.

After deployment:

```
https://YOUR-PROJECT.up.railway.app/vnc.html
```

---

## Environment Variables

| Variable | Default |
|----------|---------|
| TZ | UTC |
| DISPLAY | :1 |
| VNC_RESOLUTION | 1366x768 |
| PORT | 6080 |

---

## Recommended VPS

| CPU | RAM | Disk |
|-----|-----|------|
|2 Core|4 GB|20 GB SSD|

---

## Performance Tips

- Disable XFCE compositor.
- Use SSD storage.
- Set `--shm-size=1g`.
- Use a modern browser.
- Keep Firefox tabs to a reasonable number.

---

## Useful Commands

### Restart

```bash
docker restart ubuntu-desktop
```

### Stop

```bash
docker stop ubuntu-desktop
```

### Logs

```bash
docker logs -f ubuntu-desktop
```

### Shell

```bash
docker exec -it ubuntu-desktop bash
```

---

## Ports

| Port | Purpose |
|------|---------|
|6080|noVNC|
|5901|VNC|

---

## License

MIT
