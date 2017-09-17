FROM python:3.6

WORKDIR /code

ADD ./requirements.txt /code

RUN pip install -r requirements.txt

COPY . /code
