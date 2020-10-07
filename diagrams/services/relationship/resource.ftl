[#ftl]

[#assign ONEWAY_DIAGRAMS_RELATIONSHIP = "one way" ]
[#assign TWOWAY_DIAGRAMS_RELATIONSHIP = "two way" ]

[#macro execDiagramRelationship startEntityId endIdentityId direction ]
    [@mergeWithJsonOutput
        name="relationships"
        content={
            formatId(startEntityId, endIdentityId) : {
                "startEntityId" : startEntityId,
                "endIdentityId" : endIdentityId,
                "direction" : direction
            }
        }
    /]
[/#macro]
