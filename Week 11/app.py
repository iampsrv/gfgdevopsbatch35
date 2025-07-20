from flask import Flask, request
from prometheus_client import start_http_server, Counter, Summary, Gauge, Histogram
import time
import random
import threading
import psutil

app = Flask(__name__)

# Basic metrics
REQUEST_COUNT = Counter('http_requests_total', 'Total number of HTTP requests')
REQUEST_LATENCY = Summary('http_request_latency_seconds', 'Request latency in seconds')
REQUEST_LATENCY_HIST = Histogram('http_request_latency_histogram_seconds', 'Histogram of request latency')
IN_PROGRESS = Gauge('in_progress_requests', 'Number of in-progress requests')
ERROR_COUNT = Counter('app_errors_total', 'Total number of application errors')
LOGIN_COUNT = Counter('user_login_total', 'Number of user logins')
REQUEST_BY_STATUS = Counter('http_requests_by_status', 'Requests by HTTP status', ['status_code'])
ROUTE_LATENCY = Summary('request_latency_seconds_by_route', 'Request latency by route', ['route'])

# System metrics
CPU_USAGE = Gauge('cpu_usage_percent', 'CPU usage percentage')
MEMORY_USAGE = Gauge('memory_usage_percent', 'Memory usage percentage')

def collect_system_metrics():
    while True:
        CPU_USAGE.set(psutil.cpu_percent())
        MEMORY_USAGE.set(psutil.virtual_memory().percent)
        time.sleep(5)

@app.route("/")
@IN_PROGRESS.track_inprogress()
@REQUEST_LATENCY.time()
@REQUEST_LATENCY_HIST.time()
def hello():
    try:
        REQUEST_COUNT.inc()
        REQUEST_BY_STATUS.labels(status_code=200).inc()
        ROUTE_LATENCY.labels(route="/").observe(random.uniform(0.1, 0.5))
        time.sleep(random.uniform(0.1, 0.5))
        return "Hello from Flask with Prometheus metrics!"
    except Exception:
        ERROR_COUNT.inc()
        REQUEST_BY_STATUS.labels(status_code=500).inc()
        return "Internal error", 500

@app.route("/login")
@ROUTE_LATENCY.labels(route="/login").time()
def login():
    LOGIN_COUNT.inc()
    return "Login successful"

if __name__ == "__main__":
    # Start Prometheus metrics server
    start_http_server(8000)

    # Start system metrics collector in background
    threading.Thread(target=collect_system_metrics, daemon=True).start()

    # Start Flask app
    app.run(host="0.0.0.0", port=5000)