[#ftl]

[#macro diagrams_view_diagraminfo_exec_generationcontract  ]
    [@addDefaultGenerationContract subsets=[ "diagraminfo" ] /]
[/#macro]

[#macro diagrams_view_diagraminfo_exec ]
    [#list getAllDiagramTypes() as type,details ]
        [@diagramInfoDiagram
            type=type
            details=details
        /]
    [/#list]
[/#macro]
