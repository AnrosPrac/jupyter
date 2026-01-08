FROM jupyter/base-notebook

ENV JUPYTER_ENABLE_LAB=yes

COPY --chmod=755 start.sh /start.sh

CMD ["/start.sh"]
