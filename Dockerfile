FROM php:7.1.2-apache 

# Load extra Apache modules
RUN a2enmod rewrite

# Installs sendmail
RUN apt-get update && apt-get install -q -y ssmtp mailutils && rm -rf /var/lib/apt/lists/*

#installs php modules
RUN docker-php-ext-install mysqli mbstring pdo pdo_mysql tokenizer pcntl

# set up sendmail config, see http://linux.die.net/man/5/ssmtp.conf for options
RUN echo "hostname=php.test" > /etc/ssmtp/ssmtp.conf
RUN echo "root=linda.mcgraw@me.com" >> /etc/ssmtp/ssmtp.conf
RUN echo "mailhub=maildev" >> /etc/ssmtp/ssmtp.conf

# Set up php sendmail config
RUN echo "sendmail_path=sendmail -i -t" >> /usr/local/etc/php/conf.d/php-sendmail.ini

# Fully qualified domain name configuration for sendmail on localhost.
# Without this sendmail will not work.
# This must match the value for 'hostname' field that you set in ssmtp.conf.
RUN echo "localhost php.test" >> /etc/hosts