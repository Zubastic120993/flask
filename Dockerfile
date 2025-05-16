# Stage 1 - Builder
FROM python:3.12-alpine as builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

# Stage 2 - Final image
FROM python:3.12-alpine

WORKDIR /app

COPY web_app.py .
COPY templates/ templates/
COPY static/ static/

COPY --from=builder /install /app

ENV PYTHONPATH=/app/lib/python3.12/site-packages

CMD ["python", "web_app.py"]



