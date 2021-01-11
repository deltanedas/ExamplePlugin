JAVAC := javac
JAVACFLAGS := -g
# Auto-import files in the same package
override JAVACFLAGS += -sourcepath src
# Add .jar libraries
override JAVACFLAGS += -classpath "libs/*"
# Compile against java 8 abi
override JAVACFLAGS += --release 8

JARFLAGS := -C build/classes .
override JARFLAGS += -C assets .

sources := $(shell find src -type f -name "*.java")
assets := $(shell find assets -type f)
classes := $(patsubst src/%.java, build/classes/%.class, $(sources))

# Mindustry + arc version to link against
version := v122.1

all: build

libs := libs/core-release.jar libs/arc-core.jar

libs/core-release.jar:
	@printf "\033[33m> LIB\033[0m\t%s\n" $@
	@mkdir -p libs
	curl 'https://jitpack.io/com/github/Anuken/Mindustry/core/$(version)/core-$(version).jar.sha1' -o $@.sha1 2>/dev/null
	curl 'https://jitpack.io/com/github/Anuken/Mindustry/core/$(version)/core-$(version).jar' -o $@
	@printf "\t%s" "$@" >> $@.sha1
	sha1sum -c $@.sha1
	@rm $@.sha1

libs/arc-core.jar:
	@printf "\033[33m> LIB\033[0m\t%s\n" $@
	curl 'https://jitpack.io/com/github/Anuken/Arc/arc-core/$(version)/arc-core-$(version).jar.sha1' -o $@.sha1 2>/dev/null
	curl 'https://jitpack.io/com/github/Anuken/Arc/arc-core/$(version)/arc-core-$(version).jar' -o $@
	@printf "\t%s" "$@" >> $@.sha1
	sha1sum -c $@.sha1
	@rm $@.sha1

build: ExamplePlugin.jar

build/classes/%.class: src/%.java $(libs)
	@printf "\033[32m> JAVAC\033[0m\t%s\n" $@
	@mkdir -p `dirname $@`
	$(JAVAC) $(JAVACFLAGS) $< -d build/classes

ExamplePlugin.jar: $(classes) $(assets)
	@printf "\033[33m> JAR\033[0m\t%s\n" $@
	jar -cf $@ $(JARFLAGS) || rm $@

clean:
	rm -rf build/classes

reset:
	rm -rf libs build *.jar

help:
	@printf "\033[97;1mAvailable tasks:\033[0m\n"
	@printf "\t\033[32mbuild \033[90m(default)\033[0m\n"
	@printf "\t  Compile the plugin into \033[91;1m%s\033[0m\n" ExamplePlugin.jar
	@printf "\t\033[32mclean\033[0m\n"
	@printf "\t  Remove compiled classes.\n"
	@printf "\t\033[31mreset\033[0m\n"
	@printf "\t  Remove compiled classes and downloaded libraries.\n"

.PHONY: all libs build clean reset help