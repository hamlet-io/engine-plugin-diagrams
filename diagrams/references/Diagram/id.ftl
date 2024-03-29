[#ftl]

[@addReference
    type=DIAGRAM_REFERENCE_TYPE
    pluralType="Diagrams"
    properties=[
            {
                "Type"  : "Description",
                "Value" : "The definition of a diagram and its membership"
            }
        ]
    attributes=[
        {
            "Names" : "Enabled",
            "Types" : BOOLEAN_TYPE,
            "Description" : "Control the generation of the diagram",
            "Default" : true
        },
        {
            "Names" : "Title",
            "Description" : "The title of the diagram",
            "Types" : STRING_TYPE
        },
        {
            "Names" : "Description",
            "Description" : "The description of the diagram",
            "Types" : STRING_TYPE
        },
        {
            "Names" : "Type",
            "Description" : "The type of diagram to display the data in",
            "Types" : STRING_TYPE,
            "Mandatory" : true
        },
        {
            "Names" : "Rules",
            "SubObjects" : true,
            "Children" : [
                {
                    "Names" : "Action",
                    "Types" : STRING_TYPE,
                    "Values" : [ "Include", "Exclude" ],
                    "Mandatory" : true
                },
                {
                    "Names" : "Priority",
                    "Description" : "The order the rule will be applied - Lowest first",
                    "Types" : NUMBER_TYPE,
                    "Default" : 100
                },
                {
                    "Names" : "Policy",
                    "Types" : STRING_TYPE,
                    "Values" : [ "Links", "ComponentType", "ResourceType" ],
                    "Mandatory" : true
                },
                {
                    "Names" : "policy:Links",
                    "Children" : [
                        {
                            "Names" : "Links",
                            "SubObjects" : true,
                            "AttributeSet" : LINK_ATTRIBUTESET_TYPE
                        }
                    ]
                },
                {
                    "Names" : "policy:ComponentType",
                    "Children" : [
                        {
                            "Names" : "Types",
                            "Types" : ARRAY_OF_STRING_TYPE,
                            "Default" : []
                        }
                    ]
                },
                {
                    "Names" : "policy:ResourceType",
                    "Children" : [
                        {
                            "Names" : "Types",
                            "Types" : ARRAY_OF_STRING_TYPE,
                            "Default" : []
                        }
                    ]
                }
            ]
        }
    ]
/]
