[#ftl]

[#macro diagrams_entrance_diagram ]

  [#assign allDeploymentUnits = true]

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

  [#if (commandLineOptions.Deployment.Unit.Subset!"") == "generationcontract" ]
    [#assign allDeploymentUnits = false]
  [/#if]


  [#-- Preload the configuration as it won't be avaiable via the other providers --]
  [@includeProviderComponentConfiguration
    provider=DIAGRAMS_PROVIDER
    component="shared"
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
  /]

[/#macro]
