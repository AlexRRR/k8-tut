FROM phusion/baseimage:0.9.19


RUN mkdir -p /state && echo "WAIT" > /state/state.run
COPY silkyanteater.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/silkyanteater.sh
CMD ["/usr/local/bin/silkyanteater.sh"]
