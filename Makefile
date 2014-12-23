build:
	docker build -t='pingles/riak-coreos' .

clean:
	docker rm -f consul
	
run:
	docker run -p 8500:8500 pingles/riak-coreos

.PHONY: build run