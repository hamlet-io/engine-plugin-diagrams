[#ftl]

[#function getExistingReference resourceId attributeType="" inRegion="" inDeploymentUnit="" inAccount=""]
    [#local attributeType = (attributeType == REFERENCE_ATTRIBUTE_TYPE)?then(
                                "",
                                attributeType
    )]
    [#return getStatePointValue( formatAttributeId(resourceId, attributeType), inDeploymentUnit, inAccount, inRegion) ]
[/#function]
