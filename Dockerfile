# dump build stage
FROM postgres:11-alpine as dumper

COPY question.sql /docker-entrypoint-initdb.d/
COPY Auth.sql /docker-entrypoint-initdb.d/
COPY model.sql /docker-entrypoint-initdb.d/
COPY product.sql /docker-entrypoint-initdb.d/


RUN ["sed", "-i", "s/exec \"$@\"/echo \"skipping...\"/", "/usr/local/bin/docker-entrypoint.sh"]

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV PGDATA=/data

RUN ["/usr/local/bin/docker-entrypoint.sh", "postgres"]

# final build stage
FROM postgres:11-alpine

COPY --from=dumper /data $PGDATA
