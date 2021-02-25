[#ftl]

[#macro diagrams_entrance_diagram ]


  [#if (commandLineOptions.Deployment.Unit.Subset!"") == "generationcontract" ]
    [#assign allDeploymentUnits = false]
  [/#if]

  [#assign allDeploymentUnits = true]

  [#local diagram = getActiveDiagram()]

  [#if ! diagram?has_content]
    [@fatal
      message="Diagram could not be found"
      detail="The diagram requested could not be found"
      context={
        "RequestedDiagram" : diagramId,
        "DiagramsAvailable" : diagrams?keys
      }
    /]
  [/#if]

  [#local diagramType = (diagram.Type)!""]
  [#local diagramTypeDetails = getDiagramType(diagramType)]

  [#if ! diagramTypeDetails?has_content ]
    [@fatal
      message="Invalid Diagram Type"
      detail="Please provide an available diagram type using the deploymentGroup/level"
      context={
        "ConfiguredType" : diagramType,
        "TypesAvailable" : getAllDiagramTypes()
      }
    /]
  [/#if]

  [#-- override the deployment group to get all deployment groups --]
  [@addCommandLineOption
      option={
        "Deployment" : {
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
    services=[
      DIAGRAMS_ENTITY_SERVICE,
      DIAGRAMS_GROUP_SERVICE,
      DIAGRAMS_RELATIONSHIP_SERVICE
    ]
    deploymentFramework=DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
  /]

  [@generateOutput
      deploymentFramework=DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
      type=commandLineOptions.Deployment.Output.Type
      format=commandLineOptions.Deployment.Output.Format
      level=diagramTypeDetails.Type!""
  /]

[/#macro]
