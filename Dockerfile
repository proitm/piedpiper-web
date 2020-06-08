FROM python:3.8
ENV PYTHONUNBUFFERED 1

# RUN apk add --no-cache --virtual .build-deps \
#     ca-certificates gcc postgresql-dev linux-headers musl-dev \
#     libffi-dev jpeg-dev zlib-dev

# Allows docker to cache installed dependencies between builds
COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Adds our application code to the image
COPY . code
WORKDIR code

EXPOSE 8000

# Run the production server
CMD gunicorn --bind 0.0.0.0:$PORT --access-logfile - piedpiper.wsgi:application
