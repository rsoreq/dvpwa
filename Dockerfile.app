FROM python:alpine3.8@sha256:3491d1abd29b3f87ca5cb1afd34bc696855a2403df1ff854da55cb6754af1ff8

RUN apk add --no-cache wget \
    && wget -O /usr/bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/master/wait-for \
    && chmod +x /usr/bin/wait-for \
    && apk del wget

COPY requirements.txt /tmp

RUN apk add --no-cache --virtual build-deps gcc python3-dev musl-dev \
    && apk add --no-cache postgresql-dev \
    && pip install -r /tmp/requirements.txt \
    && apk del build-deps

RUN rm -rf /tmp/requirements.txt

WORKDIR /app
ADD ./run.py /app
ADD ./sqli /app/sqli
ADD ./config /app/config
