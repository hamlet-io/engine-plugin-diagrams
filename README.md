# Hamlet Deploy Engine Plugin - Diagrams

This is a plugin for Hamlet Deploy which enables the generation of diagrams of your deployments

- **diagrams** - which implements the actual processing to generate the diagram outputs
- **diagramstest** - which implmentes mock components and resources to support isolated development from other providers

## Description

The key functionality in this provider is a new deployment framework called the `exec` format. This framework generates a document conformant with the document specifications for the [Hamlet Deploy diagrams executor](https://github.com/hamlet-io/executor-diagrams/).

Using this framework combined with the shared provider components flow we can generate exec files based on the component configuration. The default diagram generates all components, subcomponents and then defines relationships between the entities based on their Links. No knowledge of particular components is required, we are just relying on standard hamlet component design.


## Installation

This plugin is installed by default into the official Hamlet docker container. Type `hamlet visual --help` inside the container to get started.

If you are installing Hamlet yourself, simply clone this directory into the *hamlet/engine/plugins/* directory.

```bash
cd path/to/hamlet/engine/plugins
git clone https://github.com/hamlet-io/engine-plugin-diagrams.git
```

## Configuration

To configure Hamlet Deploy for use with this Plugin, update the `GENERATION_PLUGIN_DIRS` environment variable with the fully qualified filepath to the plugin.

```bash
cd ./<repository-root>
export GENERATION_PLUGINS_DIRS="${GENERATION_PLUGIN_DIRS};$(pwd)"
```

Make sure to do this for each Plugin (`diagrams` and `diagramstest`).

## Local testing

The Plugin `diagramstest` is available in this repository for isolated testing of the `diagrams` Plugin.

The testprovider adds a basic module to the the blueprint with a collection of components and their links. This is based on a standard serverless deployment with a database backend. Each component is also mocked with a state and basic resources

To generate a standard diagram of the components and their relationships

```bash
hamlet visual -p diagramstest -p diagrams -i mock draw-diagrams -o ./
```

The output will be in the local directory.

**Note:** the `diagramstest` Plugin should be loaded as the first, primary provider to allow for the resource and component mocking to work.