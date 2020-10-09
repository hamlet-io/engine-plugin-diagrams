[#ftl]

[#assign DIAGRAMSTEST_DB_RESOURCE_TYPE = "db" ]

[@addDiagramServiceMapping
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_DB_SERVICE
    diagramsClass="diagrams.onprem.database.Postgresql"
/]
