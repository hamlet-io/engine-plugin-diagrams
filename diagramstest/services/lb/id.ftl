[#ftl]

[#assign DIAGRAMSTEST_LB_RESOURCE_TYPE = "loadbalancer" ]
[@addServiceResource
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_LB_SERVICE
    resource=DIAGRAMSTEST_LB_RESOURCE_TYPE
/]

[#assign DIAGRAMSTEST_LBRULE_RESOURCE_TYPE = "lbrule" ]
[@addServiceResource
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_LB_SERVICE
    resource=DIAGRAMSTEST_LBRULE_RESOURCE_TYPE
/]

[@addDiagramServiceMapping
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_LB_SERVICE
    diagramsClass="diagrams.onprem.network.Nginx"
/]


[@addDiagramResourceMapping
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_LB_SERVICE
    resourceType=DIAGRAMSTEST_LBRULE_RESOURCE_TYPE
    diagramsClass="diagrams.onprem.network.Nginx"
/]
