FROM swift:4.0.3

USER root
RUN mkdir -p /server
COPY ./Config /server/Config
COPY ./Sources /server/Sources
COPY ./Makefile /server/Makefile
COPY ./Package.resolved /server/Package.resolved
COPY ./Package.swift /server/Package.swift

ENV PORT 9000

EXPOSE 9000

WORKDIR /server

RUN make build

CMD ["make", "run"]
