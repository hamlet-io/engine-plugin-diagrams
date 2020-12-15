[#ftl]

[#-- Intial seeding of settings data based on input data --]
[#macro diagrams_input_shared_masterdata_seed ]
  [@addMasterData
    data=
      {
        "Diagrams" : {
          "overview" : {
            "Scope" : "component"
          },
          "resources" : {
            "Scope" : "resource"
          }
        }
      }
  /]
[/#macro]
