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

RUN echo 'body { background-color: #060913; background-image: linear-gradient(145deg, #060913 0%, #0d1527 100%); font-family: "SF Pro Display", -apple-system, sans-serif; padding: 40px !important; box-sizing: border-box; } .region.top.right { padding-right: 45px !important; } .module.clock .time { font-size: 85px; font-weight: 200; color: #ffffff; text-shadow: 0 4px 12px rgba(0,0,0,0.3); } .module.compliments { font-size: 22px; font-weight: 400; color: #FFD700; padding: 10px 0; font-style: normal; letter-spacing: 0.5px; } .module .module-header { font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: #5cc2f2; border-bottom: 2px solid #1a263f; padding-bottom: 8px; margin-bottom: 15px; } .module.calendar table { width: 100%; border-collapse: separate; border-spacing: 0 8px; } .module.calendar tr { background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05); border-radius: 6px; box-shadow: 0 2px 5px rgba(0,0,0,0.2); } .module.calendar td { padding: 10px 14px !important; font-size: 15px; } .module.calendar .event { color: #ffffff; font-weight: 500; } .module.calendar .day { color: #FFD700; font-weight: 600; text-align: right; } @media (prefers-color-scheme: dark) { body { animation: nightDim 1s forwards; } } @keyframe nightDim { from { filter: brightness(1); } to { filter: brightness(1); } } @media screen and (time-range: 21:00-06:00) { body { filter: brightness(0.4) grayscale(0.2) !important; transition: filter 2s ease; } }' > /opt/magic_mirror/css/custom.css

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
