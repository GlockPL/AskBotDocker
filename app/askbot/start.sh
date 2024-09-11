ls -lha
askbot-setup --root-directory /app/askbot/ --proj-name askbot_t -e mysql --db-host db.localhost --db-name askbot_db --db-password askbot_pass --db-user askbot_user --admin-email admin@here.ai --admin-name q_admin --noinput --force
python /app/askbot/manage.py makemigrations
python /app/askbot/manage.py migrate && echo yes
python /app/askbot/manage.py migrate askbot && echo yes
python /app/askbot/manage.py migrate django_authopenid && echo yes
python /app/askbot/manage.py collectstatic