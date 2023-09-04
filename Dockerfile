FROM golang:1.19-alpine AS build_deps

RUN apk add --no-cache git bash curl make

WORKDIR /workspace

COPY go.mod .
COPY go.sum .

RUN go mod download

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
