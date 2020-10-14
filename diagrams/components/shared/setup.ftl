[#ftl]

[#macro shared_diagram_generationcontract occurrence ]
    [@addDefaultGenerationContract subsets=[ "config" ] /]
[/#macro]

[#macro shared_diagram_config_overview occurrence ]

    [#local core = occurrence.Core]
    [#local solution = occurrence.Configuration.Solution]
    [#local resources = occurrence.State.Resources ]

    [#local placement = (occurrence.State.ResourceGroups["default"].Placement)!{} ]
    [#local provider = placement.Provider!commandLineOptions.Deployment.Provider.Names[0] ]

    [#local componentName = core.Component.Name ]

    [@execDiagramGroup
        id=componentName
    /]

    [#if (resources!{})?has_content ]
        [#local primaryResourceId = resources?keys[0] ]
        [#local componentResourceType = (resources[primaryResourceId].Type)!core.Type ]

        [@execDiagramGroup
            id=core.Name
            parentId=componentName
        /]

        [@execDiagramEntity
            id=core.Id
            name=core.FullName
            groupId=core.Name
            resourceProvider=provider
            resourceType=componentResourceType
        /]

        [#if ((solution.Links)!{})?has_content ]
            [@addDiagramRelationshipsFromLinks
                occurrence=occurrence
                links=getLinkTargets(occurrence)
            /]
        [/#if]
    [/#if]

    [#list occurrence.Occurrences![] as subOccurrence]

        [#local subCore = subOccurrence.Core]
        [#local subSolution = subOccurrence.Configuration.Solution]
        [#local subResources = subOccurrence.State.Resources ]

        [#if (subResources!{})?has_content ]
            [#local primaryResourceId = subResources?keys[0] ]
            [#local componentResourceType = (subResources[primaryResourceId].Type)!core.Type ]

            [@execDiagramGroup
                id=subCore.Name
                parentId=core.Name
            /]

            [@execDiagramEntity
                id=subCore.Id
                name=subCore.FullName
                groupId=subCore.Name
                resourceProvider=provider
                resourceType=componentResourceType
            /]

            [#if ((subSolution.Links)!{})?has_content ]
                [@addDiagramRelationshipsFromLinks
                    occurrence=subOccurrence
                    links=getLinkTargets(subOccurrence)
                /]
            [/#if]

        [/#if]
    [/#list]
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

        [@execDiagramGroup
            id=deploymentGroup
            parentId=""
        /]

        [@addDiagramEntitiesFromResources
            resources=resources!{}
            groupId=deploymentGroup
            provider=provider
        /]

    [/#list]
[/#macro]
