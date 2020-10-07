[#ftl]

[#-- Services --]
[#assign DIAGRAMS_ENTITY_SERVICE = "entity" ]
[#assign DIAGRAMS_GROUP_SERVICE = "group" ]
[#assign DIAGRAMS_RELATIONSHIP_SERVICE = "relationship" ]

[#-- Service Mappings map a particular hamlet service type to the appropriate class name used in diagrams --]
[#assign diagramMappings = {} ]

[#macro addDiagramServiceMapping provider service diagramsClass ]
    [@internalMergeDiagramMappings
        provider=provider
        service=service
        resourceType="*"
        diagramsClass=diagramsClass
    /]
[/#macro]

[#macro addDiagramResourceMapping provider service resourceType diagramsClass ]
    [@internalMergeDiagramMappings
        provider=provider
        service=service
        resourceType=resourceType
        diagramsClass=diagramsClass
    /]
[/#macro]

[#function getDiagramClass provider service resourceType="" ]
    [#local possibleMappings = {}]
    [#list diagramMappings as provider,serviceMappings ]
        [#list serviceMappings as service,resourceMappings ]
            [#list resourceMappings as resource,details ]
                [#local possibleMappings = mergeObjects(
                    possibleMappings,
                    { formatName(provider, service, resource ) : details.DiagramsClass }
                )]
            [/#list]
        [/#list]
    [/#list]

    [#local matchOptions = [
        [ provider, service, resourceType ],
        [ provider, service, "*" ],
        [ SHARED_PROVIDER, service, resourceType ],
        [ SHARED_PROVIDER, service, "*" ],
        [ SHARED_PROVIDER, "generic", "default" ]
    ]]

    [#list matchOptions as option ]
        [#local optionMapping = formatName(option)]
        [#if (possibleMappings?keys)?seq_contains(optionMapping) ]
            [#return possibleMappings[optionMapping] ]
        [/#if]
    [/#list]
    [#return ""]
[/#function]

[#macro internalMergeDiagramMappings provider service resourceType diagramsClass ]
    [#assign diagramMappings =  mergeObjects(
            diagramMappings,
            {
                provider : {
                    service : {
                        resourceType : {
                            "DiagramsClass" : diagramsClass
                        }
                    }
                }
            }
    ) ]
[/#macro]


[#-- Set the default catch all mapping --]
[@addDiagramResourceMapping
    provider=SHARED_PROVIDER
    service="generic"
    resourceType="default"
    diagramsClass="diagrams.onprem.compute.Server"
/]
