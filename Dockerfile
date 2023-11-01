# Stage 1: Build the application
FROM python:3.9 as builder

# Set the working directory
WORKDIR /app

# Copy only the requirements file to work directory
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application code to work directory
COPY . .

# Stage 2: Create the final image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app /app

# Specify the command to run your application
CMD ["python", "app.py"]