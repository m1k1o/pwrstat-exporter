FROM python:3.7

WORKDIR /usr/src/pwrstat-exporter

RUN groupadd --gid 5001 pwrstat-exporter; \
	useradd --no-log-init --no-create-home --home-dir /usr/src/pwrstat-exporter --uid 5001 --gid 5001 --shell /bin/false pwrstat-exporter;\
	
	mkdir -p /usr/src/pwrstat-exporter; \
	chown pwrstat-exporter:pwrstat-exporter /usr/src/pwrstat-exporter; \
	
	mkdir -p /var/log/pwrstat-exporter; \
	chown pwrstat-exporter:pwrstat-exporter /var/log/pwrstat-exporter; \

	wget -O powerpanel.deb https://dl4jz3rbrsfum.cloudfront.net/software/powerpanel_132_amd64.deb; \
	dpkg -i powerpanel.deb; \

	pip install dumb-init;

COPY --chown=5001:5001 startup.sh definitions.json pwrstat-exporter ./

RUN python -OO -m py_compile pwrstat-exporter

EXPOSE 9546

ENTRYPOINT ["dumb-init", "--"]
CMD ["bash", "/usr/src/pwrstat-exporter/startup.sh"]

