FROM rocker/tidyverse:3.5.0
MAINTAINER yuchi

# Change environment to Japanese(Character and DateTime)
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
RUN sed -i '$d' /etc/locale.gen \
    && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
        && locale-gen ja_JP.UTF-8 \
        && /usr/sbin/update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
RUN /bin/bash -c "source /etc/default/locale"
RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Install packages
RUN install2.r -e rstan
RUN install2.r -e forecast
RUN install2.r -e urca
RUN install2.r -e ggfortify
RUN install2.r -e tseries
RUN install2.r -e lmtest
RUN install2.r -e prais
RUN install2.r -e fpp
RUN install2.r -e vars
RUN install2.r -e dlm
RUN install2.r -e KFAS
RUN install2.r -e rugarch
RUN install2.r -e prophet
#RUN install2.r --error --deps TRUE fGarch
RUN Rscript -e "devtools::install_github('cran/fGarch')"
CMD ["/init"]
WORKDIR /root/workspace
