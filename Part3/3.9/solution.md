➜  ~ docker images
REPOSITORY       TAG       IMAGE ID       CREATED          SIZE
multibackend     latest    b0e560dec1dc   35 seconds ago   18MB
multifrontend    latest    fa7b5be2191b   4 hours ago      129MB
alpinefrontend   latest    5482ac938fef   13 hours ago     118MB
alpinebackend    latest    8da616b7463a   13 hours ago     447MB
editedfrontend   latest    155618d45cf9   13 hours ago     1.23GB
frontend         latest    ddf2fa95b9d3   13 hours ago     1.23GB
backend          latest    6f8504bb6586   14 hours ago     1.08GB
editedbackend    latest    f42efcc8053c   14 hours ago     1.07GB


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



---Dockerfile---
# Build stage
FROM golang:1.16-alpine AS builder

WORKDIR /usr/src/app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o server .

# Final stage
FROM scratch

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/server .

EXPOSE 8080

USER 1001

CMD ["./server"]
