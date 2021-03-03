[#ftl]

[#macro shared_lb_exec_diagram_config_solution occurrence ]
    [@addComponentToSolutionDiagram occurrence /]

    [#list occurrence.Occurrences as subOccurrence ]
        [#if isOccurrenceInDiagram(subOccurrence)]
            [#local solution = subOccurrence.Configuration.Solution ]
            [#if (solution.IPAddressGroups![])?has_content ]
                [@setupIPAddressGroupsRelationships
                    entityId=subOccurrence.Core.TypedId
                    IPAddressGroups=solution.IPAddressGroups
                    includeLocal=false
                    inbound=true
                /]
            [/#if]
        [/#if]
    [/#list]

[/#macro]
