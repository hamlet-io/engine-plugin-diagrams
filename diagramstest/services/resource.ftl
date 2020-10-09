[#ftl]

[#function getExistingReference resourceId attributeType="" inRegion="" inDeploymentUnit="" inAccount=(accountObject.AWSId)!""]
    [#local attributeType = (attributeType == REFERENCE_ATTRIBUTE_TYPE)?then(
                                "",
                                attributeType
    )]
    [#return getStackOutput( DIAGRAMSTEST_PROVIDER, formatAttributeId(resourceId, attributeType), inDeploymentUnit, inRegion, inAccount) ]
[/#function]
