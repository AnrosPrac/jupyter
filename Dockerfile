FROM jupyter/base-notebook

USER root

# Install C / C++ compilers and tools
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    gcc \
    g++ \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Ensure bash is the default shell
RUN chsh -s /bin/bash jovyan

USER jovyan

ENV JUPYTER_ENABLE_LAB=yes

COPY --chmod=755 start.sh /start.sh

CMD ["/start.sh"]
