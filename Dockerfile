FROM openjdk:8-alpine

ENV DIGDAG_VERSION=0.9.39
ENV EMBULK_VERSION=0.9.16
ENV AWSCLI_VERSION=1.16.139

WORKDIR /var/lib/digdag
COPY Gemfile Gemfile.lock ./

RUN apk add --no-cache curl && \
    apk add --no-cache libc6-compat && \
    curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-$DIGDAG_VERSION" && \
    chmod +x /usr/local/bin/digdag && \
    curl -o /usr/local/bin/embulk --create-dirs -L "https://dl.bintray.com/embulk/maven/embulk-${EMBULK_VERSION}.jar" && \
    chmod +x /usr/local/bin/embulk && \
    apk del curl && \
    adduser -h /var/lib/digdag -g 'digdag user' -s /sbin/nologin -D digdag && \
    mkdir -p /var/lib/digdag/logs/tasks /var/lib/digdag/logs/server && \
    chown -R digdag.digdag /var/lib/digdag && \
    apk --no-cache update && \
    apk --no-cache add ruby-dev ruby-bundler ruby-json && \
    bundle install && \
    apk --no-cache add ca-certificates curl groff less gettext && \
    apk --no-cache add bash jq && \
    apk --no-cache add python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    pip3 install --no-cache awscli==${AWSCLI_VERSION} && \
    rm -rf /var/cache/apk/*

ADD requirements.txt ./
RUN pip3 install -r ./requirements.txt

USER digdag
WORKDIR /var/lib/digdag

RUN embulk gem install embulk-input-mysql:0.9.3     \
                       embulk-input-s3:0.2.21       \
                       embulk-input-google_spreadsheets:1.1.0 \
                       embulk-output-parquet:0.5.0  \
                       embulk-output-s3:1.5.0       \
                       embulk-output-mysql:0.8.2 \
                       embulk-filter-row            \
                       embulk-filter-column         \
                       embulk-filter-add_time:0.2.0 \
                       embulk-filter-eval:0.1.0     \
                       embulk-filter-expand_json:0.2.2 \
                       embulk-formatter-jsonl:0.1.4 \
                       embulk-parser-json:0.0.7

COPY fixtures/mysql /docker-entrypoint-initdb.d/
ADD scripts scripts
ADD tasks tasks
ADD docker-entrypoint.sh ./
ADD config.template.yml ./
ADD allow.properties ./
ADD *.dig ./

USER root
RUN ["chmod", "+x", "/var/lib/digdag/docker-entrypoint.sh"]
RUN chown -R digdag.digdag /var/lib/digdag

USER digdag
ENTRYPOINT ["/var/lib/digdag/docker-entrypoint.sh"]

