OBJDIR := db_data
OBJDIR_APP := ./app/static

app-run:
	mkdir -p $(OBJDIR)
	mkdir -p $(OBJDIR_APP)
	docker-compose up --build -d 
	#  -d

app-down:
	docker-compose down

app-recreate:
	mkdir -p $(OBJDIR)
	mkdir -p $(OBJDIR_APP)
	docker-compose up --build --force-recreate --no-deps -d 