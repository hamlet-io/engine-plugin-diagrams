[#ftl]

[#macro diagrams_view_exec_diagraminfo_generationcontract  ]
    [@addDefaultGenerationContract subsets=[ "diagraminfo" ] /]
[/#macro]

[#macro diagrams_view_exec_diagraminfo ]
    [#list getAllDiagramScopes() as scope,details ]
        [@diagramInfoDiagram
            scope=scope
            details=details
        /]
    [/#list]
[/#macro]
