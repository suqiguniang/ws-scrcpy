FROM node:16-bullseye
LABEL maintainer="Scavin <scavin@appinn.com>"

ENV LANG C.UTF-8
WORKDIR /ws-scrcpy

# 安装基础工具（wget, unzip）并清理缓存
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip && \
    rm -rf /var/lib/apt/lists/*

# 下载并安装官方 platform-tools（包含最新 adb）
RUN wget -q https://dl.google.com/android/repository/platform-tools-latest-linux.zip && \
    unzip -q platform-tools-latest-linux.zip -d /opt && \
    rm platform-tools-latest-linux.zip && \
    ln -s /opt/platform-tools/adb /usr/local/bin/adb

# 验证 adb 版本（可选）
RUN adb --version

# 全局安装 node-gyp（ws-scrcpy 构建可能需要）
RUN npm install -g node-gyp

# 克隆项目并安装依赖
RUN git clone https://github.com/NetrisTV/ws-scrcpy.git . && \
    npm install && \
    npm run dist

EXPOSE 8000

CMD ["node", "dist/index.js"]
