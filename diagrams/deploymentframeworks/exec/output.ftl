[#ftl]

[#-- output types --]
[#assign DIAGRAMINFO_DEFAULT_OUTPUT_TYPE = "diagraminfo" ]

[#macro exec_output_json level="" include=""]
    [@initialiseJsonOutput name="details" /]
    [@initialiseJsonOutput name="entities" /]
    [@initialiseJsonOutput name="groups" /]
    [@initialiseJsonOutput name="relationships" /]

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

    [@toJSON
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
        } +
        attributeIfContent("HamletMessages", logMessages)
    /]
    [@serialiseOutput name=JSON_DEFAULT_OUTPUT_TYPE /]
[/#macro]


[#-- Diagraminfo --]
[#macro exec_output_diagraminfo level="" include="" ]
    [@initialiseJsonOutput name="diagrams" /]

    [@processFlows
        level=level
        framework=DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
        flows=commandLineOptions.Flow.Names
    /]

    [@toJSON
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
        } +
        attributeIfContent("COTMessages", logMessages)
    /]
[/#macro]

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
