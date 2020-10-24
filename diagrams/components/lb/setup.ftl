[#ftl]

[#macro shared_lb_exec_diagram_config_overview occurrence ]
    [@addComponentToOverview occurrence /]

    [#list occurrence.Occurrences as subOccurrence ]
        [#local solution = subOccurrence.Configuration.Solution ]
        [#if (solution.IPAddressGroups![])?has_content ]
            [@setupIPAddressGroupsRelationhsips
                entityId=subOccurrence.Core.TypedId
                IPAddressGroups=solution.IPAddressGroups
                includeLocal=false
                inbound=true
            /]
        [/#if]
    [/#list]
[/#macro]
