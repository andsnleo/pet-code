init:
	bundle install
	$(MAKE) build-database

build-database:
	rails db:create
	rails db:schema:load
	rails db:seed

rebuild-database:
	rails db:drop
	$(MAKE)	build-database
