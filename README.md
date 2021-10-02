# Hamlet Deploy Plugin - diagrams

This is a Hamlet Deploy plugin repository. It extends the Hamlet Deploy to generate diagrams from your solution using the [mingrammer diagrams tool](https://diagrams.mingrammer.com/)

This repository includes a collection of hamlet plugins specific to Diagrams

| Name         | Directory     | Description                        |
|--------------|---------------|------------------------------------|
| diagrams     | diagrams/     | Core diagrams functionality        |
| diagramstest | diagramstest/ | Testing for diagrams functionality |

See https://docs.hamlet.io for more info on Hamlet Deploy

## Installation

The cmdb install method is our recommended approach however you can also install the plugin through some additional methods

### CMDB plugin

If you would like to include it we recommended adding it as a plugin in your CMDB. In your solution.json file add the following to install the latest release of the plugin

```json
{
    "Segment" : {
        "Plugins" : {
            "diagrams" : {
                "Enabled" : true,
                "Name" : "diagrams",
                "Priority" : 10,
                "Required" : true,
                "Source" : "git",
                "Source:git" : {
                    "Url" : "https://github.com/hamlet-io/engine-plugin-diagrams",
                    "Ref" : "main",
                    "Path" : "diagrams/"
                }
            }
        }
    }
}
```

Then run the setup command to install the plugin from the segment you have the plugin installed under

```bash
hamlet setup
```

To update re-rerun the hamlet setup command to get the latest changes

### Local clone

Run the following commands in your hamlet workspace to install a local copy

```bash
diagrams_clone_dir=< a path where you want to clone the plugin>
git clone "https://github.com/hamlet-io/engine-plugin-diagrams"
export GENERATION_PLUGIN_DIRS="${GENERATION_PLUGIN_DIRS};${diagrams_clone_dir}"
```

Then to include the plugin as part of your hamlet commands

```bash
hamlet -p <your cloud provider plugin>  -p diagrams < your command>
```

Or if you want to use it for all hamlet commands

```bash
export GENERATION_PROVIDERS="<your cloud provider plugin>,diagrams"
```

To update cd into the repo where you cloned the plugin and run `git pull` ( hamlet plugins don't need to be compiled)

### Usage

This is a plugin for the hamlet engine and won't work by itself. Usage of this provider requires the other parts of hamlet deploy

See https://docs.hamlet.io for more information

### Contributing

When contributing to hamlet we recommend installing this plugin using the **Local Clone** method above using a fork of the repository

#### Testing

The plugin includes a test suite which generates a collection of deployments and checks that their content aligns with what is expected

To run the test suite locally install the hamlet cli and use the provider testing included

```bash

# install cli
pip install hamlet

# run the tests
hamlet -p diagramstest -p diagrams -f exec visual  draw diagrams
```

This will generate the diagrams that are provided through the diagramstest provider which mocks a cloud provider and allows you to focus on the diagrams plugin without needed to include a cloud provider

##### Submitting Changes

Changes to the plugin are made through pull requests to this repo and all commits should use the [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/) format
This allows us to generate changelogs automatically and to understand what changes have been made
