WORK_DIR := $(CURDIR)
LOG_DIR := $(CURDIR)

BUILDER_IMAGE := r:tsa-ssm
BUILDER_WORK_DIR := /root/workspace
BUILDER_CMD := docker run -v $(WORK_DIR):$(BUILDER_WORK_DIR) -p 8787:8787 $(BUILDER_IMAGE)

setup:
		docker build -m 4G -t $(BUILDER_IMAGE) .

rebuild-image:
		docker rmi $(BUILDER_IMAGE)
		docker build -m 4G -t $(BUILDER_IMAGE) .

rstudio:
		$(BUILDER_CMD)
