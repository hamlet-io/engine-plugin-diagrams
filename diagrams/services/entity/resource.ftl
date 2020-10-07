[#ftl]

[#macro execDiagramEntity id name groupdId resourceProvider resourceProvider resourceType ]
    [@mergeWithJsonOutput
        name="entities"
        content={
            id : {
                "entityID" : id,
                "groupID" : groupdId,
                "type" : getDiagramClass(resourceProvider, "*", resourceType),
                "entityName" : name
            }
        }
    /]
[/#macro]
