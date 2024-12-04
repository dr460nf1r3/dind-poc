FROM docker:27-dind

RUN apk add --no-cache git docker-compose bash

COPY ./compose.yaml /compose.yaml
COPY ./entry_point.sh /entry_point.sh
RUN chmod +x /entry_point.sh

EXPOSE 80

ENTRYPOINT [ "/entry_point.sh" ]
