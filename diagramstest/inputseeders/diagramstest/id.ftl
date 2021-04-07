[#ftl]
[@registerInputSeeder
    id=DIAGRAMSTEST_INPUT_SEEDER
    description="Diagrams test provider inputs"
/]

[@addSeederToConfigPipeline
    stage=FIXTURE_SHARED_INPUT_STAGE
    seeder=DIAGRAMSTEST_INPUT_SEEDER
/]

[#function diagramstest_configseeder_fixture filter state]
    [#return
        addToConfigPipelineClass(
            state,
            BLUEPRINT_CONFIG_INPUT_CLASS,
            {
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
            },
            FIXTURE_SHARED_INPUT_STAGE
        )
    ]
[/#function]

[#function diagramstest_configseeder_fixture_mock filter state]

    [#return
        addToConfigPipelineClass(
            diagramstest_configseeder_fixture(filter, state),
            BLUEPRINT_CONFIG_INPUT_CLASS,
            {
                "PlacementProfiles": {
                    "default": {
                        "default": {
                            "Provider": "diagramstest",
                            "Region": "mock-region-1",
                            "DeploymentFramework": "default"
                        }
                    }
                }
            },
            FIXTURE_SHARED_INPUT_STAGE
        )
    ]

[/#function]
