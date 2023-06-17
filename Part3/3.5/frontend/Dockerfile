FROM node:16

WORKDIR /usr/src/app

EXPOSE 5000

COPY . .

ENV REACT_APP_BACKEND_URL=http://localhost:8080
RUN node -v && npm -v
RUN npm install
RUN npm run build
RUN npm install -g serve
RUN adduser  appuser
RUN chown appuser .

USER appuser

CMD ["serve", "-s", "-l", "5000", "build"]
