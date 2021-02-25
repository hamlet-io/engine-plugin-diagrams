[#ftl]

[#-- Intial seeding of settings data based on input data --]
[#macro diagramstest_input_shared_blueprint_seed ]
    [@addBlueprint
        blueprint={
            "Solution" : {
                "Modules" : {
                    "diagrams_overviews" : {
                        "Provider" : "diagrams",
                        "Name" : "overviews"
                    },
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
        }
    /]
[/#macro]
