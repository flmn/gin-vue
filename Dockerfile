FROM golang:1.17-alpine AS gobuilder
ENV CGO_ENABLED=0 \
    GOPROXY="https://goproxy.io,direct"
WORKDIR /build
COPY backend/go.mod .
COPY backend/go.sum .
RUN go mod download
COPY backend .
RUN go build -o server

FROM node:16-alpine AS nodebuilder
WORKDIR /build
COPY frontend/package.json .
COPY frontend/package-lock.json .
RUN npm i
COPY frontend .
RUN npm run build

FROM alpine:latest
COPY --chown=1000:1000 --from=gobuilder /build/server /app/server
COPY --chown=1000:1000 --from=nodebuilder /build/dist /app/dist
USER 1000
WORKDIR /app
ENTRYPOINT ["./server"]