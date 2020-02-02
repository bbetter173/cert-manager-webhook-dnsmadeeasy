IMAGE_NAME := "angelnu/cert-manager-webhook-dnsmadeeasy"
IMAGE_TAG := "latest"

OUT := $(shell pwd)/_out

$(shell mkdir -p "$(OUT)")

_out/kubebuilder/bin/kube-apiserver:
	./scripts/fetch-test-binaries.sh

.PHONY: fetch-test-binaries
fetch-test-binaries: _out/kubebuilder/bin/kube-apiserver

verify: _out/kubebuilder/bin/kube-apiserver
	CGO_ENABLED=0 TEST_ZONE_NAME=angelnu.com. go test -v .

build:
	docker build -t "$(IMAGE_NAME):$(IMAGE_TAG)" .

test:
	docker build --build-arg SKIP_VERIFY=false -t "$(IMAGE_NAME):$(IMAGE_TAG)" .

.PHONY: rendered-manifest.yaml
rendered-manifest.yaml:
	helm template \
	    --name-template=cert-manager-dnsmadeeasy \
      --set image.repository=$(IMAGE_NAME) \
      --set image.tag=$(IMAGE_TAG) \
      deploy/helm > "deploy/rendered-manifest.yaml"
