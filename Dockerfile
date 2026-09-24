FROM node:22-bookworm

RUN set -e; \
    apt update; \
    apt install -y gettext; \
    rm -rf /var/lib/apt/lists/*

ARG branch=master

ENV NODE_ENV production
WORKDIR /opt/magic_mirror

RUN git clone --depth 1 -b ${branch} https://github.com/MichMich/MagicMirror.git .
RUN cp -R modules /opt/default_modules
RUN cp -R config /opt/default_config
RUN npm install --legacy-peer-deps

COPY config.js /opt/magic_mirror/config/config.js
COPY docker-entrypoint.sh ./
RUN chmod +x ./docker-entrypoint.sh

RUN echo 'body { background-color: #0b0c10; font-family: "Roboto", sans-serif; } .module.clock .time { font-size: 75px; font-weight: 300; color: #ffffff; } .module.calendar header, .module.weather header { font-size: 16px; letter-spacing: 2px; color: #66fcf1; border-bottom: 1px solid #1f2833; }' >> /opt/magic_mirror/css/custom.css

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
