ARG CADDY_VERSION=2.6.1
FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}-alpine

EXPOSE 80 443 2019

ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data

RUN apk add -U --no-cache ca-certificates curl

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

ENTRYPOINT ["/bin/caddy"]

CMD ["docker-proxy"]
