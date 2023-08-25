FROM node:18-alpine AS BUILDER

WORKDIR /app

COPY package.json /app/package.json

COPY package-lock.json /app/package-lock.json

RUN npm install

COPY . .

RUN npm run build -w frontend


FROM nginx:alpine

COPY --from=BUILDER /app/frontend/dist/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]