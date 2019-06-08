FROM alpine as build

LABEL maintainer="goncalo.magno@gmail.com"

WORKDIR /tmp
RUN apk add --no-cache \
	cvs git zlib-dev make gcc g++ \
	&& cvs -d :pserver:cvs@cvs.fefe.de:/cvs -z9 co libowfat \
	&& git clone git://erdgeist.org/opentracker \
	&& cd /tmp/libowfat && make \
    && cd /tmp/opentracker && LDFLAGS=-static make \
    && cp /tmp/opentracker/opentracker /usr/local/bin \
	&& apk del cvs git zlib-dev make gcc g++ \
	&& rm -rf /var/cache/apk/* /tmp/* 

FROM scratch

USER 10001
COPY --from=build /usr/local/bin/opentracker /

ENTRYPOINT ["/opentracker"]
