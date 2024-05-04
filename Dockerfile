# Use an official Python image as a base
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create and set the working directory
WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    git \
    gcc \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for MySQL compilation
# ENV MYSQLCLIENT_CFLAGS=$(pkg-config --cflags libmysqlclient)
# ENV MYSQLCLIENT_LDFLAGS=$(pkg-config --libs libmysqlclient)

# Install Python dependencies
RUN git clone https://github.com/ASKBOT/askbot-devel.git
RUN pip install --upgrade pip

COPY requirements.txt /app/
RUN pip install -r requirements.txt

RUN python -m pip install /app/askbot-devel

# Copy the project files to the container
COPY ./start.sh /app/

# RUN askbot-setup -e postgresql --proj-name qmzaskbot --root-directory /app/qmzaskbot --db-host db --db-port 5432 --db-name askbot_db --db-user askbot_user --db-password askbot_pass

# Run collectstatic
# RUN python manage.py collectstatic --noinput

# CMD ["bash", "-c", "askbot-setup", "-e", "mysql", "--proj-name", "qmzaskbot", "--root-directory", "/app/qmzaskbot", "--db-host", "db.localhost", "-d", "askbot_db", "&& python manage.py migrate && python manage.py runserver"]
# CMD ["bash", "-c", "./start.sh"]
CMD ["bash", "-c", "askbot-setup --root-directory /app/qmzaskbot/ --proj-name qmzaskbot -e mysql --db-host db.localhost --db-name askbot_db --db-password askbot_pass --db-user askbot_user --admin-email admin@qmz.ai --admin-name qmz_admin --noinput --force && python /app/qmzaskbot/manage.py makemigrations && python /app/qmzaskbot/manage.py migrate && echo yes | python /app/qmzaskbot/manage.py collectstatic && python /app/qmzaskbot/manage.py runserver 0.0.0.0:8000"]
# && sed -i \"s/INTERNAL_IPS = (\('127.0.0.1',\))/INTERNAL_IPS = ('127.0.0.1', '0.0.0.0')/\" /app/qmzaskbot/settings.py && 
#  --db-port=3306 -u askbot_user -p askbot_pass 
# RUN ls -lha
# && gunicorn --bind 0.0.0.0:8000 qmzaskbot.wsgi
# Start Gunicorn
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myaskbot.wsgi"]

# ENTRYPOINT ["bash"]
# CMD ["-c", "tail -f /dev/null"]
