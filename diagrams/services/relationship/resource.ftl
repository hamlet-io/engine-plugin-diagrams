[#ftl]

[#assign ONEWAY_DIAGRAMS_RELATIONSHIP = "one way" ]
[#assign TWOWAY_DIAGRAMS_RELATIONSHIP = "two way" ]

[#macro addDiagramRelationshipsFromLinks occurrence links ]
    [#list links as id, link ]
        [#if (link.Direction)?lower_case == "inbound" ]
            [#local direction = TWOWAY_DIAGRAMS_RELATIONSHIP ]
        [#else]
            [#local direction = ONEWAY_DIAGRAMS_RELATIONSHIP ]
        [/#if]

        [@execDiagramRelationship
            startEntityId=occurrence.Core.Id
            endIdentityId=link.Core.Id
            direction=direction
        /]
    [/#list]
[/#macro]

[#macro execDiagramRelationship startEntityId endIdentityId direction ]
    [@mergeWithJsonOutput
        name="relationships"
        content={
            formatId(startEntityId, endIdentityId) : {
                "startEntityID" : startEntityId,
                "endEntityID" : endIdentityId,
                "direction" : direction
            }
        }
    /]
[/#macro]
