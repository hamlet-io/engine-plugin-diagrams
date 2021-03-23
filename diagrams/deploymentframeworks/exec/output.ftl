[#ftl]

[#-- output types --]
[#assign DIAGRAMINFO_DEFAULT_OUTPUT_TYPE = "diagraminfo" ]

[#function exec_output_json level="" include=""]
    [@initialiseJsonOutput name="details" /]
    [@initialiseJsonOutput name="entities" /]
    [@initialiseJsonOutput name="groups" /]
    [@initialiseJsonOutput name="relationships" /]

    [@setOutputFileProperties format="json" /]

    [#-- Resources --]
    [#if include?has_content]
        [#include include?ensure_starts_with("/")]
    [#else]
        [@processFlows
            level=level
            framework=DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
            flows=commandLineOptions.Flow.Names
        /]
    [/#if]

    [#local diagram = getActiveDiagram()]
    [#local diagramName = (diagram.Title!diagram.Name!diagram.Id)!""]

    [@execDiagramName
        name=diagramName + " - " + formatSegmentFullName()
    /]

    [#return
        {
            "Metadata" : {
                "Id" : getOutputContent("details", "Name"),
                "Prepared" : .now?iso_utc,
                "RunId" : commandLineOptions.Run.Id,
                "RequestReference" : commandLineOptions.References.Request,
                "ConfigurationReference" : commandLineOptions.References.Configuration
            },
            "diagramName" : getOutputContent("details", "Name"),
            "entities" : (getOutputContent("entities")?values)?sort_by("entityID"),
            "relationships" : getOutputContent("relationships")?values,
            "groups" : (getOutputContent("groups")?values)?sort_by("groupID")
        }
    ]
[/#function]


[#-- Diagraminfo --]
[#function exec_output_diagraminfo level="" include="" ]
    [@initialiseJsonOutput name="diagrams" /]
    [@setOutputFileProperties format="json" /]

    [@processFlows
        level=level
        framework=DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
        flows=commandLineOptions.Flow.Names
    /]

    [#return
        {
            "Metadata" : {
                "Id" : "hamlet-info",
                "Prepared" : .now?iso_utc,
                "RunId" : commandLineOptions.Run.Id,
                "RequestReference" : commandLineOptions.References.Request,
                "ConfigurationReference" : commandLineOptions.References.Configuration
            },
            "DiagramTypes" : getOutputContent("diagramtypes")?values,
            "Diagrams" : getOutputContent("diagrams")?values
        }
    ]
[/#function]

[#macro diagramTypeInfoDiagram type details ]
    [@mergeWithJsonOutput
        name="diagramtypes"
        content={
            type : details
        }
    /]
[/#macro]

[#macro diagramInfoDiagram id details ]
    [@mergeWithJsonOutput
        name="diagrams"
        content={
            id : { "Id" : id } + details
        }
    /]
[/#macro]

[@addGenerationContractStepOutputMapping
    provider=DIAGRAMS_PROVIDER
    subset="diagraminfo"
    outputType=DIAGRAMINFO_DEFAULT_OUTPUT_TYPE
    outputFormat=""
    outputSuffix="diagraminfo.json"
/]
