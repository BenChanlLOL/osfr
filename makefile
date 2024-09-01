all:
	nasm -f bin src/boot.asm -o build/boot.bin

clean:
	rm -f build/boot.bin