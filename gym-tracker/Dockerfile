# ---- Stage 1: Build ----
FROM golang:1.26-alpine AS builder

WORKDIR /app

# Copy dependency files first (layer caching)
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Compile the binary
RUN go build -o app .

# ---- Stage 2: Production ----
FROM alpine:3.19

WORKDIR /app

# Copy only the binary from Stage 1
COPY --from=builder /app/app .

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 8080

CMD ["./app"]
