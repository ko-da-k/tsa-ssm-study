.PHONY: build run docker/*

WORK_DIR := $(CURDIR)
LOG_DIR := $(CURDIR)

BUILDER_IMAGE := python:tsa-ssm
BUILDER_WORK_DIR := /root/workspace
BUILDER_CMD := docker run --rm -it -v $(WORK_DIR):$(BUILDER_WORK_DIR) -w $(BUILDER_WORK_DIR) -p 6006:6006 -p 8888:8888 $(BUILDER_IMAGE)

setup:
	docker build -t $(BUILDER_IMAGE) .

rebuild-image:
	docker rmi $(BUILDER_IMAGE)
	docker build -t $(BUILDER_IMAGE) .

attach:
	$(BUILDER_CMD) bash

jupyter:
	$(BUILDER_CMD) jupyter notebook --ip 0.0.0.0 --no-browser --port 8888 --allow-root

tensorboard:
	$(BUILDER_CMD) tensorboard --logdir=$(LOGDIR)
