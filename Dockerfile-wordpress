FROM wordpress:5.7.0-php7.4
RUN sed -i "/\/\* That's all.*\*\//i \
  // CUSTOM CONFIG UPDATES \n\
  require_once ABSPATH . '\/wp-content\/themes\/digital-regulation-theme\/modules\/env-config.php'\; \n\
  " /usr/src/wordpress/wp-config-docker.php
