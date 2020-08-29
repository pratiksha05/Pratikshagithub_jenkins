FROM python:3.7

ADD src /src
ADD tests /tests

RUN pip install flask
RUN pip install pytest


CMD [ "python", "src/run.py" ]