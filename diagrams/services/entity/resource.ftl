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

[#macro addDiagramEntitiesFromResources resources groupId provider ]
    [#local resourceTypes = getResourceTypes(resources)]

    [#list resourceTypes as id, type ]
        [@execDiagramEntity
            id=formatId(groupId, type)
            name=type
            groupId=groupId
            resourceProvider=provider
            resourceType=type
        /]
    [/#list ]
[/#macro]


[#macro addDiagramEntityForOccurrence occurrence groupId ]
    [#local resourceTypes = getResourceTypes(occurrence.State.Resources)]

    [#local placement = (occurrence.State.ResourceGroups["default"].Placement)!{} ]
    [#local provider = placement.Provider ]

    [@execDiagramEntity
        id=occurrence.Core.TypedId
        name=occurrence.Core.Component.RawName
        groupId=groupId
        resourceProvider=provider
        resourceType=(resourceTypes?values[0])!occurrence.Core.Component.Type
    /]
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
