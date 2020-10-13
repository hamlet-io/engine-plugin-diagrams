[#ftl]

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

    [@execDiagramName
        name=formatSegmentFullName()
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
        attributeIfContent("COTMessages", logMessages)
    /]
    [@serialiseOutput name=JSON_DEFAULT_OUTPUT_TYPE /]
[/#macro]
