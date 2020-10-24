[#ftl]

[#assign DIAGRAMSTEST_SERVER_RESOURCE_TYPE = "server" ]
[@addServiceResource
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_COMPUTE_SERVICE
    resource=DIAGRAMSTEST_SERVER_RESOURCE_TYPE
/]

[@addDiagramServiceMapping
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_COMPUTE_SERVICE
    diagramsClass="diagrams.onprem.compute.Server"
/]
