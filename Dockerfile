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

RUN echo 'html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; background: #060913; font-family: "SF Pro Display", sans-serif; box-sizing: border-box; } body { display: flex; flex-direction: row; padding: 25px 35px !important; gap: 35px; justify-content: space-between; } .region.top.left, .region.top.right { display: flex; flex-direction: column; width: 46% !important; float: none !important; clear: none !important; max-height: calc(100vh - 50px) !important; overflow-y: hidden !important; box-sizing: border-box; } .module.clock .time { font-size: 4rem; font-weight: 200; color: #ffffff; line-height: 1; } .module.compliments { font-size: 1.1rem; font-weight: 400; color: #FFD700; padding: 5px 0 12px 0; } .module .module-header { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 1.5px; color: #5cc2f2; border-bottom: 2px solid #1a263f; padding-bottom: 6px; margin-bottom: 12px; } .module.calendar { overflow-y: auto !important; max-height: 55vh !important; } .module.calendar table { width: 100% !important; border-collapse: separate !important; border-spacing: 0 6px !important; } .module.calendar tr { background: rgba(255, 255, 255, 0.04) !important; border-radius: 6px !important; display: table-row !important; } .module.calendar td { padding: 10px 12px !important; font-size: 13px !important; vertical-align: middle !important; } .module.calendar td.title { color: #ffffff !important; font-weight: 500; width: 62%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; } .module.calendar td.time { color: #FFD700 !important; font-weight: 600; text-align: right; width: 38%; border-left: 1px solid rgba(255, 255, 255, 0.08); padding-left: 12px !important; } .module.weather .large { font-size: 3.2rem; font-weight: 200; color: #ffffff; } .module.weather table { width: 100% !important; font-size: 12px !important; } .module.weather table td { padding: 5px 4px !important; }' > /opt/magic_mirror/css/custom.css

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
