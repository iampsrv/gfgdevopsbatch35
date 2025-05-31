# Stage 1: Build stage
FROM alpine:latest AS builder

RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    pip install --upgrade pip

WORKDIR /app
COPY requirements.txt .
RUN python3 -m venv /path/to/venv
RUN . /path/to/venv/bin/activate
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Production stage
FROM alpine:latest

# Copy Python runtime from the builder stage
COPY --from=builder /usr /usr

WORKDIR /app
COPY . .

EXPOSE 8080
CMD ["python3", "app.py"]
