[#ftl]

[#assign DIAGRAMSTEST_DB_RESOURCE_TYPE = "db" ]
[@addServiceResource
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_DB_SERVICE
    resource=DIAGRAMSTEST_DB_RESOURCE_TYPE
/]

[@addDiagramServiceMapping
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_DB_SERVICE
    diagramsClass="diagrams.onprem.database.Postgresql"
/]
