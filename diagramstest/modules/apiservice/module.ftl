[#ftl]

[@addModule
    name="apiservice"
    description="Testing module for diagrams based on an apiservice"
    provider=DIAGRAMSTEST_PROVIDER
    properties=[]
/]

[#macro diagramstest_module_apiservice ]

    [#-- Base apigateway setup - No solution parameters --]
    [@loadModule
        definitions={
            "appXapigatewaybase" : {
                "swagger": "2.0",
                "info": {
                    "version": "v1.0.0",
                    "title": "Proxy",
                    "description": "Pass all requests through to the implementation."
                },
                "paths": {
                    "/{proxy+}": {
                        "x-amazon-apigateway-any-method": {
                        }
                    }
                },
                "definitions": {
                    "Empty": {
                        "type": "object",
                        "title": "Empty Schema"
                    }
                }
            }
        }
    /]

    [@loadModule
        settingSets=[
            {
                "Type" : "Settings",
                "Scope" : "Accounts",
                "Namespace" : "mockacct-shared",
                "Settings" : {
                    "Registries": {
                        "openapi": {
                            "EndPoint": "account-registry-abc123",
                            "Prefix": "openapi/"
                        }
                    }
                }
            },
            {
                "Type" : "Builds",
                "Scope" : "Products",
                "Namespace" : "mockedup-integration-digramstest-apiservice",
                "Settings" : {
                    "COMMIT" : "123456789#MockCommit#",
                    "FORMATS" : ["openapi"]
                }
            },
            {
                "Type" : "Settings",
                "Scope" : "Products",
                "Namespace" : "mockedup-integration-digramstest-apiservice",
                "Settings" : {
                    "apigw": {
                        "Internal": true,
                        "Value": {
                            "Type": "lambda",
                            "Proxy": false,
                            "BinaryTypes": ["*/*"],
                            "ContentHandling": "CONVERT_TO_TEXT",
                            "Variable": "LAMBDA_API_LAMBDA"
                        }
                    }
                }
            }
        ]
        blueprint={
            "Tiers" : {
                "api" : {
                    "Components" : {
                        "apiservice-apigateway" : {
                            "apigateway" : {
                                "Instances" : {
                                    "default" : {
                                        "DeploymentUnits" : ["diagramstest-apiservice-apigateway"]
                                    }
                                },
                                "IPAddressGroups" : [ "_global" ],
                                "Links" : {
                                    "Lambda" : {
                                        "Tier" : "api",
                                        "Component" : "apiservice-lambda",
                                        "Function" : "api"
                                    }
                                }
                            }
                        },
                        "apiservice-lambda" : {
                            "lambda" : {
                                "Instances" : {
                                    "default" : {
                                        "DeploymentUnits" : [ "diagramstest-apiservice-lambda" ]
                                    }
                                },
                                "Functions" : {
                                    "api" : {
                                        "RunTime" : "python3.8",
                                        "Handler" : "lambda.handler",
                                        "Links" : {
                                            "apigw" : {
                                                "Tier" : "api",
                                                "Component" : "apiservice-apigateway",
                                                "Direction" : "Inbound"
                                            },
                                            "database" : {
                                                "Tier" : "db",
                                                "Component" : "apiservice-db"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                "db" : {
                    "Components" : {
                        "apiservice-db" : {
                            "db" : {
                                "Instances" : {
                                    "default" : {
                                        "DeploymentUnits" : [ "diagramstest-apiservice-db" ]
                                    }
                                },
                                "Engine" : "postgres",
                                "EngineVersion" : "10",
                                "Size" : 20
                            }
                        }
                    }
                }
            },
            "Diagrams": {
                "apiservice" : {
                    "Type" : "solution",
                    "Title" : "API Endpoint and Services",
                    "Description" : "Our API Endpoint and its dependencies",
                    "Rules" : {
                        "apiLinks" : {
                            "Action" : "Include",
                            "Policy" : "Links",
                            "policy:Links" : {
                                "Links" : {
                                    "apigw" : {
                                        "Tier" : "api",
                                        "Component" : "apiservice-apigateway",
                                        "Instance" : "",
                                        "Version" : ""
                                    },
                                    "apilambda" : {
                                        "Tier" : "api",
                                        "Component" : "apiservice-lambda",
                                        "Function" : "api",
                                        "Instance" : "",
                                        "Version" : ""
                                    },
                                    "apidb" : {
                                        "Tier" : "db",
                                        "Component" : "apiservice-db",
                                        "Instance": "",
                                        "Version" : ""
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    /]
[/#macro]
