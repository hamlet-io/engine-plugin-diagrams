[#ftl]

[#macro execDiagramGroup id parentId="" ]
    [@mergeWithJsonOutput
        name="groups"
        content={
            id : {
                "groupID" : id
            } +
            attributeIfContent(
                "parentID",
                parentId
            )
        }
    /]
[/#macro]
