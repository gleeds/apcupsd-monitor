# apcupsd-monitor
Docker container to expose [apcupsd](http://www.apcupsd.org/) data for use by Prometheus/Grafana 

Connects to APC UPS devices via a USB and exposes data for consumption by Prometheus.  I use this on a Raspberry Pi to add 
my UPS data to [InternetPi](https://github.com/geerlingguy/internet-pi).

This project makes use of [apcupsd_exporter](https://github.com/mdlayher/apcupsd_exporter) to expose
apcupsd's metrics over HTTP in a form Prometheus can easily consume.

# Configuration
Edit `apcupsd.conf` as you see fit, particuarly if you prefer to use an Ethernet connected APC UPS device.  You must rebuild
existing container images after changes to this file.

# Building
Build the container locally by running:
`docker build -t apcupsd-docker:latest .`

# Running
Assuming you have a `docker-compose.yaml` file already for Prom/Grafana, add a service as follows:
```yaml
  apcups:
    image: apcupsd-docker:latest
    expose:
      - 9162
    ports:
      - 9162:9162
    restart: always
    devices:
      - "/dev/usb/hiddev0:/dev/usb/hiddev0"
```

# Integration with Prometheus/Grafana
## Prometheus
Add somethign like this to your `prometheus.yml`
```yaml
  - job_name: 'ups'
    static_configs:
      - targets: ['apcups:9162']
```

## Grafana
A sample Grafana dashboard configuration file is provided in `/grafana/ups.json`.  

# TODO
* Add the ability to pull configuration at runtime rather than build time
