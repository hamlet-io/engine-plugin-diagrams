[#ftl]

[#macro shared_ecs_exec_diagram_config_solution occurrence ]
    [@addComponentToSolutionDiagram occurrence /]

    [#list occurrence.Occurrences as subOccurrence ]

        [#local core = subOccurrence.Core ]
        [#local solution = subOccurrence.Configuration.Solution ]

        [#list solution.Containers as id, container ]
            [@addDiagramRelationshipsFromLinks
                occurrence=subOccurrence
                links=container.Links
            /]
        [/#list]

        [#if core.Type == ECS_SERVICE_COMPONENT_TYPE ]
            [#list solution.Containers as id, container ]
                [#list container.Ports as id,port ]
                    [#if isPresent(port.LB) ]

                        [#local lbLink = {
                                port.LB.LinkName :
                                    port.LB + {
                                        "Name" : port.LB.LinkName,
                                        "Direction" : "inbound"
                                    }
                                }]

                        [@addDiagramRelationshipsFromLinks
                            occurrence=subOccurrence
                            links=lbLink
                        /]
                    [/#if]

                    [#if isPresent(port.Registry)]

                        [#local registryLink = {
                            port.Registry.LinkName :
                                port.Registry + {
                                    "Name" : port.Registry.LinkName,
                                    "Direction" : "inbound"
                                }
                            }]

                        [@addDiagramRelationshipsFromLinks
                            occurrence=subOccurrence
                            links=registryLink
                        /]
                    [/#if]
                [/#list]
            [/#list]
        [/#if]
    [/#list]
[/#macro]
