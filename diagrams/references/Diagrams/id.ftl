[#ftl]

[@addReference
    type=DIAGRAM_REFERENCE_TYPE
    pluralType="Diagrams"
    properties=[
            {
                "Type"  : "Description",
                "Value" : "A diagram representing part of your solution"
            }
        ]
    attributes=[
        {
            "Names" : "Scope",
            "Description" : "The scope of the diagram",
            "Type" : STRING_TYPE,
            "Values" : [ "component", "resource" ],
            "Default" : "component"
        },
        {
            "Names" : "Filters",
            "Description" : "Filters to apply on the diagram items",
            "Subobjects" : true,
            "Children" : [
                {
                    "Names" : "Type",
                    "Type" : STRING_TYPE,
                    "Values" : [ "Resource", "Component", "Tier" ],
                    "Mandatory" : true
                },
                {
                    "Names" : "Action",
                    "Description" : "How to handle matches on the filter",
                    "Type" : STRING_TYPE,
                    "Values" : [ "include", "exclude" ],
                    "Mandatory" : true
                },
                {
                    "Names" : "Resource",
                    "Description" : "Resource specific filter attributes",
                    "Children" : [
                        {
                            "Names" : "Types",
                            "Description" : "A list of hamlet resource types",
                            "Type" : ARRAY_OF_STRING_TYPE,
                            "Default" : []
                        }
                    ]
                },
                {
                    "Names" : "Component",
                    "Description" : "Components that are part of your solution",
                    "Children" : [
                        {
                            "Names" : "Links",
                            "Description" : "Links to the components to include",
                            "Children" : linkChildrenConfiguration
                        },
                        {
                            "Names" : "Ids",
                            "Description" : "A list of component ids to include",
                            "Type" : ARRAY_OF_STRING_TYPE,
                            "Default" : []
                        }
                    ]
                },
                {
                    "Names" : "Tier",
                    "Description" : "Solution tiers to exclude",
                    "Children" : [
                        {
                            "Names" : "Ids",
                            "Description" : "A list of tier Ids",
                            "Type" : ARRAY_OF_STRING_TYPE,
                            "Default" : []
                        }
                    ]
                }
            ]
        }
    ]
/]
