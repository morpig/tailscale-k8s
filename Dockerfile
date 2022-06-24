FROM alpine:latest
WORKDIR /app
ENV TSFILE=tailscale_1.26.1_amd64.tgz
RUN wget https://pkgs.tailscale.com/stable/${TSFILE} && tar xzf ${TSFILE} --strip-components=1
COPY . ./

RUN apk update && apk add ca-certificates iptables ip6tables && rm -rf /var/cache/apk/*

# Copy binary to production image
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale
RUN chmod 755 start.sh

# Run on container startup.
CMD ["/app/start.sh"]
