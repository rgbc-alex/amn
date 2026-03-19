FROM golang:1.24.4 AS builder
COPY . /awg
WORKDIR /awg
RUN go mod download && \
    go mod verify && \
    go build -ldflags '-linkmode external -extldflags "-fno-PIC -static"' -v -o /usr/bin

FROM amneziavpn/amneziawg-go:latest
COPY --from=builder /usr/bin/amneziawg-go /usr/bin/amneziawg-go
