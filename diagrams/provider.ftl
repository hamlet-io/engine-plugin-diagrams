[#ftl]

[#assign DIAGRAMS_PROVIDER = "diagrams"]
[#assign DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK = "exec" ]


[#-- Diagram Types Configuration --]
[#assign diagramTypes = {}]

[#macro addDiagramType type description ]
    [#local configuration =
        {
            "Type" : type,
            "Description" : description
        }
    ]

    [@internalMergeDiagramTypesConfiguration
        type=type
        configuration=configuration
    /]
[/#macro]


[#function getDiagramType type ]
    [#return diagramTypes[type]!{} ]
[/#function]

[#function getAllDiagramTypes ]
    [#return diagramTypes ]
[/#function]

[#-------------------------------------------------------
-- Internal support functions for component processing --
---------------------------------------------------------]

[#-- Helper macro - not for general use --]
[#macro internalMergeDiagramTypesConfiguration type configuration]
    [#assign diagramTypes =
        mergeObjects(
            diagramTypes,
            {
                type : configuration
            }
        )]
[/#macro]
