FROM jupyter/base-notebook

USER root

# Install C / C++ compilers, tools, curl, and python dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    gcc \
    g++ \
    make \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install the specific libraries Lum needs
RUN pip install --no-cache-dir httpx websockets aioconsole watchdog

# Ensure bash is the default shell
RUN chsh -s /bin/bash jovyan

USER jovyan

ENV JUPYTER_ENABLE_LAB=yes

COPY --chmod=755 start.sh /start.sh

CMD ["/start.sh"]