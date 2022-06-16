FROM golang:latest AS builder
RUN git clone https://github.com/mdlayher/apcupsd_exporter.git
WORKDIR apcupsd_exporter
RUN go build cmd/apcupsd_exporter/main.go

FROM ubuntu:18.04
RUN apt-get update && apt-get install -y apcupsd && rm -rf /var/lib/apt/lists/*
COPY apcupsd.conf /etc/apcupsd/apcupsd.conf
COPY apc_init.sh /bin/apc_init.sh
COPY --from=builder /go/apcupsd_exporter/main /sbin/apcupsd_exporter

EXPOSE 9162
CMD [ "/bin/apc_init.sh" ]

