build:
	docker build -t gatling:3.0.3-sbt

run: build
	docker run -it --rm \
		gatling:3.0.3-sbt

run: sbt
	docker run -it --rm \
		-v ${PWD}/conf:/opt/gatling/conf \
		gatling:3.0.3-sbt
