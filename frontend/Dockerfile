# FROM python:3 as builder

# COPY . .


# RUN apt update
# # RUN apt install python3-pip -y
# RUN pip install --no-cache-dir -r requirements.txt
# ENV BACKEND_HOST=backend-service

FROM nginx:latest

# COPY --from=builder . .
COPY . /usr/share/nginx/html
RUN rm -rf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d

# ENV BACKEND_HOST=backend-service
EXPOSE 80
# CMD ["python3", "fake.py", ";", "python3", "app.py"]
# CMD ["/bin/bash", "temp.sh"]



