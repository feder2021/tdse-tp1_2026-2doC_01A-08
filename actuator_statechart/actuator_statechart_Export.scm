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
            "text": "namespace actuator_statechart\r\n\r\ninterface:\r\n    in event EV_ACT_OPEN_BARRIER\r\n    in event EV_ACT_CLOSE_BARRIER\r\n    \r\n    in event EV_TICK\r\n\r\n    out event EV_LED_ON\r\n    out event EV_LED_OFF\r\n    out event EV_LED_TOGGLE\r\n\r\n    var tick : integer = 0\r\n    var tick_blink : integer = 0\r\n    const DEL_RAISING : integer = 2000\r\n    const DEL_LOWERING : integer = 200\r\n    const DEL_FREQ_1 : integer = 200\r\n    const DEL_FREQ_2 : integer = 500\r\n    \r\n    "
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
          "height": 60,
          "width": 126
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_BARRIER_CLOSED",
            "fontSize": 11
          }
        },
        "id": "9560b739-9aad-4438-a4a8-706f3dc6da52",
        "z": 22
      },
      {
        "position": {
          "x": 809,
          "y": 4
        },
        "size": {
          "width": 132,
          "height": 82
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_BARRIER_RAISING",
            "fontSize": 11
          },
          "specification": {
            "text": "EV_TICK [tick > 0 && tick_blink > 0] / tick-- ; tick_blink--"
          }
        },
        "id": "e360fb48-9738-468d-90ad-fc17ed7ff95e",
        "z": 27,
        "embeds": [
          "7ad9b127-5c72-4296-84ef-9c1f56d5ff1e"
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
            "text": "ST_BARRIER_OPEN",
            "fontSize": 11
          }
        },
        "id": "def3a10c-9281-44b3-b30f-e39c363d3b99",
        "z": 39,
        "embeds": []
      },
      {
        "position": {
          "x": 871,
          "y": -255
        },
        "size": {
          "height": 18,
          "width": 18
        },
        "type": "Entry",
        "entryKind": "Initial",
        "attrs": {},
        "id": "68919e12-6496-4959-ad38-00b50ec694bd",
        "z": 54,
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
          "x": 871,
          "y": -240
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
        "z": 55,
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
        "z": 56,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "position": {
          "x": 812,
          "y": 307
        },
        "size": {
          "width": 134,
          "height": 84
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_BARRIER_LOWERING",
            "fontSize": 11
          },
          "specification": {
            "text": "EV_TICK [tick > 0 && tick_blink > 0] / tick-- ; tick_blink--"
          }
        },
        "id": "34d50c41-ab1e-4fb2-b8e2-8e438db38f71",
        "z": 58,
        "embeds": [
          "c506e389-207e-4fef-9d4e-6afa250f94e6"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "def3a10c-9281-44b3-b30f-e39c363d3b99"
        },
        "target": {
          "id": "34d50c41-ab1e-4fb2-b8e2-8e438db38f71",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "50.794%",
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
                "text": "EV_ACT_CLOSE_BARRIER / tick= DEL_LOWERING ; tick_blink = DEL_FREQ_2"
              }
            },
            "position": {
              "distance": 0.38235294117647056,
              "offset": -194,
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
        "id": "1848f63e-5069-4730-8203-c5a9ca5d708d",
        "z": 60,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "34d50c41-ab1e-4fb2-b8e2-8e438db38f71"
        },
        "target": {
          "id": "9560b739-9aad-4438-a4a8-706f3dc6da52",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "9.524%",
              "dy": "43.333%",
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
                "text": "EV_TICK [tick == 0] / raise EV_LED_OFF"
              }
            },
            "position": {
              "distance": 0.5178795327026138,
              "offset": -122,
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
        "id": "65b17c52-c3ab-4e37-9ddd-8ccfeb0a620d",
        "z": 61,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 741,
            "y": 350
          },
          {
            "x": 639,
            "y": 101
          },
          {
            "x": 639,
            "y": 77
          }
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
              "dx": "53.968%",
              "dy": "8.333%",
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
                "text": "EV_TICK [tick == 0] / raise EV_LED_ON"
              }
            },
            "position": {
              "distance": 0.3673469387755102,
              "offset": -114,
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
        "z": 63,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "34d50c41-ab1e-4fb2-b8e2-8e438db38f71",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "98.507%",
              "dy": "52.381%",
              "rotate": true
            }
          },
          "priority": true
        },
        "target": {
          "id": "34d50c41-ab1e-4fb2-b8e2-8e438db38f71",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "92.857%",
              "dy": "8.333%",
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
                "text": "EV_TICK [tick_blink == 0] / raise EV_LED_TOGGLE; tick_blink = DEL_FREQ_2"
              }
            },
            "position": {
              "distance": 0.4151987596511588,
              "offset": 207,
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
        "id": "c506e389-207e-4fef-9d4e-6afa250f94e6",
        "z": 64,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 991,
            "y": 323
          },
          {
            "x": 963,
            "y": 277
          }
        ],
        "parent": "34d50c41-ab1e-4fb2-b8e2-8e438db38f71"
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
                "text": "EV_TICK [tick_blink == 0] / raise EV_LED_TOGGLE; tick_blink = DEL_FREQ_1"
              }
            },
            "position": {
              "distance": 0.4540815660353221,
              "offset": 203,
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
        "z": 65,
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
          "id": "9560b739-9aad-4438-a4a8-706f3dc6da52",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "47.619%",
              "dy": "98.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "target": {
          "id": "e360fb48-9738-468d-90ad-fc17ed7ff95e",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "50.794%",
              "dy": "15%",
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
                "text": "EV_ACT_OPEN_BARRIER / tick = DEL_RAISING ; tick_blink = DEL_FREQ_1"
              }
            },
            "position": {
              "distance": 0.43396226415094347,
              "offset": -193,
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
        "z": 66,
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
          "moduleName": "ActuatorStatechart",
          "statemachinePrefix": "actuatorStatechart",
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