# Use an official Python image as a base
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create and set the working directory
WORKDIR /app

RUN ["bash", "-c", "echo \"bish!\""]

RUN mkdir -p /app/askbot

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    git \
    gcc \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for MySQL compilation
RUN pip install --upgrade pip
# Install Python dependencies
RUN git clone https://github.com/ASKBOT/askbot-devel.git

COPY requirements.txt /app/

RUN pip install -r requirements.txt

RUN python -m pip install /app/askbot-devel

COPY wsgi.py /app/askbot/
COPY start.sh /app/askbot/
RUN chmod +x /app/askbot/start.sh

# ENTRYPOINT /app/askbot/start.sh 

CMD ["bash", "-c", "cd /app/askbot && ls -lha && /app/askbot/start.sh && gunicorn wsgi:application --bind 0.0.0.0:8000"]

#python /app/askbot/manage.py collectstatic && echo "yes"
# RUN /app/askbot/start.sh


# CMD ["bash", "-c", "ls -lha && askbot-setup --root-directory /app/askbot/ --proj-name askbot_t -e mysql --db-host db.localhost --db-name askbot_db --db-password askbot_pass --db-user askbot_user --admin-email admin@here.ai --admin-name q_admin --noinput --force && python /app/askbot/manage.py makemigrations && python /app/askbot/manage.py migrate && echo yes | python /app/askbot/manage.py migrate askbot && echo yes | python /app/askbot/manage.py migrate django_authopenid && echo yes | python /app/askbot/manage.py collectstatic"]# &&python /app/askbot/manage.py runserver 0.0.0.0:8000"]
# RUN ["bash", "-c", "ls -lha && echo \"bich!\""]
# && sed -i \"s/INTERNAL_IPS = (\('127.0.0.1',\))/INTERNAL_IPS = ('127.0.0.1', '0.0.0.0')/\" /app/qmzaskbot/settings.py && 
#  --db-port=3306 -u askbot_user -p askbot_pass 
# RUN ls -lha
# && gunicorn --bind 0.0.0.0:8000 qmzaskbot.wsgi
# Start Gunicorn
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myaskbot.wsgi"]

# ENTRYPOINT ["bash"]
# CMD ["-c", "tail -f /dev/null"]
