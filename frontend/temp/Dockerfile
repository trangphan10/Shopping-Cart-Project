FROM nginx:alpine

COPY index.html /usr/share/nginx/html
RUN rm -rf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d
COPY a.js /usr/share/nginx/html

EXPOSE 80