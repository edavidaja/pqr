# pqr

python, quarto, r

## usage

with a posit Connect API key with admin privileges:

```bash
CONNECT_SERVER=https://connect.example.com \
CONNECT_API_KEY= \
PYTHON_VERSION=3.11.9 \
QUARTO_VERSION=1.5.45 \
R_VERSION=4.4.1 \
deno run --allow-env --allow-net publish.ts
```

a list of [images published to the GitHub Container Registry](https://github.com/edavidaja/pqr/pkgs/container/pqr/versions?filters%5Bversion_type%5D=tagged) is here.
