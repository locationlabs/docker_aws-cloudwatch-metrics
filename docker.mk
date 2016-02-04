# Shared Makefile for docker images.
#
# For building, use these targets:
#
#  build: runs docker build to create an image
#         - Images are always tagged as "latest"
#         - Images are conditionally tagged with TAG if it is defined
#         - Images are conditionally pushed to our registry (with both tags) if TAG is defined
#
# For testing images (created via `make build`), use:
#
#  run:   runs a container from an image; image Makefiles may define flags that control this run
#  shell: runs a shell from an image
#  rm:    delete a running container
#  logs:  show standard out for a running container
#
all: build

IMAGE_NAME = locationlabs/$(CONTAINER_NAME)
TAG ?= 
BUILD_FLAGS ?=

.PHONY: build logs prebuild push rm run shell tag

prebuild:

build: prebuild
	docker build --rm -t $(IMAGE_NAME):latest $(BUILD_FLAGS) .
	docker tag -f $(IMAGE_NAME):latest $(IMAGE_NAME):latest
	if [ -n "$(TAG)" ]; then docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):$(TAG); fi
	if [ -n "$(TAG)" ]; then docker push $(IMAGE_NAME):$(TAG); else docker push $(IMAGE_NAME):latest; fi

run:
	docker run -d $(docker_run_flags) --name $(CONTAINER_NAME) $(IMAGE_NAME):$(VERSION)

shell:
	docker run -t -i --rm $(docker_run_flags) $(IMAGE_NAME):$(VERSION) /bin/bash

exec:
	docker exec -t -i $(CONTAINER_NAME) /bin/bash

rm:
	docker rm -f $(CONTAINER_NAME)

logs:
	docker logs $(CONTAINER_NAME)
