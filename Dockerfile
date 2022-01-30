FROM alpine:3.15.0

RUN mkdir /data /data/config /data/certs /data/ssh /var/lib/icinga2;\
    ln -s /data/config /etc/icinga2;\
    ln -s /data/certs /var/lib/icinga2/certs;\
    apk add --no-cache\
	bash\
	git\
	icinga2\
	monitoring-plugins\
	openssh\
	sudo;\
    echo 'icinga ALL=(ALL) NOPASSWD: /usr/sbin/icinga2, /sbin/apk del icinga2, /sbin/apk add icinga2 ' > /etc/sudoers.d/icinga;\
    chown icinga:icinga /var/lib/icinga2 ;\
    chown icinga:icinga /data -R
    

COPY --chown=icinga:icinga docker-entrypoint.sh /

USER icinga

EXPOSE 5665

HEALTHCHECK --interval=5m --timeout=3s \
	CMD curl -k https://localhost:5665

CMD /docker-entrypoint.sh && sudo icinga2 daemon
