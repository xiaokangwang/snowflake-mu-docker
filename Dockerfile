FROM golang:1.18-bullseye as builder
ARG SNOWFLAKE_REPO
ARG SNOWFLAKE_REPO_ANCHOR
ENV CGO_ENABLED=0
RUN git clone $SNOWFLAKE_REPO snowflake && cd snowflake && git checkout $SNOWFLAKE_REPO_ANCHOR
RUN cd snowflake/client && go get -d && go build -ldflags="-s -w" -o snowflake-client
RUN cd snowflake/proxy && go get -d && go build -ldflags="-s -w" -o snowflake-proxy
RUN cd snowflake/broker && go get -d && go build -ldflags="-s -w" -o snowflake-broker
RUN cd snowflake/server && go get -d && go build -ldflags="-s -w" -o snowflake-server


FROM gcr.io/distroless/static as broker
COPY --from=builder /go/snowflake/broker/snowflake-broker /snowflake-broker
CMD /snowflake-broker

FROM gcr.io/distroless/static as proxy
COPY --from=builder /go/snowflake/proxy/snowflake-proxy /snowflake-proxy
CMD /snowflake-broker

FROM alpine:edge as client
RUN apk add --no-cache tor
COPY --from=builder /go/snowflake/client/snowflake-client /snowflake-client
CMD tor

FROM alpine:edge as server
RUN apk add --no-cache tor
COPY --from=builder /go/snowflake/server/snowflake-server /snowflake-server
CMD tor
