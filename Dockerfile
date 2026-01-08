FROM jupyter/base-notebook

ENV JUPYTER_ENABLE_LAB=yes

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
