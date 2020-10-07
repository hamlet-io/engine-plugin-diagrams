[#ftl]

[#macro shared_diagram_generationcontract occurrence ]
    [@addDefaultGenerationContract subsets=[ "config" ] /]
[/#macro]

[#macro shared_diagram_config occurrence ]

    [#local core = occurrence.Core]
    [#local solution = occurrence.Configuration.Solution]
    [#local resources = occurrence.State.Resources ]

    [#local placement = (occurrence.State.ResourceGroups["default"].Placement)!{} ]
    [#local provider = placement.Provider!commandLineOptions.Deployment.Provider.Names[0] ]

    [#local componentName = core.Component.Name ]

    [@execDiagramGroup
        id=componentName
    /]

    [@execDiagramGroup
        id=core.Name
        parentId=componentName
    /]

    [#if (resources!{})?has_content ]
        [#local primaryResourceId = resources?keys[0] ]
        [#local componentResourceType = (resources[primaryResourceId].Type)!core.Type ]

        [@execDiagramEntity
            id=core.Id
            name=core.FullName
            groupdId=core.Name
            resourceProvider=provider
            resourceType=componentResourceType
        /]
    [/#if]

    [#list occurrence.Occurrences![] as subOccurrence]

        [#local subCore = subOccurrence.Core]
        [#local subSolution = subOccurrence.Configuration.Solution]
        [#local subResources = subOccurrence.State.Resources ]

        [@execDiagramGroup
            id=subCore.Name
            parentId=core.Name
        /]

        [#if (subResources!{})?has_content ]
            [#local primaryResourceId = subResources?keys[0] ]
            [#local componentResourceType = (subResources[primaryResourceId].Type)!core.Type ]

            [@execDiagramEntity
                id=subCore.Id
                name=subCore.FullName
                groupdId=subCore.Name
                resourceProvider=provider
                resourceType=componentResourceType
            /]
        [/#if]
    [/#list]
[/#macro]
