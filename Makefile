BUILDDIR ?= build/libs
CLASSDIR ?= build/classes
SOURCEDIR ?= src/main/java
LIBRARYDIR ?= libs

JAVAC := javac
JAVACFLAGS := -g
# Auto-import files in the same package
JAVACFLAGS += -sourcepath $(SOURCEDIR)
# Add .jar libraries
JAVACFLAGS += -classpath "$(LIBRARYDIR)/*"
JARFLAGS := -C $(CLASSDIR)/main .
JARFLAGS += -C src/main/resources .

# Output jar and class containing main function.
JAR := ExamplePlugin.jar
MAINCLASS := null

SOURCES := $(shell find $(SOURCEDIR) -type f -name "*.java")
CLASSES := $(patsubst $(SOURCEDIR)/%.java, $(CLASSDIR)/main/%.class, $(SOURCES))

all: build

build: $(BUILDDIR)/$(JAR)

$(CLASSDIR)/main/%.class: $(SOURCEDIR)/%.java
	@printf "\033[32m> JAVAC\033[0m\t%s\n" $@
	@mkdir -p `dirname $@`
	$(JAVAC) $(JAVACFLAGS) $^ -d $(CLASSDIR)/main

$(BUILDDIR)/$(JAR): $(CLASSES)
	@printf "\033[33m> JAR\033[0m\t$@\n"
	@mkdir -p $(BUILDDIR)
	jar -cfe $@ $(MAINCLASS) $(JARFLAGS) || rm $@

clean:
	rm -rf $(CLASSDIR)

help:
	@printf "\033[97;1mAvailable tasks:\033[0m\n"
	@printf "\t\033[32mbuild \033[90m(default)\033[0m\n"
	@printf "\t  Compile all classes into \033[97;1m%s\033[0m\n" $(BUILDDIR)/$(JAR)
