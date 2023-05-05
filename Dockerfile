# FROM python:3.9-slim
FROM ubuntu:20.04
# FROM nvcr.io/nvidia/pytorch:22.12-py3

ARG NAME
ARG NLP_CONF_FILE=conf/default.yaml
ENV PIPENV_VENV_IN_PROJECT=1
ENV PIP_NO_CACHE_DIR=1
WORKDIR /usr/bin/${NAME}

RUN set -xe \
    && apt-get update \
    && apt-get install -y python3-pip
RUN pip install --upgrade pip

COPY ./Pipfile* /usr/bin/${NAME}/
RUN pip install pipenv \
  && pipenv sync
# install nlp models specified in conf/default.yaml
COPY ./install_nlp_models.py /usr/bin/${NAME}/
COPY ${NLP_CONF_FILE} /usr/bin/${NAME}/${NLP_CONF_FILE}
RUN pipenv run python install_nlp_models.py --conf_file ${NLP_CONF_FILE}
RUN pip install -U spacy
RUN pip install PyYAML

COPY . /usr/bin/${NAME}/
# EXPOSE ${PORT}
# CMD pipenv run python app.py --host 0.0.0.0