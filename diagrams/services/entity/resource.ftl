[#ftl]

[#function getResourceTypes resources ]
    [#local resourceTypes = {} ]
    [#list resources?values as resource ]
        [#if resource?is_hash && (resource.Type)?? ]
            [#local resourceTypes += { resource.Id, resource.Type }]
            [#continue]
        [/#if]

        [#if resource?is_hash ]
            [#local resourceTypes += getResourceTypes(resource)]
        [/#if]

        [#if resource?is_sequence ]
            [#list resource as groupResource]
                [#local resourceTypes += getResourceTypes(groupResource)]
            [/#list]
        [/#if]
    [/#list]
    [#return resourceTypes ]
[/#function]

[#macro addDiagramEntitiesFromResources occurrence resources groupId provider ]
    [#if isOccurrenceInDiagram(occurrence)]
        [#local resourceTypes = getResourceTypes(resources)]

        [#list resourceTypes as id, type ]
            [@execDiagramEntity
                id=formatId(groupId, type)
                name=type
                groupId=groupId
                resourceProvider=provider
                resourceType=type
            /]
        [/#list]
    [/#if]
[/#macro]

[#macro addDiagramEntityForOccurrence occurrence groupId ]
    [#if isOccurrenceInDiagram(occurrence) ]
        [#local resourceTypes = getResourceTypes(occurrence.State.Resources)]

        [#local placement = (occurrence.State.ResourceGroups["default"].Placement)!{} ]
        [#local provider = placement.Provider ]

        [@execDiagramEntity
            id=occurrence.Core.TypedId
            name=(occurrence.Core.SubComponent.RawName)!occurrence.Core.Component.RawName
            groupId=groupId
            resourceProvider=provider
            resourceType=(resourceTypes?values[0])!occurrence.Core.Component.Type
        /]
    [/#if]
[/#macro]

[#macro execDiagramEntity id name groupId resourceProvider service="" resourceType="" ]
    [#local diagramClass = getDiagramClass(resourceProvider, service, resourceType) ]
    [@debug message="DiagramClass" context={ "id" : id, "Class" : diagramClass }  enabled=true /]
    [@mergeWithJsonOutput
        name="entities"
        content={
            id : {
                "entityID" : id,
                "groupID" : groupId,
                "type" : diagramClass,
                "entityName" : name
            }
        }
    /]
[/#macro]


[#function isOccurrenceInDiagram occurrence ]
    [#local diagram = getActiveDiagram()]

    [#local match = false]
    [#if ((diagram.Rules)!{})?has_content ]
        [#list diagram.Rules?values?sort_by("Priority") as rule ]
            [#switch rule.Policy ]
                [#case "Links" ]
                    [#list getLinkTargets(occurrence, rule["policy:Links"]["Links"], false)?values as linkTarget ]
                        [#if linkTarget.Core.TypedFullName == occurrence.Core.TypedFullName ]
                            [#local match = true && rule.Action == "Include" ]
                        [/#if]
                    [/#list]
                    [#break]

                [#case "ComponentType"]
                    [#list rule["policy:ComponentType"]["Types"] as type ]
                        [#if occurrence.Core.Type == type || type == "*" ]
                            [#local match = true && rule.Action == "Include" ]
                        [/#if]
                    [/#list]
                    [#break]

                [#case "ResourceType"]
                    [#list rule["policy:ResourceType"]["Types"] as type ]
                        [#if (getResourceTypes(occurrence.State.Resources)?values)?seq_contains(type) || type == "*" ]
                            [#local match = true && rule.Action == "Include" ]
                        [/#if]
                    [/#list]
                    [#break]

            [/#switch]
        [/#list]
    [/#if]

    [#return match ]
[/#function]
