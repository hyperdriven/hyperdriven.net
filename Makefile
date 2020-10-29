include github.com/xentek/makefiles/assets
include .env
.PHONY := default init test build pkg validate deploy cb
.DEFAULT_GOAL = default

STORE = xentek-cloud
PROJECT ?= $(shell basename $$PWD)

define jpg
endef

default:
	@ mmake help

# init project
init: env install-sassc install-jpegtran install-optipng install-png2ico
	@ yarn

# run tests
test:
	@ echo "no tests to run"

# build project
build: jpg png favicon css

# build jpgs
jpg:
	jpegtran -copy none -optimize -progressive assets/img/retro-rocket.jpg > public/img/retro-rocket.jpg

# build pngs
png:
	optipng -clobber -strip all -o7 -dir public/img assets/img/retro-rocket.png
	optipng -clobber -strip all -o7 -dir public assets/img/tile.png
	optipng -clobber -strip all -o7 -dir public assets/img/tile-wide.png
	optipng -clobber -strip all -o7 -dir public assets/img/icon.png

# build icons
ico:
	@ png2ico assets/favicon.ico assets/img/favicon.png

# build styles
css:
	sassc -I assets/css -t compressed assets/styles.scss public/css/styles.css

# start server
start: build
	@  cd public && serve -p 8181

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
	@ scripts/deploy

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
