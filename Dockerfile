FROM alpine:3.8
LABEL maintainer="Ricco Førgaard <ricco@vimond.com>"

RUN apk add --no-cache --virtual=build-dependencies ca-certificates

ADD dist/ /tmp/
RUN tar -xf /tmp/oauth2_proxy-2.3.0.linux-amd64.go*.tar.gz -C /bin --strip-components=1 \
    && mv /bin/oauth2_proxy-2.3.0.linux-amd64 /bin/oauth2_proxy \
    && rm /tmp/*.tar.gz

EXPOSE 4180
ENTRYPOINT [ "./bin/oauth2_proxy" ]
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
