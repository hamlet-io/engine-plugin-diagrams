# Hamlet Engine Plugin - Diagrams

This is a plugin for the Hamlet engine which can be used to generate diagram representations of your deployments

It provides two providers

- **diagrams** - which implements the actual processing to generate the diagram outputs
- **diagramstest** - which implmentes mock components and resources to support isolated development from other providers

## Implementation

The key functionality in this provider is a new deployment framework called the `exec` format. This framework generates a document conforment with the document specficiations for the [hamlet diagrams executor](https://github.com/hamlet-io/executor-diagrams/)

Using this framework combined with the shared provider components flow we can generate exec files based on the component configuration. The default diagram generates all components, subcomponents and then defines relationships between the entities based on their Links. No knowlege of particular components is requried, we are just relying on standard hamlet component design


## Installation

1. Clone this repository into your hamlet workspace
2. Add the pth to the cloned location to the `GENERATION_PLUGIN_DIR` env var

    ```bash
    export GENERATION_PLUGINS_DIR="$(pwd);${GENERATION_PLUGIN_DIR}
    ```

3. The plugin will now be avaialble as a provider to hamlet

## Local testing

A testing provider `diagramstest` is avaiable in this repository for isolated testing and for trying out the plugin. The testprovider adds a basic scenario to the the blueprint with a collection of components and their links. This is based on a standard serverless deployment with a database backend. Each component is also mocked with a state and basic resources

To generate a standard diagram of the components and their relationships

```bash
${GENERATION_DIR}/createTemplate.sh -e diagram -p diagramstest -p diagrams -o ./ -i mock
```

The output will be in the local directory.

Note: the diagramstest should be loaded as the first, primary provider to allow for the resource and component mocking to work
