FROM node:24-bookworm-slim

# Install dependencies
# Note: python2.7 is increasingly rare in modern distros;
# if it fails, consider if the modules actually need it or if python3 suffices.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    netcat-openbsd \
    make \
    g++ \
    python3 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Ensure 'python' points to 'python3' as python2.7 is deprecated
RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /world

# Install screeps and common mods in one layer
RUN npm install screeps \
    screepsmod-mongo \
    screepsmod-auth \
    screepsmod-admin-utils \
    screepsmod-map-tool \
    screepsmod-history

# Copy scripts and configurations
COPY scripts/install.sh /usr/local/bin/installMods
COPY scripts/reset.sh /usr/local/bin/resetData
COPY scripts/install.sh /installMods.sh
COPY scripts/reset.sh /resetData.sh
COPY scripts/startup.sh startup.sh
COPY config/mods.json mods.json-temp
COPY config/.screepsrc .screepsrc-temp
COPY config/config.yml config.yml

# Ensure scripts are executable
RUN chmod +x /usr/local/bin/installMods /usr/local/bin/resetData /installMods.sh /resetData.sh startup.sh

CMD ["bash", "/world/startup.sh"]
