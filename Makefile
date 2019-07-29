build:
	docker build -t gatling:3.0.3-sbt .

test: build
	docker run -it --rm \
		gatling:3.0.3-sbt gatling:test

# TODO ホントはパラメータ化したい
testOnly: build
	docker run -it --rm \
		gatling:3.0.3-sbt "gatling:testOnly computerdatabase.SampleSimulation"
