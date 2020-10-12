[#ftl]

[#-- Intial seeding of settings data based on input data --]
[#macro diagramstest_input_mock_blueprint_seed ]
    [@addBlueprint
        blueprint={
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
