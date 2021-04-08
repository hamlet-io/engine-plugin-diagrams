[#ftl]

[#assign ONEWAY_DIAGRAMS_RELATIONSHIP = "one way" ]
[#assign TWOWAY_DIAGRAMS_RELATIONSHIP = "two way" ]

[#macro addDiagramRelationshipsFromLinks occurrence links={} ]
    [#if isOccurrenceInDiagram(occurrence) ]
        [#list links?values as link ]
            [#local linkTarget = getLinkTarget(occurrence,link )]
            [#if linkTarget?has_content]
                [#if isOccurrenceInDiagram(linkTarget) ]
                    [#-- TODO(roleyfoley) workaround for https://github.com/hamlet-io/engine/issues/1624 --]
                    [#if (link.Tier?lower_case == "external") &&
                        (link.Type?? || (!getTier(link.Tier)?has_content))]

                        [#local idAttrs = [ linkTarget.Core.Tier.Id, linkTarget.Core.Component.Id ]
                                            + valueIfContent(
                                                [ linkTarget.Core.Instance.Id ],
                                                linkTarget.Core.Instance.Id,
                                                []
                                            ) +
                                            valueIfContent(
                                                [ linkTarget.Core.Version.Id],
                                                linkTarget.Core.Version.Id,
                                                []
                                            ) +
                                            [ linkTarget.Core.Type ]

                        ]

                        [#local linkId = formatId(idAttrs) ]
                    [#else]
                        [#local linkId = linkTarget.Core.TypedId ]
                    [/#if]

                    [#if (linkTarget.Direction)?lower_case == "inbound" ]
                        [#local startEntityId = linkId]
                        [#local endEntityId = occurrence.Core.TypedId ]
                    [#else]
                        [#local startEntityId = occurrence.Core.TypedId]
                        [#local endEntityId = linkId ]
                    [/#if]

                    [@execDiagramRelationship
                        startEntityId=startEntityId
                        endEntityId=endEntityId
                        direction=ONEWAY_DIAGRAMS_RELATIONSHIP
                    /]
                [/#if]
            [/#if]
        [/#list]
    [/#if]
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
