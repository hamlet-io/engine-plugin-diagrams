[#ftl]

[#macro diagrams_entrance_diagraminfo ]

  [@generateOutput
    deploymentFramework=getCLODeploymentFramework()
    type=getCLODeploymentOutputType()
    format=getCLODeploymentOutputFormat()
  /]

[/#macro]

[#macro diagrams_entrance_diagraminfo_inputsteps ]

  [@registerInputSeeder
    id=DIAGRAMINFO_ENTRANCE_TYPE
    description="Entrance"
  /]

  [@addSeederToConfigPipeline
    stage=COMMANDLINEOPTIONS_SHARED_INPUT_STAGE
    seeder=DIAGRAMINFO_ENTRANCE_TYPE
  /]

[/#macro]

[#function diagraminfo_configseeder_commandlineoptions filter state ]
  [#return
    addToConfigPipelineClass(
      state,
      COMMAND_LINE_OPTIONS_CONFIG_INPUT_CLASS,
      {
        "Deployment" : {
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
        },
        "View" : {
          "Name" : DIAGRAMINFO_VIEW_TYPE
        },
        "Flow" : {
          "Names" : [ "views" ]
        }
      }
    )]
[/#function]
