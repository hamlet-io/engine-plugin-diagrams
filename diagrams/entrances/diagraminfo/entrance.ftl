[#ftl]

[#macro diagrams_entrance_diagraminfo ]

  [#-- override the deployment group to get all deployment groups --]
  [@addCommandLineOption
      option={
        "Deployment" : {
          "Framework" : {
            "Name" : DIAGRAMS_EXEC_DEPLOYMENT_FRAMEWORK
          },
          "Provider" : {
            "Names" : combineEntities(
                        [ "diagrams" ],
                        commandLineOptions.Deployment.Provider.Names,
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
  /]

  [@generateOutput
    deploymentFramework=commandLineOptions.Deployment.Framework.Name
    type=commandLineOptions.Deployment.Output.Type
    format=commandLineOptions.Deployment.Output.Format
  /]

[/#macro]
