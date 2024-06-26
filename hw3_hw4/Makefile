#SERVER=omega.swpelc.eu
SERVER=slon.felk.cvut.cz
USR=pelcjaku
DB=pelcjaku

PWD=$(shell cat .passwd)
export PGPASSWORD=$(PWD)

PYTHON=python3
EXEC=psql
FOLDER=sql

CREATE_SQL=$(FOLDER)/create.sql
DROP_SQL=$(FOLDER)/drop.sql

ZIP_FOLDERS=tests/ sql/ gen/
ZIP_FILES=cp03.pdf Makefile cp03.md
ZIP_NAME=$(USR)_cp03.zip

GEN_FOLDER=gen
GEN_FILES=$(GEN_FOLDER)/users.sql $(GEN_FOLDER)/groups.sql $(GEN_FOLDER)/vedouci.sql $(GEN_FOLDER)/ucastnici.sql $(GEN_FOLDER)/actions.sql $(GEN_FOLDER)/workshops.sql $(GEN_FOLDER)/lectures.sql $(GEN_FOLDER)/lecturers.sql $(GEN_FOLDER)/program_points.sql $(GEN_FOLDER)/tools.sql $(GEN_FOLDER)/tools_per_group.sql $(GEN_FOLDER)/users_tools.sql $(GEN_FOLDER)/workshops_participants.sql $(GEN_FOLDER)/workshops_organizers.sql $(GEN_FOLDER)/helper_organizers.sql $(GEN_FOLDER)/is_mandatory.sql $(GEN_FOLDER)/subordinates.sql $(GEN_FOLDER)/participants.sql

TEST_FOLDER=tests

generate:
	$(PYTHON) generate.py

gen/%.sql: generate
	$(EXEC) -h $(SERVER) -U $(USR) -d $(DB) -f $@

create:
	$(EXEC) -h $(SERVER) -U $(USR) -d $(DB) -f $(CREATE_SQL)

drop:
	$(EXEC) -h $(SERVER) -U $(USR) -d $(DB) -f $(DROP_SQL)

users:
	$(EXEC) -h $(SERVER) -U $(USR) -d $(DB) -f $(GEN_FOLDER)/users.sql

fill: $(GEN_FILES)

reset: drop create

list_tables:
	$(EXEC) -h $(SERVER) -U $(USR) -d $(DB) -c "\dt"

test_%:
	$(EXEC) -h $(SERVER) -U $(USR) -d $(DB) -f tests/$*.sql

hw4_%:
	$(EXEC) -h $(SERVER) -U $(USR) -d $(DB) -f hw4/$*.sql

bullshit: drop create fill hw4_fix hw4_view hw4_transaction hw4_trigger

clean:
	rm -f $(ZIP_NAME)

zip:
	zip -r $(ZIP_NAME) $(ZIP_FOLDERS) $(ZIP_FILES)