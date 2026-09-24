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

RUN echo 'body { background-color: #0d0e12; font-family: "SF Pro Display", "Roboto", "Helvetica Neue", sans-serif; -webkit-font-smoothing: antialiased; padding: 30px; } .module.clock .time { font-size: 80px; font-weight: 200; letter-spacing: -2px; color: #ffffff; padding-bottom: 5px; } .module.clock .date { font-size: 20px; font-weight: 400; color: #8e929a; text-transform: uppercase; letter-spacing: 1px; } .module .module-header { font-size: 14px; font-weight: 600; text-transform: uppercase; letter-spacing: 2px; color: #5cc2f2; border-bottom: 2px solid #1e222b; padding-bottom: 8px; margin-bottom: 15px; } .module.calendar table { width: 100%; border-spacing: 0 6px; } .module.calendar .event { font-size: 15px; font-weight: 400; color: #e2e4e9; } .module.calendar .day { font-size: 14px; font-weight: 500; color: #a1a5b0; padding-left: 15px; } .module.weather .large { font-size: 75px; font-weight: 200; color: #ffffff; }' > /opt/magic_mirror/css/custom.css

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
