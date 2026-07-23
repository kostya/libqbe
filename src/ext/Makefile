REV := 03848f76a41c3f971f1709159d969bd88a937c09

.PHONY: package
package: ./qbe-c/libqbe.a

./qbe-c:
	git clone https://github.com/kostya/qbe.git ./qbe-c
	cd qbe-c && git reset --hard $(REV)

./qbe-c/libqbe.a: ./qbe-c
	cd ./qbe-c && make -j 4

.PHONY: clean
clean:
	rm -rf ./qbe-c
