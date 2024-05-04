askbot-setup --root-directory /app/qmzaskbot/ --proj-name qmzaskbot -e mysql --db-host db.localhost --db-name askbot_db --db-password askbot_pass --db-user askbot_user --admin-email admin@qmz.ai --admin-name qmz_admin --noinput --force
ls -lha .
ls -lha /app/qmzaskbot
python /app/qmzaskbot/manage.py migrate
python /app/qmzaskbot/manage.py runserver