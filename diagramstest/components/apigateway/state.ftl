[#ftl]

[#macro diagramstest_apigateway_default_state occurrence parent={} ]
    [#local core = occurrence.Core]

    [#assign componentState =
        {
            "Resources" : {
                "apigateway" : {
                    "Id" : formatResourceId(DIAGRAMSTEST_APIGATEWAY_RESOURCE_TYPE, core.Id),
                    "Name" : core.Name,
                    "Type" : DIAGRAMSTEST_APIGATEWAY_RESOURCE_TYPE
                }
            },
            "Attributes" : {
                "SCHEME" : "https"
            },
            "Roles" : {
            }
        }
    ]
[/#macro]
