[#ftl]

[#macro diagrams_view_exec_diagraminfo_generationcontract  ]
    [@addDefaultGenerationContract subsets=[ "diagraminfo" ] /]
[/#macro]

[#macro diagrams_view_exec_diagraminfo ]
    [#list getAllDiagramTypes() as type,details ]
        [@diagramTypeInfoDiagram
            type=type
            details=details
        /]
    [/#list]

    [#list getReferenceData(DIAGRAM_REFERENCE_TYPE) as id, details ]
        [@diagramInfoDiagram
            id=id
            details=details
        /]
    [/#list]
[/#macro]
