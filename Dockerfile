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

RUN echo 'body { background-color: #0b0c0e; font-family: "SF Pro Display", "Roboto", sans-serif; padding: 30px !important; box-sizing: border-box; } .region.top.right { padding-right: 45px !important; text-align: right !important; } .region.top.left { padding-left: 15px !important; } .module.clock .time { font-size: 82px; font-weight: 200; color: #ffffff; letter-spacing: -2px; } .module.compliments { font-size: 26px; font-weight: 300; color: #ffffff; text-align: left; padding: 10px 0 20px 0; } .module .module-header { font-size: 14px; font-weight: 600; text-transform: uppercase; letter-spacing: 2px; color: #5cc2f2; border-bottom: 2px solid #1e222b; padding-bottom: 8px; margin-bottom: 15px; } .module.calendar .event { font-size: 16px; font-weight: 400; color: #e2e4e9; } .module.calendar .day { font-size: 15px; font-weight: 500; color: #8a8e99; padding-left: 20px; }' > /opt/magic_mirror/css/custom.css

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
