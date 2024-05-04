# Use an official Python image as a base
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create and set the working directory
WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    gcc \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for MySQL compilation
# ENV MYSQLCLIENT_CFLAGS=$(pkg-config --cflags libmysqlclient)
# ENV MYSQLCLIENT_LDFLAGS=$(pkg-config --libs libmysqlclient)

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy the project files to the container
COPY ./start.sh /app/

# RUN askbot-setup -e postgresql --proj-name qmzaskbot --root-directory /app/qmzaskbot --db-host db --db-port 5432 --db-name askbot_db --db-user askbot_user --db-password askbot_pass

# Run collectstatic
# RUN python manage.py collectstatic --noinput

# CMD ["bash", "-c", "askbot-setup", "-e", "mysql", "--proj-name", "qmzaskbot", "--root-directory", "/app/qmzaskbot", "--db-host", "db.localhost", "-d", "askbot_db", "&& python manage.py migrate && python manage.py runserver"]
CMD ["bash", "-c", "./start.sh"]
#  --db-port=3306 -u askbot_user -p askbot_pass 
# RUN ls -lha
# && gunicorn --bind 0.0.0.0:8000 qmzaskbot.wsgi
# Start Gunicorn
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myaskbot.wsgi"]

# ENTRYPOINT ["bash"]
# CMD ["-c", "tail -f /dev/null"]
