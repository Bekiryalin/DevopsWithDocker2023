FROM node:16-alpine

WORKDIR /usr/src/app

#EXPOSE 5000

COPY . .

#ENV REACT_APP_BACKEND_URL=http://localhost:8080
RUN node -v && npm -v \
    npm install \
    npm run build \
    npm install -g serve \
    useradd -m appuser \
    chown appuser .

USER appuser

CMD ["serve", "-s", "-l", "5000", "build"]
