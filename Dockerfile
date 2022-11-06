FROM golang:1.19

WORKDIR /usr/src/app

COPY ./app/go.mod ./

RUN go mod download && go mod verify

COPY ./app/. .

RUN go build -v -o /usr/local/bin/app ./...

CMD [ "app" ]