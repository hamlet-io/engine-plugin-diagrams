[#ftl]

[#assign ONEWAY_DIAGRAMS_RELATIONSHIP = "one way" ]
[#assign TWOWAY_DIAGRAMS_RELATIONSHIP = "two way" ]

[#macro addDiagramRelationshipsFromLinks occurrence links="" ]
    [#list getLinkTargets(occurrence, links) as id, link ]
        [#if link?is_hash]

            [#if (link.Direction)?lower_case == "inbound" ]
                [#local startEntityId = link.Core.TypedId]
                [#local endEntityId = occurrence.Core.TypedId ]
            [#else]
                [#local startEntityId = occurrence.Core.TypedId]
                [#local endEntityId = link.Core.TypedId ]
            [/#if]

            [@execDiagramRelationship
                startEntityId=startEntityId
                endEntityId=endEntityId
                direction=ONEWAY_DIAGRAMS_RELATIONSHIP
            /]
        [/#if]
    [/#list]
[/#macro]

[#macro execDiagramRelationship startEntityId endEntityId direction ]
    [@mergeWithJsonOutput
        name="relationships"
        content={
            formatId(startEntityId, endEntityId) : {
                "startEntityID" : startEntityId,
                "endEntityID" : endEntityId,
                "direction" : direction
            }
        }
    /]
[/#macro]
