FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Заглушки для сборки статики
ENV DJANGO_SETTINGS_MODULE=django_app.settings \
    DB_NAME=dummy DB_USER=dummy DB_PASSWORD=dummy DB_HOST=dummy \
    SECRET_KEY=build_secret_key

RUN python manage.py collectstatic --noinput

# Очистка
ENV DB_NAME= DB_USER= DB_PASSWORD= DB_HOST= SECRET_KEY=

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "django_app.wsgi:application"]
EXPOSE 8000
