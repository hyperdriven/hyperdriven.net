include .env
.PHONY := default init test build pkg validate deploy cb
.DEFAULT_GOAL = default

STORE = hostedbyxentek-cloud
PROJECT ?= $(shell basename $$PWD)

default:
	@ mmake help

# init project
init: env

# run tests
test:
	@ echo "no tests to run"

# build project
build:
	@ echo "nothing to build"

# package stack
pkg: build
	@ aws cloudformation package \
		--template-file src.yml \
		--output-template-file dist.yml \
		--s3-bucket ${STORE}

# validate cloudformation templates
validate: pkg
	@ aws cloudformation validate-template --template-body file://src.yml
	@ aws cloudformation validate-template --template-body file://dist.yml

# deploy stack
deploy: | test validate
	@ aws cloudformation deploy \
		--template-file dist.yml \
		--s3-bucket ${STORE} \
		--stack-name ${STACK}

# pull latest .env file
env:
	@ aws s3 cp s3://${STORE}/${PROJECT}/.env .env

# push latest .env file
env-push:
	@ aws s3 cp .env s3://${STORE}/${PROJECT}/.env --sse

# run codebuild locally
cb:
	@ xn codebuild -i hyperdriven/ci:latest -a ./artifacts -s ${PWD} -b buildspec.yml -e ./.env -c

%:
	@ true
