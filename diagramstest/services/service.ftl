[#ftl]

[#-- Services --]
[#assign DIAGRAMSTEST_APIGATEWAY_SERVICE = "apigateway"]
[@addService
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_APIGATEWAY_SERVICE
/]

[#assign DIAGRAMSTEST_COMPUTE_SERVICE = "compute" ]
[@addService
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_COMPUTE_SERVICE
/]

[#assign DIAGRAMSTEST_DB_SERVICE = "db"]
[@addService
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_DB_SERVICE
/]

[#assign DIAGRAMSTEST_DOCKER_SERVICE = "docker" ]
[@addService
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_DOCKER_SERVICE
/]

[#assign DIAGRAMSTEST_LAMBDA_SERVICE = "lambda"]
[@addService
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_LAMBDA_SERVICE
/]

[#assign DIAGRAMSTEST_LB_SERVICE = "lb" ]
[@addService
    provider=DIAGRAMSTEST_PROVIDER
    service=DIAGRAMSTEST_LB_SERVICE
/]
