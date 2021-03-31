[#ftl]

[#function getActiveDiagram ]
    [#local diagrams = getReferenceData(DIAGRAM_REFERENCE_TYPE)]
    [#return (diagrams[getCLODeploymentUnit()])!{} ]
[/#function]