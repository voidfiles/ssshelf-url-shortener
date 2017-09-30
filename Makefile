CWD=$(shell pwd)

clean:
	rm -fR dist
	rm -fRr build

build_container:
	docker build . --tag=url_shortner_ms

test:
	docker run --rm -i \
		-v "$(CWD)/:/code/" \
		-e "AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)" \
		-e "AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)" \
		-e "AWS_BUCKET=$(AWS_BUCKET)" \
		-e "AWS_DEFAULT_REGION=us-west-2" \
		url_shortner_ms \
		/usr/local/bin/python -m pytest tests

shell:
	docker run --rm -it \
		-v "$(CWD)/:/code/" \
		-e "AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)" \
		-e "AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)" \
		-e "AWS_BUCKET=$(AWS_BUCKET)" \
		-e "AWS_DEFAULT_REGION=us-west-2" \
		url_shortner_ms \
		/bin/bash

run:
	docker run --rm -it \
		-v "$(CWD)/:/code/" \
		-e "AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)" \
		-e "AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)" \
		-e "AWS_BUCKET=$(AWS_BUCKET)" \
		-e "AWS_DEFAULT_REGION=us-west-2" \
		-p "8080:8080" \
		url_shortner_ms \
		apistar run --host=0.0.0.0 --no-debug

run_like_prod:
	docker run --rm -it \
		-v "$(CWD)/:/code/" \
		-e "AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)" \
		-e "AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)" \
		-e "AWS_BUCKET=$(AWS_BUCKET)" \
		-e "AWS_DEFAULT_REGION=us-west-2" \
		-p "8080:8080" \
		url_shortner_ms \
		uvicorn app:app --workers=1 --bind=0.0.0.0:8080

