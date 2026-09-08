{
  "graph": {
    "cells": [
      {
        "position": {
          "x": 0,
          "y": 0
        },
        "size": {
          "height": 10,
          "width": 10
        },
        "type": "Statechart",
        "id": "78749915-0da0-40a2-862f-9e8d94c7c68e",
        "attrs": {
          "name": {
            "text": "actuator_statechart Export"
          },
          "specification": {
            "text": "namespace actuator_statechart\r\n\r\ninterface:\r\n    // Eventos de Entrada (Disparadores desde System)\r\n    in event EV_ACT_WELCOME\r\n    in event EV_ACT_PRINT_START\r\n    in event EV_ACT_BARRIER_UP\r\n    in event EV_ACT_BARRIER_DOWN\r\n    \r\n    in event EV_TICK\r\n\r\n    // Eventos de Salida (Acciones sobre el hardware del LED)\r\n    out event EV_LED_ON\r\n    out event EV_LED_OFF\r\n    out event EV_LED_TOGGLE\r\n    \r\n\r\n    // Variables de Control y Temporización\r\n    var tick : integer = 0\r\n    const DEL_BLINK_SLOW : integer = 1000\r\n    const DEL_BLINK_FAST : integer = 200\r\n    \r\n    "
          }
        },
        "z": 1
      },
      {
        "position": {
          "x": 816,
          "y": -162
        },
        "size": {
          "width": 126,
          "height": 60
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_LED_OFF",
            "fontSize": 11
          }
        },
        "id": "9560b739-9aad-4438-a4a8-706f3dc6da52",
        "z": 22
      },
      {
        "position": {
          "x": 816,
          "y": 4
        },
        "size": {
          "width": 126,
          "height": 60
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_BLINKING_SLOW",
            "fontSize": 11
          },
          "specification": {
            "text": "EV_TICK [tick > 0] / tick--"
          }
        },
        "id": "e360fb48-9738-468d-90ad-fc17ed7ff95e",
        "z": 27,
        "embeds": [
          "7ad9b127-5c72-4296-84ef-9c1f56d5ff1e"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "9560b739-9aad-4438-a4a8-706f3dc6da52"
        },
        "target": {
          "id": "e360fb48-9738-468d-90ad-fc17ed7ff95e",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "52.381%",
              "dy": "23.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_ACT_WELCOME / tick = DEL_BLINK_SLOW"
              }
            },
            "position": {
              "offset": -123,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "c8d48845-0371-4725-a59a-62f110213863",
        "z": 31,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "position": {
          "x": 810,
          "y": 288
        },
        "size": {
          "width": 126,
          "height": 60
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_LED_ON",
            "fontSize": 11
          }
        },
        "id": "70dc0cea-b52b-4891-9ac7-e6c6decdc01d",
        "z": 36
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "70dc0cea-b52b-4891-9ac7-e6c6decdc01d"
        },
        "target": {
          "id": "9560b739-9aad-4438-a4a8-706f3dc6da52",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "9.524%",
              "dy": "60%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_ACT_BARRIER_DOWN / raise EV_LED_OFF"
              }
            },
            "position": {
              "distance": 0.5000892269202057,
              "offset": -123,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "6d91ba86-43b2-4a06-97d5-7cef5d648352",
        "z": 38,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 738,
            "y": 324
          },
          {
            "x": 684,
            "y": 90
          }
        ]
      },
      {
        "position": {
          "x": 810,
          "y": 162
        },
        "size": {
          "height": 60,
          "width": 126
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_BLINKING_FAST",
            "fontSize": 11
          },
          "specification": {
            "text": "EV_TICK [tick > 0] / tick--"
          }
        },
        "id": "def3a10c-9281-44b3-b30f-e39c363d3b99",
        "z": 39,
        "embeds": [
          "9e1cb540-da6a-4624-865b-2330a9f198c2"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "e360fb48-9738-468d-90ad-fc17ed7ff95e"
        },
        "target": {
          "id": "def3a10c-9281-44b3-b30f-e39c363d3b99",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "57.143%",
              "dy": "0%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_ACT_PRINT_START / tick = DEL_BLINK_FAST"
              }
            },
            "position": {
              "distance": 0.2857142857142857,
              "offset": -120,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "cde630e6-4f74-4349-8918-381dc9224b7b",
        "z": 40,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "def3a10c-9281-44b3-b30f-e39c363d3b99"
        },
        "target": {
          "id": "70dc0cea-b52b-4891-9ac7-e6c6decdc01d",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "47.619%",
              "dy": "0%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_ACT_BARRIER_UP / raise EV_LED_ON\r\n\r\n"
              }
            },
            "position": {
              "distance": 0.7727272727272727,
              "offset": -105,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "04f8e6a2-2d29-45bb-ab55-57ab8173f1c4",
        "z": 40,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "e360fb48-9738-468d-90ad-fc17ed7ff95e"
        },
        "target": {
          "id": "e360fb48-9738-468d-90ad-fc17ed7ff95e",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "95.238%",
              "dy": "-6.667%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_TICK [tick == 0] / raise EV_LED_TOGGLE; tick = DEL_BLINK_SLOW"
              }
            },
            "position": {
              "distance": 0.49999999931111627,
              "offset": 183,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "7ad9b127-5c72-4296-84ef-9c1f56d5ff1e",
        "z": 41,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [],
        "parent": "e360fb48-9738-468d-90ad-fc17ed7ff95e"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "def3a10c-9281-44b3-b30f-e39c363d3b99"
        },
        "target": {
          "id": "def3a10c-9281-44b3-b30f-e39c363d3b99",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "99.206%",
              "dy": "18.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_TICK [tick == 0] / raise EV_LED_TOGGLE; tick = DEL_BLINK_FAST"
              }
            },
            "position": {
              "distance": 0.35389577631248875,
              "offset": 181,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "9e1cb540-da6a-4624-865b-2330a9f198c2",
        "z": 42,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 959,
            "y": 142
          },
          {
            "x": 935,
            "y": 121
          }
        ],
        "parent": "def3a10c-9281-44b3-b30f-e39c363d3b99"
      },
      {
        "position": {
          "x": 872,
          "y": -239
        },
        "size": {
          "height": 18,
          "width": 18
        },
        "type": "Entry",
        "entryKind": "Initial",
        "attrs": {},
        "id": "68919e12-6496-4959-ad38-00b50ec694bd",
        "z": 43,
        "embeds": [
          "fa1afca6-8113-473a-8f3d-165e5af4eb32"
        ]
      },
      {
        "type": "NodeLabel",
        "label": true,
        "size": {
          "width": 15,
          "height": 15
        },
        "position": {
          "x": 872,
          "y": -224
        },
        "attrs": {
          "label": {
            "refX": "50%",
            "textAnchor": "middle",
            "refY": "50%",
            "textVerticalAnchor": "middle"
          }
        },
        "id": "fa1afca6-8113-473a-8f3d-165e5af4eb32",
        "z": 44,
        "parent": "68919e12-6496-4959-ad38-00b50ec694bd"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "68919e12-6496-4959-ad38-00b50ec694bd"
        },
        "target": {
          "id": "9560b739-9aad-4438-a4a8-706f3dc6da52",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "51.111%",
              "dy": "10%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {},
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "4d2800fb-7ca7-4af4-a0a6-58a3cfde700d",
        "z": 45,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      }
    ]
  },
  "genModel": {
    "generator": {
      "type": "create::c",
      "features": {
        "Outlet": {
          "targetProject": "",
          "targetFolder": "",
          "libraryTargetFolder": "",
          "skipLibraryFiles": "",
          "apiTargetFolder": ""
        },
        "LicenseHeader": {
          "licenseText": ""
        },
        "FunctionInlining": {
          "inlineReactions": false,
          "inlineEntryActions": false,
          "inlineExitActions": false,
          "inlineEnterSequences": false,
          "inlineExitSequences": false,
          "inlineChoices": false,
          "inlineEnterRegion": false,
          "inlineExitRegion": false,
          "inlineEntries": false
        },
        "OutEventAPI": {
          "observables": false,
          "getters": false
        },
        "IdentifierSettings": {
          "moduleName": "MyFirstStatechart",
          "statemachinePrefix": "myFirstStatechart",
          "separator": "_",
          "headerFilenameExtension": "h",
          "sourceFilenameExtension": "c"
        },
        "Tracing": {
          "enterState": false,
          "exitState": false,
          "generic": false
        },
        "Includes": {
          "useRelativePaths": false,
          "generateAllSpecifiedIncludes": false
        },
        "GeneratorOptions": {
          "userAllocatedQueue": false,
          "metaSource": false
        },
        "GeneralFeatures": {
          "timerService": false,
          "timerServiceTimeType": ""
        },
        "Debug": {
          "dumpSexec": false
        }
      }
    }
  }
}