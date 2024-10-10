FROM debian:latest AS build
WORKDIR /usr/src

RUN apt-get update && apt-get install -y build-essential git
RUN git clone https://github.com/opensrcsec/paxtest && cd paxtest && make linux -j`nproc`

FROM debian:latest AS run
COPY --from=build /usr/src/paxtest /opt/paxtest
WORKDIR /opt/paxtest
CMD ["./paxtest", "blackhat"]
