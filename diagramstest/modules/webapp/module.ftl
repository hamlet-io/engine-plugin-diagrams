[#ftl]

[@addModule
    name="webapp"
    description="Testing module for diagrams based on a webahpp"
    provider=DIAGRAMSTEST_PROVIDER
    properties=[]
/]


[#macro diagramstest_module_webapp ]

    [@loadModule
        settingSets=[
            {
                "Type" : "Settings",
                "Scope" : "Accounts",
                "Namespace" : "mockacct-shared",
                "Settings" : {
                    "Registries": {
                        "docker": {
                            "EndPoint": "mockacct.registry.docker"
                        }
                    }
                }
            },
            {
                "Type" : "Builds",
                "Scope" : "Products",
                "Namespace" : "mockedup-integration-digramstest-webapp",
                "Settings" : {
                    "COMMIT" : "123456789#MockCommit#",
                    "FORMATS" : ["docker"]
                }
            }
        ]
        blueprint={
            "Tiers" : {
                "elb" : {
                    "Components" : {
                        "webapp-lb" : {
                            "lb" : {
                                "Instances" : {
                                    "default" : {
                                        "DeploymentUnits" : ["diagramstest-webapp-lb"]
                                    }
                                },
                                "IPAddressGroups" : [ "_global" ],
                                "PortMappings" : {
                                    "http" : {
                                        "Redirect" : {
                                        }
                                    },
                                    "https" : {
                                        "Forward" : {

                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                "app" : {
                    "Components" : {
                        "apphost" : {
                            "ecs" : {
                                "Instances" : {
                                    "default" : {
                                        "DeploymentUnits" : [ "diagramstest-webapp-apphost" ]
                                    }
                                },
                                "Services" : {
                                    "webapp" : {
                                        "Instances" : {
                                            "default" : {
                                                "DeploymentUnits"  : [ "diagramstest-webapp-webapp" ]
                                            }
                                        },
                                        "Containers" : {
                                            "web" : {
                                                "CPU" : 128,
                                                "Memory" : 256,
                                                "Links" : {
                                                    "db" : {
                                                        "Tier" : "db",
                                                        "Component" : "webapp-db",
                                                        "Instance" : "",
                                                        "Version" : ""
                                                    }
                                                },
                                                "Ports" : {
                                                    "http" : {
                                                        "LB" : {
                                                            "Tier" : "elb",
                                                            "Component" : "webapp-lb",
                                                            "PortMapping" : "https",
                                                            "Instance" : "",
                                                            "Version" : ""
                                                        }
                                                    }
                                                }
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
                        "webapp-db" : {
                            "db" : {
                                "Instances" : {
                                    "default" : {
                                        "DeploymentUnits" : [ "diagramstest-webapp-db" ]
                                    }
                                },
                                "Engine" : "postgres",
                                "EngineVersion" : "10",
                                "Size" : 20
                            }
                        }
                    }
                },
                "mgmt" : {
                    "Components" : {
                        "vpc" : {
                            "network" : {
                                "Instance" : {
                                    "default" : {
                                        "DeploymentUnits" : [ "vpc" ]
                                    }
                                }
                            }
                        }
                    }
                }
            },
            "Diagrams": {
                "webapp" : {
                    "Type" : "solution",
                    "Title" : "Web App and dependencies",
                    "Description" : "Our Web App and its dependencies",
                    "Rules" : {
                        "apiLinks" : {
                            "Action" : "Include",
                            "Policy" : "Links",
                            "policy:Links" : {
                                "Links" : {
                                    "webapp_lb" : {
                                        "Tier" : "elb",
                                        "Component" : "webapp-lb",
                                        "Instance" : "",
                                        "Version" : ""
                                    },
                                    "webapp_lb_http" : {
                                        "Tier" : "elb",
                                        "Component" : "webapp-lb",
                                        "PortMapping" : "http",
                                        "Instance" : "",
                                        "Version" : ""
                                    },
                                    "webapp_lb_https" : {
                                        "Tier" : "elb",
                                        "Component" : "webapp-lb",
                                        "PortMapping" : "https",
                                        "Instance" : "",
                                        "Version" : ""
                                    },
                                    "apphost" : {
                                        "Tier" : "app",
                                        "Component" : "apphost",
                                        "Instance" : "",
                                        "Version" : ""
                                    },
                                    "apphost_webapp" : {
                                        "Tier" : "app",
                                        "Component" : "apphost",
                                        "Service" : "webapp",
                                        "Instance" : "",
                                        "Version" : ""
                                    },
                                    "apidb" : {
                                        "Tier" : "db",
                                        "Component" : "apiservice-db",
                                        "Instance": "",
                                        "Version" : ""
                                    },
                                    "webapp_db" : {
                                        "Tier" : "db",
                                        "Component" : "webapp-db",
                                        "Instance" : "",
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
