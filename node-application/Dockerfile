FROM node:current-alpine3.23
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /app
USER appuser
EXPOSE 3000
CMD ["node", "server.js"]
