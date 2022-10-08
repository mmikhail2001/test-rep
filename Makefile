check:
	echo "Implement check"
build:
	mkdir build && cd build && cmake .. && make
test:
	mkdir build && cd build && cmake .. && make
	./fib

