FROM alpine:3.10 AS build
RUN apk add gcc g++ zlib-dev libc-dev curl make bzip2
WORKDIR /build
RUN curl -OL https://github.com/lh3/minimap2/releases/download/v2.17/minimap2-2.17.tar.bz2
RUN tar xjf minimap2-2.17.tar.bz2
WORKDIR /build/minimap2-2.17
RUN make

FROM alpine:3.10
COPY --from=build /build/minimap2-2.17/minimap2 /usr/local/bin
