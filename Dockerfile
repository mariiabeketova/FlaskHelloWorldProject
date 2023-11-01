# Stage 1: Build stage
FROM python:3.9 as builder

WORKDIR /app

COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY . .
RUN rm requirements.txt

# Stage 2: Production stage
FROM builder

WORKDIR /app

# Copy the installed dependencies from the previous stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages

# Copy the application source code from the previous stage
COPY --from=builder /app/* .

EXPOSE 5555

CMD ["python","app.py"]