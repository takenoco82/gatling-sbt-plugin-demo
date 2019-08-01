GATLING_SBT_IMAGE := gatling:3.0.3-sbt


build:
	docker build -t ${GATLING_SBT_IMAGE} .

build_dev:
	docker build --target development -t ${GATLING_SBT_IMAGE}-dev .

test: build
	docker run -it --rm \
		${GATLING_SBT_IMAGE} gatling:test

# TODO ホントはパラメータ化したい
testOnly: build
	docker run -it --rm \
		${GATLING_SBT_IMAGE} "gatling:testOnly computerdatabase.SampleSimulation"
