from flask import Flask
from prometheus_client import start_http_server, Counter, Summary
import time
import random

app = Flask(__name__)

REQUEST_COUNT = Counter('http_requests_total', 'Total HTTP Requests')
REQUEST_LATENCY = Summary('request_latency_seconds', 'Request latency in seconds')

@app.route("/")
@REQUEST_LATENCY.time()
def hello():
    REQUEST_COUNT.inc()
    time.sleep(random.uniform(0.1, 0.5))
    return "Hello from Flask with Prometheus metrics!"

if __name__ == "__main__":
    start_http_server(8000)
    app.run(host="0.0.0.0", port=5000)