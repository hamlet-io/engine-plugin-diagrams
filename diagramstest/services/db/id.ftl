[#ftl]

[#assign DIAGRAMSTEST_DB_RESOURCE_TYPE = "db" ]

[@addDiagramResourceMapping
    provider=DIAGRAMSTEST_PROVIDER
    service="*"
    resourceType=DIAGRAMSTEST_DB_RESOURCE_TYPE
    diagramsClass="diagrams.onprem.database.Postgresql"
/]
