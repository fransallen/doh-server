# Build
FROM rust:latest as cargo-build

RUN cargo install doh-proxy --no-default-features --root /usr/local/

# App
FROM alpine:latest

COPY --from=cargo-build /usr/local/bin /usr/local/bin

RUN useradd doh-proxy

USER doh-proxy

ENV LISTEN=0.0.0.0:8053
ENV RESOLVER=1.1.1.1:53

RUN doh-proxy --version

CMD ["doh-proxy --listen-address $LISTEN --server-address $RESOLVER"]
