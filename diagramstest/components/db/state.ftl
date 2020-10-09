[#ftl]

[#macro diagramstest_db_default_state occurrence parent={} ]
    [#local core = occurrence.Core]

    [#assign componentState =
        {
            "Resources" : {
                "db" : {
                    "Id" : formatResourceId(DIAGRAMSTEST_DB_RESOURCE_TYPE, core.Id),
                    "Name" : core.FullName,
                    "Type" : DIAGRAMSTEST_DB_RESOURCE_TYPE
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
