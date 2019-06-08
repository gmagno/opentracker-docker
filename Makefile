
.PHONY: build
build:
	docker build -t gmagno/opentracker .

.PHONY: run
run:
	docker run \
		--rm \
		--name opentracker \
		-p 6969:6969/udp \
		-p 6969:6969 \
		-v ${PWD}/opentracker.conf:/opentracker.conf \
		gmagno/opentracker -f /opentracker.conf
