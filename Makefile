CWD=$(shell pwd)

clean:
	rm -fR dist
	rm -fRr build

build_container:
	docker build . --tag=url_shortner_ms

test:
	docker run --rm -i \
		-v "$(CWD)/:/code/" \
		-e "AWS_ACCESS_KEY_ID=test" \
		-e "AWS_SECRET_ACCESS_KEY=test" \
		-e "AWS_DEFAULT_REGION=us-east-1" \
		url_shortner_ms \
		/usr/local/bin/python -m pytest tests

shell:
	docker run --rm -it \
		-v "$(CWD)/:/code/" \
		-e "AWS_ACCESS_KEY_ID=test" \
		-e "AWS_SECRET_ACCESS_KEY=test" \
		-e "AWS_DEFAULT_REGION=us-east-1" \
		ssshelf \
		/bin/bash
