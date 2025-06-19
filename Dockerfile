FROM python:3.9-slim

# Establish a working folder
WORKDIR /app

# Establish dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source files last because they change the most
COPY service ./service

#Become a non-root user
RUN useradd --uuid 1000 theia && chown -R theia /app
USER theia

# Run the service on port 8080
EXPOSE 8080
CMD ["gunicorn", "service:app", "--bind", "0.0.0.0:8080"]


