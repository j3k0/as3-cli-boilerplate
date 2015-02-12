help:
	@echo make run ..... Runs the app
	@echo make build ... Compiles the app
	@echo make clean ... Cleanup binaries

build: bin/Main.swf

run: build
	adl src/Main-app.xml bin

bin/Main.swf: src/Main.as src/Main-app.xml
	@mkdir -p bin
	amxmlc -output bin/Main.swf src/Main.as -compiler.source-path src/

clean:
	rm -fr bin
