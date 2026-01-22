FROM jupyter/base-notebook:python-3.11

USER root

# --------------------------------------------------
# System packages (C/C++ + build tools)
# --------------------------------------------------
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    git \
    curl \
    ca-certificates \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# --------------------------------------------------
# Python packages required for dataset generation
# --------------------------------------------------
RUN pip install --no-cache-dir \
    pymongo \
    google-generativeai \
    python-dotenv \
    httpx \
    websockets \
    aioconsole \
    watchdog \
    tqdm \
    numpy \
    regex

# --------------------------------------------------
# Environment safety for cloud + logs
# --------------------------------------------------
ENV PYTHONUNBUFFERED=1
ENV JUPYTER_ENABLE_LAB=yes
ENV JUPYTER_TOKEN=""
ENV JUPYTER_PASSWORD=""
ENV TZ=UTC

# --------------------------------------------------
# Shell + limits (important for Mongo + long runs)
# --------------------------------------------------
RUN chsh -s /bin/bash jovyan

USER jovyan

# --------------------------------------------------
# Start script
# --------------------------------------------------
COPY --chmod=755 start.sh /start.sh

CMD ["/start.sh"]
