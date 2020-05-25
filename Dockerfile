FROM golang:alpine AS app

RUN apk add upx

WORKDIR /src

COPY . .

#RUN go build -ldflags="-s -w" hello.go && upx hello-compressed
RUN go build -o app -a -ldflags="-s -w" -installsuffix cgo && \
    upx --ultra-brute -qq app && \
    upx -t app

WORKDIR /bin
RUN cp /src/app ./app

FROM scratch

COPY --from=app /bin .

ENTRYPOINT ["./app"]