FROM grafana/grafana
ARG MY_GROUP
ARG MY_USER
ENV MY_GROUP=${MY_GROUP}
ENV MY_USER=${MY_USER}
RUN groupmod -g $MY_GROUP grafana \
    && usermod -u $MY_USER grafana \
    && usermod -g grafana grafana

