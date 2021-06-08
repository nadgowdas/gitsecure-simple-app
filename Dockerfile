FROM us.icr.io/gitsecure/golang:1.15-buster
WORKDIR /go/src/github.com/gitsecure-simple-app
COPY app.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app app.go


FROM us.icr.io/gitsecure/alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/gitsecure-simple-app/app .
CMD ["/root/app"]  
