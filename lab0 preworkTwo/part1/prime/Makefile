.PHONY:test,clean
test:
	arm-linux-gnueabihf-gcc prime.s -o prime.out -static
	./prime.out
clean:
	rm -fr prime.out