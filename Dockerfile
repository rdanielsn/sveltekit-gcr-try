FROM oven/bun:latest AS builder
WORKDIR /app
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile
COPY . .
RUN bun run build

FROM oven/bun:slim
WORKDIR /app
ENV PORT=8080 
EXPOSE 8080
COPY --from=builder /app/build ./build
COPY --from=builder /app/package.json ./package.json
CMD ["bun", "run", "start"]
