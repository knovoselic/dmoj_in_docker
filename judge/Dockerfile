FROM python:2-stretch

RUN set -ex \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        gcc \
        zip \
        libseccomp-dev \
        apt-transport-https \
        ruby2.3 \
        openjdk-8-jdk-headless

RUN set -ex \
 && wget -O - "https://get.sdkman.io" | bash \
 && bash -c '. ~/.sdkman/bin/sdkman-init.sh && sdk install kotlin'

RUN set -ex \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
 && echo "deb https://download.mono-project.com/repo/debian stable-stretch main" > /etc/apt/sources.list.d/mono-official-stable.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends mono-devel \
 && rm -rf /var/lib/apt/lists/*

RUN set -ex \
  && mkdir /app \
  && cd /app \
  && git clone https://github.com/DMOJ/judge.git
WORKDIR /app/judge

RUN set -ex && git submodule update --init --recursive
RUN set -ex && pip install cython
RUN set -ex && pip install -e .

COPY start.sh /app/judge/start.sh
COPY config.yml /app/judge/config.yml

RUN set -ex && mkdir /app/judge/problems

CMD /app/judge/start.sh
