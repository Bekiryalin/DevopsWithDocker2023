
# 
We start with a build stage using the golang:1.16-alpine base image.
We set the working directory to /usr/src/app in both stages.
In the build stage, we copy the go.mod and go.sum files to enable dependency caching using Go modules.
We download the Go module dependencies using go mod download.
We copy the entire project directory to the build stage.
We build the Go binary using CGO_ENABLED=0 to create a statically linked binary and -installsuffix cgo to exclude any C libraries.
In the final stage, we use the scratch base image, which is an empty image.
We copy the built server binary from the build stage to the final stage.
We expose port 8080 to allow external access to the server.
We set the user to 1001, which is a non-root user.
Finally, we set the command to start the server binary.



# ---Dockerfile---

#Build stage

FROM golang:1.16-alpine AS builder

WORKDIR /usr/src/app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .

#Final stage

FROM scratch

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/server .

EXPOSE 8080

USER 1001

CMD ["./server"]
