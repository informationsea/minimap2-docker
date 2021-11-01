FROM alpine:3.10 AS build
RUN apk add gcc g++ zlib-dev libc-dev curl make bzip2
WORKDIR /build
ARG MINIMAP2_VERSION=2.22
RUN curl -OL https://github.com/lh3/minimap2/releases/download/v$MINIMAP2_VERSION/minimap2-$MINIMAP2_VERSION.tar.bz2
RUN tar xjf minimap2-$MINIMAP2_VERSION.tar.bz2
WORKDIR /build/minimap2-$MINIMAP2_VERSION
RUN make

FROM alpine:3.10
RUN apk add bash
ARG MINIMAP2_VERSION=2.22
COPY --from=build /build/minimap2-$MINIMAP2_VERSION/minimap2 /usr/local/bin
