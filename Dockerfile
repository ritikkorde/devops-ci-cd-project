# Build frontend
FROM node:18-alpine AS frontend
WORKDIR /app
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install
COPY frontend/ .
RUN npm run build

# Build backend
FROM node:18-alpine AS backend
WORKDIR /app
COPY backend/package.json backend/package-lock.json ./
RUN npm install
COPY backend/ .
RUN npm run build

# Final stage - Serving the app
FROM node:18-alpine
WORKDIR /app

# Copy compiled frontend & backend from previous stages
COPY --from=backend /app /backend
COPY --from=frontend /app /frontend

CMD ["node", "/backend/server.js"]
