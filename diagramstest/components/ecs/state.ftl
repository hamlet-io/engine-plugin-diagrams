[#ftl]

[#macro diagramstest_ecs_default_state occurrence parent={} ]
    [#local core = occurrence.Core]

    [#assign componentState =
        {
            "Resources" : {
                "server" : {
                    "Id" : formatResourceId(DIAGRAMSTEST_SERVER_RESOURCE_TYPE, core.Id),
                    "Name" : core.FullName,
                    "Type" : DIAGRAMSTEST_SERVER_RESOURCE_TYPE
                }
            },
            "Attributes" : {
                "INSTANCEID" : core.FullName
            },
            "Roles" : {
            }
        }
    ]
[/#macro]


[#macro diagramstest_service_default_state occurrence parent={} ]
    [#local core = occurrence.Core]

    [#assign componentState =
        {
            "Resources" : {
                "container" : {
                    "Id" : formatResourceId(DIAGRAMSTEST_CONTAINER_RESOURCE_TYPE, core.Id),
                    "Name" : core.FullName,
                    "Type" : DIAGRAMSTEST_CONTAINER_RESOURCE_TYPE
                }
            },
            "Attributes" : {
                "NAME" : "happy_einstien"
            },
            "Roles" : {
            }
        }
    ]
[/#macro]
