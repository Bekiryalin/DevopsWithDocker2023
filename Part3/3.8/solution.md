➜  ~ docker images
REPOSITORY       TAG       IMAGE ID       CREATED         SIZE
multifrontend    latest    fa7b5be2191b   6 minutes ago   129MB
alpinefrontend   latest    5482ac938fef   9 hours ago     118MB
alpinebackend    latest    8da616b7463a   9 hours ago     447MB
editedfrontend   latest    155618d45cf9   9 hours ago     1.23GB
frontend         latest    ddf2fa95b9d3   9 hours ago     1.23GB
backend          latest    6f8504bb6586   9 hours ago     1.08GB
editedbackend    latest    f42efcc8053c   9 hours ago     1.07GB


---SOLUTION---
We define a build stage using the AS keyword and name it builder.
We set the working directory to /usr/src/app in both stages.
In the build stage, we copy the package.json and package-lock.json (or yarn.lock) files to the working directory and run npm ci to install dependencies based on the lockfile. This ensures reproducibility and faster installation.
We copy the entire project directory to the build stage.
We run npm run build to build your React application.
Now, we start the runtime stage using the same node:16-alpine base image.
We expose port 5000 to allow external access to your application.
We copy the build directory from the build stage to the working directory in the runtime stage. This contains the compiled static files from the React build.
We install the serve package globally to serve the static files.
We create an appgroup group and an appuser user within that group.
We switch the user to appuser for improved security.
Finally, we set the command to start the serve package, serving the static files in the build directory on port 5000.


Dockerfile


# Build stage
FROM node:16-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# Runtime stage
FROM node:16-alpine

WORKDIR /usr/src/app

EXPOSE 5000

COPY --from=builder /usr/src/app/build ./build

RUN npm install -g serve

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

CMD ["serve", "-s", "-l", "5000", "build"]
