FROM golang:1.13-alpine AS build_deps

RUN apk add --no-cache git bash curl make

WORKDIR /workspace
ENV GO111MODULE=on

COPY go.mod .
COPY go.sum .

RUN go mod download

RUN make fetch-test-binaries

FROM build_deps AS build

COPY . .

RUN CGO_ENABLED=0 go build -o webhook -ldflags '-w -extldflags "-static"' .
ARG SKIP_VERIFY=true
RUN ${SKIP_VERIFY} || make verify


FROM alpine

RUN apk update \
        && apk upgrade \
        && apk add --no-cache \
        ca-certificates bash curl \
        && update-ca-certificates 2>/dev/null || true

COPY --from=build /workspace/webhook /usr/local/bin/webhook

ENTRYPOINT ["webhook"]
