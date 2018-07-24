default: docker_build

# Get the version number from the code
CODE_VERSION = $(strip $(shell cat VERSION))

docker_build:
	@docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VERSION=`cat VERSION` \
			-t glacialmagma/powerdns:$(CODE_VERSION) .
