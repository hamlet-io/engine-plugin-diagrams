[#ftl]

[#assign DIAGRAMSTEST_APIGATEWAY_RESOURCE_TYPE = "apigateway" ]

[@addServiceResource
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_APIGATEWAY_SERVICE
    resource=DIAGRAMSTEST_APIGATEWAY_RESOURCE_TYPE
/]

[@addDiagramServiceMapping
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_APIGATEWAY_SERVICE
    diagramsClass="diagrams.onprem.network.Kong"
/]
