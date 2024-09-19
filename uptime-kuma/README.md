# UptimeKuma on Fly.io - status.zac.gg

This dir holds the [fly.toml](./fly.toml) config file to deploy the UptimeKuma container to fly.io. This includes a 1CPU/1GB VM and a small volume mount to hold the UptimeKuma DB long term.

### Managing the app deployment
Use standard fly.io commands to run/stop the container:
```bash
# Deploy the container to fly based on the fly.toml config
fly deploy

# scale the existing app to 0 (stop the service)
fly scale --app zacs-uptime-kuma count=0

# scale the existing app to 1 (start the service)
fly scale --app zacs-uptime-kuma count=1
```

FYI: To access the Fly.io VM directly to upload/download UptimeKuma data files, look at the [fly.io docs](https://fly.io/docs/flyctl/ssh/)
