# digitalocean-doctl-snapshots

This is a portable docker base solution to automate droplet snapshots and droplet snapshot rotation in Digital Ocean.

It uses [doctl](https://github.com/digitalocean/doctl) (the official CLI)

>I had to copy the Dockerfile from source to put in the path and not using the `ENTRYPOINT`

To use this container just create a new deveoper token in <https://cloud.digitalocean.com/account/api/tokens> and run the container

```bash
docker run --rm \
    --env=DIGITALOCEAN_ACCESS_TOKEN=[your digital ocean token here] \
    omerha/digitalocean-doctl-snapshots:latest
```
