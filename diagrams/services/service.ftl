[#ftl]

[#-- Services --]
[#assign DIAGRAMS_ENTITY_SERVICE = "entity" ]
[#assign DIAGRAMS_GROUP_SERVICE = "group" ]
[#assign DIAGRAMS_RELATIONSHIP_SERVICE = "relationship" ]

[#assign DIAGRAMS_SERVICERESOURCE_SECTION = "diagrams" ]

[#-- used to provide a provider specific generic service --]
[#assign DIAGRAMS_GENERIC_SERVICE = "generic" ]

[#-- Service Mappings map a particular hamlet service type to the appropriate class name used in diagrams --]
[#macro addDiagramServiceMapping provider service diagramsClass ]
    [@addServiceSection
        provider=provider
        service=service
        section=DIAGRAMS_SERVICERESOURCE_SECTION
        configuration={
            "DiagramsClass" : diagramsClass
        }
    /]
[/#macro]

[#macro addDiagramResourceMapping provider service resourceType diagramsClass ]
    [@addServiceResourceSection
        provider=provider
        service=service
        resource=resourceType
        section=DIAGRAMS_SERVICERESOURCE_SECTION
        configuration={
            "DiagramsClass" : diagramsClass
        }
    /]
[/#macro]

[#function getDiagramResourceSection provider service resourceType  ]
    [#return getServiceResourceSection(
        provider,
        service,
        resourceType,
        DIAGRAMS_SERVICERESOURCE_SECTION )]
[/#function]

[#function getDiagramServiceSection provider service ]
    [#return getServiceSection(
        provider,
        service,
        DIAGRAMS_SERVICERESOURCE_SECTION )]
[/#function]


[#function getDiagramClass provider service="" resourceType="" ]
    [#if ! service?has_content ]
        [#local service = getServiceFromResource(provider, resourceType)]
    [/#if]

    [#if getDiagramResourceSection(provider, service, resourceType)?has_content]
        [#return (getDiagramResourceSection(provider,service,resourceType).DiagramsClass)!"" ]
    [/#if]

    [#if getDiagramServiceSection(provider, service)?has_content ]
        [#return (getDiagramServiceSection(provider,service).DiagramsClass)!"" ]
    [/#if]

    [#if getDiagramServiceSection(provider, DIAGRAMS_GENERIC_SERVICE )?has_content]
        [#return (getDiagramServiceSection(provider, DIAGRAMS_GENERIC_SERVICE).DiagramsClass)!"" ]
    [/#if]

    [#if getDiagramResourceSection(SHARED_PROVIDER, service, resourceType)?has_content]
        [#return (getDiagramResourceSection(provider,service,resourceType).DiagramsClass)!"" ]
    [/#if]

    [#if getDiagramServiceSection(SHARED_PROVIDER, service)?has_content ]
        [#return (getDiagramServiceSection(provider,service).DiagramsClass)!"" ]
    [/#if]

    [#if getDiagramServiceSection(SHARED_PROVIDER, DIAGRAMS_GENERIC_SERVICE )?has_content]
        [#return (getDiagramServiceSection(SHARED_PROVIDER, DIAGRAMS_GENERIC_SERVICE).DiagramsClass)!"" ]
    [/#if]

    [#return ""]
[/#function]

[#macro execDiagramName name ]
    [@addToJsonOutput
        name="details"
        section="Name"
        content=name
    /]
[/#macro]

[#-- Set the default catch all mapping --]
[@addDiagramServiceMapping
    provider=SHARED_PROVIDER
    service=DIAGRAMS_GENERIC_SERVICE
    diagramsClass="diagrams.onprem.compute.Server"
/]
