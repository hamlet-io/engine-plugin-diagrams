[#ftl]

[#macro shared_diagram_generationcontract occurrence ]
    [@addDefaultGenerationContract subsets=[ "config" ] /]
[/#macro]


[#macro setupIPAddressGroupsRelationhsips entityId IPAddressGroups inbound=true includeLocal=false]
    [#local diagramGroups = [] ]

    [#local networkGroupId = "External-Networks"]
    [@execDiagramGroup
        id=networkGroupId
    /]

    [#list asArray(IPAddressGroups) as ipAddressGroup ]
        [#local group = getIPAddressGroup( ipAddressGroup )]

        [#if group.IsOpen!false ]
            [#local diagramGroups += [ {
                "Id" : formatId(DIAGRAMS_GENERIC_SERVICE, DIAGRAMS_INTERNET_RESOURCE_TYPE),
                "Name" : "internet",
                "ResourceType" : DIAGRAMS_INTERNET_RESOURCE_TYPE
            }]]
            [#-- Don't worry about the other IP address groups if one group is open --]
            [#break]
        [/#if]

        [#if includeLocal && group.IsLocal ]

            [#local diagramGroups += [ {
                "Id" : formatId(DIAGRAMS_GENERIC_SERVICE, DIAGRAMS_INTRANET_RESOURCE_TYPE, group.Id),
                "Name" : group.Name!group.Id,
                "ResourceType" : DIAGRAMS_INTRANET_RESOURCE_TYPE
            } ]]
        [/#if]

        [#if ! group.IsLocal ]

            [#local diagramGroups += [ {
                "Id" : formatId(DIAGRAMS_GENERIC_SERVICE, DIAGRAMS_EXTRANET_RESOURCE_TYPE, group.Id ),
                "Name" : group.Name!group.Id,
                "ResourceType" : DIAGRAMS_EXTRANET_RESOURCE_TYPE
            }]]
        [/#if]
    [/#list]

    [#list diagramGroups as diagramGroup ]
        [@execDiagramEntity
            id=diagramGroup.Id
            name=diagramGroup.Name
            groupId=networkGroupId
            resourceProvider=DIAGRAMS_PROVIDER
            service=DIAGRAMS_GENERIC_SERVICE
            resourceType=diagramGroup.ResourceType
        /]

        [#if inbound ]
            [#local startEntityId = diagramGroup.Id]
            [#local endEntityId = entityId]
        [#else]
            [#local startEntityId = entityId ]
            [#local endEntityId = diagramGroup.Id ]
        [/#if]

        [@execDiagramRelationship
            startEntityId=startEntityId
            endEntityId=endEntityId
            direction=ONEWAY_DIAGRAMS_RELATIONSHIP
        /]
    [/#list]
[/#macro]

[#macro addComponentToSolutionDiagram occurrence ]
    [#if isOccurrenceInDiagram(occurrence)]
        [#local core = occurrence.Core]
        [#local solution = occurrence.Configuration.Solution ]

        [#local privateNetworkGroupName = "" ]
        [#if (solution.Profiles.Network!"")?has_content ]
            [#local occurrenceNetwork = getOccurrenceNetwork(occurrence) ]
            [#local networkLink = occurrenceNetwork.Link!{} ]
            [#local networkLinkTarget = getLinkTarget(occurrence, networkLink ) ]

            [#local privateNetworkGroupName = networkLinkTarget.Core.Name ]
            [@execDiagramGroup
                id=privateNetworkGroupName
            /]
        [/#if]

        [@execDiagramGroup
            id=core.TypedName
            parentId=privateNetworkGroupName
        /]

        [#local allOccurrences = asFlattenedArray( [ occurrence, occurrence.Occurrences![] ], true )]
        [#list allOccurrences as occurrence ]
            [#local solution = occurrence.Configuration.Solution ]

            [@addDiagramRelationshipsFromLinks
                occurrence=occurrence
            /]

            [@addDiagramEntityForOccurrence
                occurrence=occurrence
                groupId=core.TypedName
            /]
        [/#list]
    [/#if]
[/#macro]

[#macro shared_diagram_config_solution occurrence ]
    [@addComponentToSolutionDiagram occurrence /]
[/#macro]

[#macro shared_diagram_config_resources occurrence ]

    [#local solution = occurrence.Configuration.Solution ]
    [#local defaultDeploymentGroup = solution["deployment:Group"]!""]

    [#local allOccurrences = asFlattenedArray( [ occurrence, occurrence.Occurrences![] ], true )]
    [#list allOccurrences as occurrence ]
        [#local resources = occurrence.State.Resources ]
        [#local solution = occurrence.Configuration.Solution]

        [#local placement = (occurrence.State.ResourceGroups["default"].Placement)!{} ]
        [#local provider = placement.Provider!commandLineOptions.Deployment.Provider.Names[0] ]

        [#local deploymentGroup = solution["deployment:Group"]!defaultDeploymentGroup ]

        [#if isOccurrenceInDiagram(occurrence) && deploymentGroup?has_content && resources?has_content ]
            [@execDiagramGroup
                id=deploymentGroup
                parentId=""
            /]

            [@addDiagramEntitiesFromResources
                occurrence=occurrence
                resources=resources!{}
                groupId=deploymentGroup
                provider=provider
            /]
        [/#if]
    [/#list]
[/#macro]
