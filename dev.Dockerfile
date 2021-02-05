FROM golang:1.14-alpine

WORKDIR /app

ENV RUN_ARGS=serve
ENV PORT=8080

RUN addgroup 1000
RUN adduser -G 1000 -s /bin/sh -D www

RUN apk update
RUN apk add --no-cache git shadow gcc libc-dev build-base

RUN mkdir -p /go/pkg/mod/cache
RUN chown -R www:1000 /go

RUN mkdir -p /app/.dlv
RUN chown -R www:1000 /app/.dlv

COPY ./bin/start.sh /
RUN chmod +x /start.sh

USER www

RUN go get -u github.com/sourcegraph/go-langserver
RUN go get -u github.com/mdempsky/gocode
RUN go get github.com/uudashr/gopkgs/cmd/gopkgs
RUN go get -u github.com/cespare/reflex
RUN go get -u github.com/go-delve/delve/cmd/dlv
RUN go get -u -v golang.org/x/tools/gopls 2>&1
RUN go get -u sourcegraph.com/sqs/goreturns

EXPOSE ${PORT}

ENTRYPOINT ["/start.sh"]
