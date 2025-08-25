designs = $(shell cd projects && find * -maxdepth 0 -type d)

$(designs): % :
	cd projects/$* && $(MAKE)

FORCE:

user_project_wrapper: FORCE
	cd user_project_wrapper && $(MAKE)

chip: FORCE
	cd chip && $(MAKE)

all: $(designs) user_project_wrapper chip

.PHONY: all
