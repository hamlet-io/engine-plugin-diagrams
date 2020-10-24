[#ftl]

[#macro diagramstest_lb_default_state occurrence parent={} ]
    [#local core = occurrence.Core]

    [#assign componentState =
        {
            "Resources" : {
                "loadbalancer" : {
                    "Id" : formatResourceId(DIAGRAMSTEST_LB_RESOURCE_TYPE, core.Id),
                    "Name" : core.FullName,
                    "Type" : DIAGRAMSTEST_LB_RESOURCE_TYPE
                }
            },
            "Attributes" : {
                "URL" : "https://" + core.FullName + ".local/"
            },
            "Roles" : {
            }
        }
    ]
[/#macro]

[#macro diagramstest_lbport_default_state occurrence parent={} ]
    [#local core = occurrence.Core]

    [#assign componentState =
        {
            "Resources" : {
                "lbrule" : {
                    "Id" : formatResourceId(DIAGRAMSTEST_LBRULE_RESOURCE_TYPE, core.Id),
                    "Name" : core.FullName,
                    "Type" : DIAGRAMSTEST_LBRULE_RESOURCE_TYPE
                }
            },
            "Attributes" : {
                "URL" : "https://" + core.FullName + ".local/" + core.Name
            },
            "Roles" : {
            }
        }
    ]
[/#macro]
