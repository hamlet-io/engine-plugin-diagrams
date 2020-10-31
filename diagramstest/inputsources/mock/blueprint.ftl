[#ftl]

[#-- Intial seeding of settings data based on input data --]
[#macro diagramstest_input_mock_blueprint_seed ]
    [@addBlueprint
        blueprint={
            "Solution" : {
                "Modules" : {
                    "apiservice" : {
                        "Provider" : "diagramstest",
                        "Name" : "apiservice"
                    },
                    "webapp" : {
                        "Provider" : "diagramstest",
                        "Name" : "webapp"
                    }
                }
            }
            "PlacementProfiles": {
                "default": {
                    "default": {
                        "Provider": "diagramstest",
                        "Region": "mock-region-1",
                        "DeploymentFramework": "default"
                    }
                }
            }
        }
    /]
[/#macro]
