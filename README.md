# tailscale-k8s
Use tailscale as sidecar pod in kubernetes. Scalable with pods.

Example kube yaml:
```
      - image: "ghcr.io/morpig/tailscale-k8s:latest"
        name: ts-sidecar
        imagePullPolicy: Always
        env:
          - name: TAILSCALE_AUTH_KEY
            value: "tailscalekey"
          - name: EXTRA_UP_ARGS
            value: "--accept-routes"
        securityContext:
          capabilities:
            add:
            - NET_ADMIN
```
