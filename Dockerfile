# Multi-stage build
FROM node:20-alpine AS deps
WORKDIR /app
COPY api/package*.json ./api/
COPY web/package*.json ./web/
RUN cd api && npm ci && cd ../web && npm ci

FROM node:20-alpine AS builder
WORKDIR /app
COPY . .
COPY --from=deps /app/api/node_modules ./api/node_modules
COPY --from=deps /app/web/node_modules ./web/node_modules
RUN cd api && npm run build && cd ../web && npm run build

FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/api/dist ./api/dist
COPY --from=builder /app/api/package*.json ./api/
RUN cd api && npm ci --only=production
EXPOSE 3000
CMD ["node", "api/dist/main.js"]
