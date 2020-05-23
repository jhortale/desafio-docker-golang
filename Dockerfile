FROM golang:alpine AS app

WORKDIR /src

COPY . .

RUN go build hello.go

WORKDIR /bin
RUN cp /src/hello ./hello

FROM scratch

COPY --from=app /bin .

ENTRYPOINT ["./hello"]