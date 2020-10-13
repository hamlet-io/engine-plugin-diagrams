[#ftl]

[#assign DIAGRAMSTEST_APIGATEWAY_RESOURCE_TYPE = "apigateway" ]

[@addDiagramResourceMapping
    provider=DIAGRAMSTEST_PROVIDER
    service="*"
    resourceType=DIAGRAMSTEST_APIGATEWAY_RESOURCE_TYPE
    diagramsClass="diagrams.onprem.network.Nginx"
/]
