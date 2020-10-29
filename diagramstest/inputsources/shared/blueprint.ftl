[#ftl]

[#-- Intial seeding of settings data based on input data --]
[#macro awstest_input_shared_blueprint_seed ]
    [@addBlueprint
        blueprint={
            "ScenarioProfiles" : {
                "diagrams-provider-testing" : {
                    "Scenarios" : {
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
            },
            "Solution" : {
                "Profiles" : {
                    "Scenarios" : [ "diagrams-provider-testing" ]
                }
            }
        }
    /]
[/#macro]
