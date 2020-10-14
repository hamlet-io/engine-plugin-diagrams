[#ftl]

[#macro addDiagramEntitiesFromResources resources groupId provider ]
    [#list resources as id, resource]
        [#if resource?is_hash && (resource.Type)?? ]
            [@execDiagramEntity
                id=formatId(groupId, resource.Type)
                name=resource.Type
                groupId=groupId
                resourceProvider=provider
                resourceType=resource.Type
            /]
            [#continue]
        [/#if]

        [#if resource?is_hash ]
            [@addDiagramEntitiesFromResources
                resources=resource
                groupId=groupId
                provider=provider
            /]
        [/#if]

        [#if resource?is_sequence ]
            [#list resource as groupResource ]
                [@addDiagramEntitiesFromResources
                    resources=groupResource
                    groupId=groupId
                    provider=provider
                /]
            [/#list]
        [/#if]
    [/#list]
[/#macro]

[#macro execDiagramEntity id name groupId resourceProvider resourceProvider resourceType ]
    [@mergeWithJsonOutput
        name="entities"
        content={
            id : {
                "entityID" : id,
                "groupID" : groupId,
                "type" : getDiagramClass(resourceProvider, "*", resourceType),
                "entityName" : name
            }
        }
    /]
[/#macro]
