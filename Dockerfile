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

RUN echo 'html, body { height: 100vh; width: 100vw; margin: 0; padding: 0; overflow: hidden; background: #060913; background-image: linear-gradient(145deg, #04060c 0%, #0b1120 100%); font-family: "SF Pro Display", -apple-system, sans-serif; box-sizing: border-box; } body { display: flex; flex-direction: row; padding: 35px 45px !important; gap: 40px; justify-content: space-between; position: relative !important; } .region.top.left { display: flex; flex-direction: column; width: 52% !important; box-sizing: border-box; } .region.top.right { display: flex; flex-direction: column; width: 40% !important; position: absolute !important; right: 45px !important; top: 35px !important; text-align: right !important; box-sizing: border-box; } .module.clock .time { font-size: 4.5rem; font-weight: 200; color: #ffffff; line-height: 1; text-shadow: 0 4px 10px rgba(0,0,0,0.4); } .module.clock .date { color: #8a8e99 !important; font-weight: 500; letter-spacing: 0.5px; } .module.compliments { font-size: 1.25rem; font-weight: 400; color: #FFD700; padding: 8px 0 16px 0; text-shadow: 0 2px 4px rgba(0,0,0,0.2); } .module .module-header { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: #FFD700; border-bottom: 2px solid #1a263f; padding-bottom: 8px; margin-bottom: 14px; text-align: left !important; } .region.top.right .module .module-header { text-align: right !important; } .module.calendar { overflow-y: hidden !important; max-height: 55vh !important; } .module.calendar table { width: 100% !important; border-collapse: separate !important; border-spacing: 0 8px !important; } .module.calendar tr { background: linear-gradient(90deg, rgba(255,255,255,0.03) 0%, rgba(255,255,255,0.05) 100%) !important; border-radius: 6px !important; display: table-row !important; box-shadow: 0 3px 8px rgba(0,0,0,0.3); transition: all 0.2s ease; } .module.calendar td { padding: 12px 14px !important; font-size: 13.5px !important; vertical-align: middle !important; } .module.calendar td.title { color: #ffffff !important; font-weight: 600 !important; text-align: left !important; width: 60%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; letter-spacing: 0.2px; } .module.calendar td.time { color: #FFD700 !important; font-weight: 500; text-align: right !important; width: 40%; border-left: 1px solid rgba(255, 255, 255, 0.08); padding-left: 14px !important; } .module.weather .large { font-size: 4rem; font-weight: 200; color: #ffffff; text-align: right !important; text-shadow: 0 4px 10px rgba(0,0,0,0.3); } .module.weather table { width: 100% !important; font-size: 12.5px !important; margin-left: auto !important; border-collapse: separate !important; border-spacing: 0 4px !important; } .module.weather table tr { opacity: 1 !important; background: rgba(255,255,255,0.01); } .module.weather table td { padding: 6px 8px !important; text-align: right !important; opacity: 1 !important; color: #ffffff !important; } .module.weather table td.day { color: #a2a6b0 !important; font-weight: 500; text-align: left !important; }' > /opt/magic_mirror/config/custom.css


EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
