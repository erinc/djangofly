ARG PYTHON_VERSION=3.12.2-alpine


FROM python:${PYTHON_VERSION}

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

ENV DJANGO_SETTINGS_MODULE "{{ project_name }}.settings"  
ENV DATABASE_URL "sqlite:///db.sqlite3"
ENV DJANGO_SECRET_KEY "secret key for building the dockerfile"


RUN mkdir -p /code

WORKDIR /code

COPY requirements.txt /tmp/requirements.txt

RUN set -ex && \
    pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt && \
    rm -rf /root/.cache/

COPY . /code/

RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD ["gunicorn", "--bind", ":8000", "--workers", "2", "{{ project_name }}.wsgi"]
