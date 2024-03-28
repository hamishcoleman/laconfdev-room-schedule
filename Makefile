#
#
#

all: lint test

.PHONY: next
next:
	wget https://2024.everythingopen.au/schedule/conference.json
	./schedule_templator \
	    --json file:conference.json \
	    tpl_rooms template-next.html.j2 next .html


.PHONY: lint
lint: lint.python

.PHONY: test
test: test.python

BUILD_DEP+=flake8
.PHONY: lint.python
lint.python:
	flake8 schedule_templator

BUILD_DEP+=python3-pytest
.PHONY: test.python
test.python:
	cp schedule_templator schedule_templator.py
	pytest-3 schedule_templator.py
	rm schedule_templator.py

.PHONY: cover
cover:
	cp schedule_templator schedule_templator.py
	pytest-3 \
	    -vv \
	    --cov=. \
	    --cov-report=html \
	    --cov-report=term \
	    schedule_templator.py
	rm schedule_templator.py

build_dep:
	sudo apt-get -y install $(BUILD_DEP)
