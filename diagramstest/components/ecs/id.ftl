[#ftl]

[@addResourceGroupInformation
    type=ECS_COMPONENT_TYPE
    attributes=[]
    provider=DIAGRAMSTEST_PROVIDER
    resourceGroup=DEFAULT_RESOURCE_GROUP
    services=
        [
            DIAGRAMSTEST_COMPUTE_SERVICE
        ]
/]

[@addResourceGroupInformation
    type=ECS_SERVICE_COMPONENT_TYPE
    attributes=[]
    provider=DIAGRAMSTEST_PROVIDER
    resourceGroup=DEFAULT_RESOURCE_GROUP
    services=
        [
            DIAGRAMSTEST_DOCKER_SERVICE
        ]
/]
