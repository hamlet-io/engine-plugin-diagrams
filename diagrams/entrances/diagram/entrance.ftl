[#ftl]

[#macro diagrams_entrance_diagram ]


  [#if (commandLineOptions.Deployment.Unit.Subset!"") == "generationcontract" ]
    [#assign allDeploymentUnits = false]
  [/#if]

  [#assign allDeploymentUnits = true]

  [#local diagramId = commandLineOptions.Diagrams.Id ]
  [#local diagramDetails = getDiagram(diagramId)]

  [#if ! diagramDetails?has_content ]
    [@fatal
      message="Diagram not found"
      detail="Could not find a diagram which matched the provided id"
      context={
        "diagram" : diagramId
      }
    /]
  [/#if]

  [#-- override the deployment group to get all deployment groups --]
  [@addCommandLineOption
      option={
        "Deployment" : {
          "Unit" : {
            "Name" : ""
          },
          "Group" : {
              "Name" : "*"
          },
          "Framework" : {
              "Name" : DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
          }
        }
      }
  /]

  [#-- Preload the configuration as it won't be avaiable via the other providers --]
  [@includeAllComponentConfiguration
    DIAGRAMS_PROVIDER
  /]

  [@includeServicesConfiguration
    provider=DIAGRAMS_PROVIDER
    services=[ DIAGRAMS_ENTITY_SERVICE, DIAGRAMS_GROUP_SERVICE, DIAGRAMS_RELATIONSHIP_SERVICE ]
    deploymentFramework=DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
  /]

  [@generateOutput
      deploymentFramework=DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
      type=commandLineOptions.Deployment.Output.Type
      format=commandLineOptions.Deployment.Output.Format
      level=diagramDetails.Scope
  /]

[/#macro]
