[#ftl]

[#assign DIAGRAMS_PROVIDER = "diagrams"]
[#assign DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK = "exec" ]

[#function getDiagram id ]
    [#local diagrams = getReferenceData(DIAGRAM_REFERENCE_TYPE) ]
    [#return diagrams[id]!{} ]
[/#function]

[#-- Diagram Types Configuration --]
[#assign diagramScopes = {}]

[#macro addDiagramScope scope description name="" ]
    [#local configuration =
        {
            "Name" : contentIfContent(name, type),
            "Scope" : scope,
            "Description" : description
        }
    ]

    [@internalMergeDiagramScopesConfiguration
        scope=scope
        configuration=configuration
    /]
[/#macro]


[#function getDiagramScope scope ]
    [#return diagramScopes[scope]!{} ]
[/#function]

[#function getAllDiagramScopes ]
    [#return diagramScopes ]
[/#function]

[#-------------------------------------------------------
-- Internal support functions for component processing --
---------------------------------------------------------]

[#-- Helper macro - not for general use --]
[#macro internalMergeDiagramScopesConfiguration scope configuration]
    [#assign diagramScopes =
        mergeObjects(
            diagramScopes,
            {
                scope : configuration
            }
        )]
[/#macro]
