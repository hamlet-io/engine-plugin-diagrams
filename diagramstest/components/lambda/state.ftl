[#ftl]

[#macro diagramstest_lambda_default_state occurrence parent={} ]
    [#local core = occurrence.Core]

    [#assign componentState =
        {
            "Resources" : {
                "lambda" : {
                    "Id" : formatResourceId(DIAGRAMSTEST_LAMBDA_RESOURCE_TYPE, core.Id),
                    "Name" : core.FullName,
                    "Type" : DIAGRAMSTEST_LAMBDA_RESOURCE_TYPE
                }
            },
            "Attributes" : {},
            "Roles" : {
                "Inbound" : {},
                "Outbound" : {}
            }
        }
    ]
[/#macro]

[#macro diagramstest_function_default_state occurrence parent={} ]
    [#local core = occurrence.Core]

    [#assign componentState =
        {
            "Resources" : {
                "function" : {
                    "Id" : formatResourceId(DIAGRAMSTEST_LAMBDA_FUNCTION_RESOURCE_TYPE, core.Id),
                    "Name" : core.FullName,
                    "Type" : DIAGRAMSTEST_LAMBDA_FUNCTION_RESOURCE_TYPE
                }
            },
            "Attributes" : {
                "NAME" : core.FullName
            },
            "Roles" : {
            }
        }
    ]
[/#macro]
