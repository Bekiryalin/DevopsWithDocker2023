FROM golang:1.16

WORKDIR /usr/src/app		

EXPOSE 8080	


COPY . .

#ENV REQUEST_ORIGIN=http://localhost
#RUN apt-get update
#RUN apt-get install -y
RUN go build &&\
    adduser --system appuser &&\
    chown appuser .

USER appuser

CMD ./server