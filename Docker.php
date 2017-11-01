From osminogin/php-fpm

# Required extensions for this project
# 

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

RUN apt-get update && apt-get install -y \
    locales \
    netcat 

RUN echo "locales locales/default_environment_locale select fr_FR.UTF-8" | debconf-set-selections \
    && echo "locales locales/locales_to_be_generated multiselect 'fr_FR.UTF-8 UTF-8'" | debconf-set-selections \
    && echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata && locale-gen --purge en_US.UTF-8  \
    && rm -rf /var/lib/apt/lists/*

COPY ./01proxy  /etc/apt/apt.conf.d/01proxy
COPY ./detect_proxy.sh /etc/apt-get   
                                            
RUN apt-get update  \
    && apt-get upgrade -y \
    && apt-get --no-install-recommends --no-install-suggests -y  install \
    imagemagick \
    vim


