[#ftl]

[#macro diagrams_entrance_diagram ]

  [#if getCLODeploymentUnitSubset() == "generationcontract" ]
    [#assign allDeploymentUnits = false]
  [/#if]
  [#assign allDeploymentUnits = true]

  [#local diagram = getActiveDiagram()]

  [#if ! diagram?has_content]
    [@fatal
      message="Diagram could not be found"
      detail="The diagram requested could not be found"
      context={
        "RequestedDiagram" : (diagram.Title!diagram.Name!diagram.Id)!""
      }
    /]
  [/#if]

  [#local diagramType = (diagram.Type)!""]
  [#local diagramTypeDetails = getDiagramType(diagramType)]

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
      type=getCLODeploymentOutputType()
      format=getCLODeploymentOutputFormat()
      level=diagramTypeDetails.Type!""
  /]

[/#macro]

[#macro diagrams_entrance_diagram_inputsteps]

  [@registerInputSeeder
    id=DIAGRAM_ENTRANCE_TYPE
    description="Entrance"
  /]

  [@addSeederToConfigPipeline
    stage=COMMANDLINEOPTIONS_SHARED_INPUT_STAGE
    seeder=DIAGRAM_ENTRANCE_TYPE
  /]

[/#macro]

[#function diagram_configseeder_commandlineoptions filter state ]
  [#return
    addToConfigPipelineClass(
      state,
      COMMAND_LINE_OPTIONS_CONFIG_INPUT_CLASS,
      {
        "Deployment" : {
          "Group" : {
              "Name" : "*"
          },
          "Framework" : {
              "Name" : DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
          },
          "Provider" : {
            "Names" :
              combineEntities(
                [ "diagrams" ],
                state.CommandLineOptions.Deployment.Provider.Names![],
                UNIQUE_COMBINE_BEHAVIOUR
              )
          }
        }
      }
    )]
[/#function]
