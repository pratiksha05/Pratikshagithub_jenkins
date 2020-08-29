FROM python:3.7

ADD src /src
ADD tests /tests

RUN pip install flask/
    pip install pytest


CMD [ "python", "src/run.py" ]