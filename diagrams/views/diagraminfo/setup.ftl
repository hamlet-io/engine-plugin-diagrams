[#ftl]

[#macro diagrams_view_exec_diagraminfo_generationcontract  ]
    [@addDefaultGenerationContract subsets=[ "diagraminfo" ] /]
[/#macro]

[#macro diagrams_view_exec_diagraminfo ]
    [#list getAllDiagramTypes() as type,details ]
        [@diagramInfoDiagram
            type=type
            details=details
        /]
    [/#list]
[/#macro]
