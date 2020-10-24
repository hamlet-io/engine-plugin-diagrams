[#ftl]

[#assign DIAGRAMSTEST_CONTAINER_RESOURCE_TYPE = "container" ]
[@addServiceResource
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_DOCKER_SERVICE
    resource=DIAGRAMSTEST_CONTAINER_RESOURCE_TYPE
/]

[@addDiagramServiceMapping
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_DOCKER_SERVICE
    diagramsClass="diagrams.onprem.container.Docker"
/]
