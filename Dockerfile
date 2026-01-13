FROM jupyter/base-notebook

USER root

# ----------------------------
# System dependencies
# ----------------------------
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    gcc \
    g++ \
    make \
    python3-pip \
    \
    # 🔥 Playwright / Chromium runtime deps
    libglib2.0-0 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxrandr2 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxfixes3 \
    libxi6 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libatk1.0-0 \
    libcairo-gobject2 \
    libcairo2 \
    libgdk-pixbuf-2.0-0 \
    libxrender1 \
    libasound2 \
    libdbus-1-3 \
    fonts-liberation \
    \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------
# Python dependencies
# ----------------------------
RUN pip install --no-cache-dir \
    httpx \
    websockets \
    aioconsole \
    watchdog \
    fastapi \
    uvicorn \
    playwright

# ----------------------------
# Install Playwright browsers
# (runs as root → no sudo needed later)
# ----------------------------
RUN playwright install chromium

# ----------------------------
# Shell + Jupyter config
# ----------------------------
RUN chsh -s /bin/bash jovyan

USER jovyan

ENV JUPYTER_ENABLE_LAB=yes

COPY --chmod=755 start.sh /start.sh

CMD ["/start.sh"]
