FROM grafana/grafana
ARG MY_GROUP
ARG MY_USER
USER root
RUN groupmod -g $MY_GROUP grafana --\
    &&usermod -u $MY_USER grafana --\
    && usermod -g grafana grafana

