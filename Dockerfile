FROM alpine:latest
MAINTAINER Ivan Buetler <ivan.buetler@compass-security.com>

# Add s6-overlay
# PREVIOUS ENV S6_OVERLAY_VERSION=v1.22.1.0 \
ENV S6_OVERLAY_VERSION=v2.1.0.2 \
    GO_DNSMASQ_VERSION=1.0.7

RUN apk add --update --no-cache bind-tools curl libcap bash net-tools openssl && \ 
	apk upgrade --available && \
	curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C /  && \
	curl -sSL https://github.com/janeczku/go-dnsmasq/releases/download/${GO_DNSMASQ_VERSION}/go-dnsmasq-min_linux-amd64 -o /bin/go-dnsmasq && \
	chmod +x /bin/go-dnsmasq && \
	addgroup go-dnsmasq && \
	adduser -D -g "" -s /bin/sh -G go-dnsmasq go-dnsmasq && \
	setcap CAP_NET_BIND_SERVICE=+eip /bin/go-dnsmasq && \
	rm -rf /var/cache/apk/*

COPY root /

ENTRYPOINT ["/init"]
CMD []
