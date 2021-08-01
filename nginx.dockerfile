FROM nginx:stable-alpine

# Add Configuration file for nginx
ADD ./nginx/nginx.conf /etc/nginx/

# Create directory
RUN mkdir -p /var/www/html

# Add user/usergroup
RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

# Apply Permissions
RUN chown -R laravel:laravel /var/www/html
