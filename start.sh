askbot-setup -e mysql --proj-name qmzaskbot --root-directory /app/qmzaskbot --db-host db.localhost -d askbot_db
cd qmzaskbot
python manage.py migrate
python manage.py runserver