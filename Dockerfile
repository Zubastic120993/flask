# Stage 1 - Builder
FROM python:3.12-alpine as builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Stage 2 - Final image
FROM python:3.12-alpine

WORKDIR /app

# Copy application files
COPY web_app.py .
COPY templates/ templates/
COPY static/ static/

# Copy installed packages from builder
COPY --from=builder /install /app

# Set Python path for installed packages
ENV PYTHONPATH=/app/lib/python3.12/site-packages

# Add non-root user for security
RUN adduser -D appuser
USER appuser

# Expose port if your web app needs it
EXPOSE 5000

# Start the application
CMD ["python", "web_app.py"]