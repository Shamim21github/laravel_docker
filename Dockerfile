# Use PHP 8.1.2 as the base image
FROM php:8.1.2


# Install dependencies and required packages
RUN apt-get update && apt-get install -y \
    curl \
    git

# Create a non-root user to run Composer
RUN useradd -m -d /home/dockeruser dockeruser

# Switch to the dockeruser
USER dockeruser

# Install Composer 
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer -- --install-dir=/home/dockeruser


USER dockeruser

# Switch back to the root user
USER root

# Set the working directory
WORKDIR /var/www/html

# Copy your application code
COPY . /var/www/html

# Install dependencies
RUN /home/dockeruser/composer install

# Expose the container port
EXPOSE 80

# Start the application
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html/public"]



