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

profile_dev:
	docker run --rm -it \
		-v "$(CWD)/:/code/" \
		-e "AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)" \
		-e "AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)" \
		-e "AWS_BUCKET=$(AWS_BUCKET)" \
		-e "AWS_DEFAULT_REGION=us-west-2" \
		-p "8080:8080" \
		-p "8912:8912" \
		url_shortner_ms \
		profiling remote-profile /usr/local/bin/apistar --bind 0.0.0.0:8912 -- run --host=0.0.0.0 --no-debug


profile_prod:
	docker run --rm -it \
		-v "$(CWD)/:/code/" \
		-e "AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID)" \
		-e "AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)" \
		-e "AWS_BUCKET=$(AWS_BUCKET)" \
		-e "AWS_DEFAULT_REGION=us-west-2" \
		-p "8080:8080" \
		-p "8912:8912" \
		url_shortner_ms \
		profiling remote-profile /usr/local/bin/uvicorn app:app --bind 0.0.0.0:8912 -- --bind=0.0.0.0:8080 --pid=pid


view_profile:
	docker exec -it \
		$(CONTAINER_ID) \
		profiling view 127.0.0.1:8912
