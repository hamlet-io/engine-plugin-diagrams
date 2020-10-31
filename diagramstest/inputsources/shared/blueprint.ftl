[#ftl]

[#-- Intial seeding of settings data based on input data --]
[#macro awstest_input_shared_blueprint_seed ]
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
        }
    /]
[/#macro]
