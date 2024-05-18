FROM mysql:latest as db

ENV MYSQL_ROOT_PASSWORD=1

# Sao chép các tệp SQL khởi tạo vào container (nếu có)
COPY ./init-db/init.sql /docker-entrypoint-initdb.d/


FROM golang:1.21.4-alpine as program

WORKDIR /app
COPY ./app ./

ENV DB_Host=database-service
ENV DB_User=root
ENV DB_Password=1
ENV APP_Host=0.0.0.0
# RUN go mod download


RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build main.go

CMD ["./main"]