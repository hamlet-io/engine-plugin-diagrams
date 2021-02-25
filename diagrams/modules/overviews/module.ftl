[#ftl]

[@addModule
    name="overviews"
    description="A set of diagrams which provide details on all components"
    provider=DIAGRAMS_PROVIDER
    properties=[]
/]

[#macro diagrams_module_overviews ]
    [@loadModule
        blueprint={
            "Diagrams" : {
                "overview" : {
                    "Type" : "solution",
                    "Title" : "All Components",
                    "Description" : "A solution level diagram of all components in the solution",
                    "Rules" : {
                        "allComponents" : {
                            "Action" : "Include",
                            "Policy" : "ComponentType",
                            "policy:ComponentType" : {
                                "Types" : [ "*" ]
                            }
                        }
                    }
                },
                "resources_used" : {
                    "Type" : "resources",
                    "Title" : "Solution Resources",
                    "Description" : "Provides a diagram of all unique resources used in the solution",
                    "Rules" : {
                        "allComponents" : {
                            "Action" : "Include",
                            "Policy" : "ResourceType",
                            "policy:ResourceType" : {
                                "Types" : [ "*" ]
                            }
                        }
                    }
                }
            }
        }
    /]
[/#macro]
