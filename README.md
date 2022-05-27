![Github Workflows](https://github.com/deltanedas/ExamplePlugin/workflows/Java%20CI/badge.svg)

### Setup

Clone this repository first.

To edit the plugin display name and other data, take a look at `plugin.json`.

### Basic Usage

See `src/example/ExamplePlugin.java` for some basic commands and event handlers.

Every main plugin class must extend `Plugin`. Make sure that `plugin.json` points to the correct main plugin class.

Please note that the plugin system is in beta, and as such is subject to changes.

### Building a Jar

`$ make -j$(nproc)`

Output jar will be in `ExamplePlugin.jar`.

### Installing

Simply place the output jar from the step above in your server's `config/mods` directory and restart the server.

List your currently installed plugins/mods by running the `mods` command.
