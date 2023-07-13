FROM python:3.10-buster

WORKDIR /workspace

RUN apt-get update && apt-get install -y jq

ENV PYTHONPATH=${PYTHONPATH}:${PWD} 
RUN pip install poetry
RUN poetry config virtualenvs.create false

COPY \
    pyproject.toml \
    poetry.lock* \
    ./

RUN poetry add fastapi
RUN poetry add uvicorn
RUN poetry install --no-root

COPY app/ app/

RUN poetry install

EXPOSE 80
