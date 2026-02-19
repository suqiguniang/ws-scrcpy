FROM node:16
LABEL maintainer="Scavin <scavin@appinn.com>"

ENV LANG C.UTF-8
WORKDIR /ws-scrcpy

# 安装系统依赖（注意包名改为 adb）
RUN apt-get update 
RUN apt-get install -y --no-install-recommends adb
RUN rm -rf /var/lib/apt/lists/*

# 全局安装 node-gyp（如果需要）
RUN npm install -g node-gyp

# 克隆项目并安装 Node 依赖
RUN git clone https://github.com/NetrisTV/ws-scrcpy.git . && \
    npm install && \
    npm run dist

EXPOSE 8000

CMD ["node", "dist/index.js"]
