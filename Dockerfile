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

RUN echo 'html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; background: linear-gradient(145deg, #05070e 0%, #0a0f1d 100%); font-family: "SF Pro Display", sans-serif; box-sizing: border-box; } body { display: flex; flex-direction: row; padding: 25px !important; gap: 20px; } .main-grid { display: flex; width: 100%; height: 100%; justify-content: space-between; } .region.top.left, .region.top.right { display: flex; flex-direction: column; width: 48% !important; float: none !important; clear: none !important; } .module.clock .time { font-size: 5rem; font-weight: 200; color: #ffffff; line-height: 1; } .module.compliments { font-size: 1.2rem; font-weight: 400; color: #FFD700; padding: 5px 0 15px 0; } .module .module-header { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 1.5px; color: #5cc2f2; border-bottom: 2px solid #1a263f; padding-bottom: 6px; margin-bottom: 10px; } .module.calendar table { width: 100%; border-collapse: separate; border-spacing: 0 4px; } .module.calendar tr { background: rgba(255, 255, 255, 0.02); border-radius: 4px; } .module.calendar td { padding: 6px 10px !important; font-size: 13px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; } .module.calendar .event { color: #ffffff; font-weight: 500; } .module.calendar .day { color: #FFD700; font-weight: 600; text-align: right; } .module.weather .large { font-size: 4rem; font-weight: 200; color: #ffffff; } .module.weather .precipitation { color: #5cc2f2 !important; font-weight: 600; margin-left: 5px; } @media (orientation: portrait) { body { flex-direction: column; } .region.top.left, .region.top.right { width: 100% !important; height: 50%; } .module.clock .time { font-size: 3.5rem; } } @media screen and (time-range: 21:00-06:00) { body { filter: brightness(0.35) grayscale(0.2) !important; transition: filter 2s ease; } }' > /opt/magic_mirror/css/custom.css

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
