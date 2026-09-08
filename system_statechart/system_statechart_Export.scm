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
            "text": "system_statechart Export"
          },
          "specification": {
            "text": "namespace system_statechart\r\n\r\ninterface:\r\n    in event EV_SYS_CAR_DETECTED\r\n    in event EV_SYS_BTN_DOWN\r\n    \r\n    in event EV_TICK\r\n    \r\n    out event EV_ACT_WELCOME\r\n    out event EV_ACT_PRINT_START\r\n    out event EV_ACT_BARRIER_UP\r\n    out event EV_ACT_BARRIER_DOWN\r\n\r\n    var tick : integer = 0\r\n    const DEL_BARRIER_TIMEOUT : integer = 5000"
          }
        },
        "z": 1
      },
      {
        "position": {
          "x": 54,
          "y": 0
        },
        "size": {
          "height": 60,
          "width": 198
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_IDLE",
            "fontSize": 11
          }
        },
        "id": "4df4b5af-7208-47ef-a797-1ba2ed0eba0f",
        "z": 2
      },
      {
        "position": {
          "x": 54,
          "y": 144
        },
        "size": {
          "height": 60,
          "width": 198
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_WAIT_FOR_BUTTON",
            "fontSize": 11
          }
        },
        "id": "45bdc2b4-2477-4f56-a49c-919cf173803c",
        "z": 3
      },
      {
        "position": {
          "x": 54,
          "y": 288
        },
        "size": {
          "height": 60,
          "width": 198
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_TICKET_PROCESSING",
            "fontSize": 11
          }
        },
        "id": "968a6b03-b33a-41be-bd98-bcec101235bf",
        "z": 4
      },
      {
        "position": {
          "x": 54,
          "y": 432
        },
        "size": {
          "height": 60,
          "width": 198
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_SYS_BARRIER_OPEN",
            "fontSize": 11
          },
          "specification": {
            "text": "EV_TICK [tick > 0] / tick--"
          }
        },
        "id": "2bc17c00-20a3-4e28-9756-68d23a0eb37c",
        "z": 5
      },
      {
        "position": {
          "x": 144,
          "y": -72
        },
        "size": {
          "height": 18,
          "width": 18
        },
        "type": "Entry",
        "entryKind": "Initial",
        "attrs": {},
        "id": "9eb38753-c17d-4d69-a750-dd0c6281c151",
        "z": 6,
        "embeds": [
          "cca8c8ed-f807-475c-bad7-9947ab58d3ce"
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
          "x": 144,
          "y": -57
        },
        "attrs": {
          "label": {
            "refX": "50%",
            "textAnchor": "middle",
            "refY": "50%",
            "textVerticalAnchor": "middle"
          }
        },
        "id": "cca8c8ed-f807-475c-bad7-9947ab58d3ce",
        "z": 7,
        "parent": "9eb38753-c17d-4d69-a750-dd0c6281c151"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "9eb38753-c17d-4d69-a750-dd0c6281c151"
        },
        "target": {
          "id": "4df4b5af-7208-47ef-a797-1ba2ed0eba0f",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "50%",
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
        "id": "7e4c35cf-878c-4c89-bbc8-7778a5e6b700",
        "z": 8,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "4df4b5af-7208-47ef-a797-1ba2ed0eba0f"
        },
        "target": {
          "id": "45bdc2b4-2477-4f56-a49c-919cf173803c",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "50.505%",
              "dy": "31.667%",
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
                "text": "EV_SYS_CAR_DETECTED / raise EV_ACT_WELCOME"
              }
            },
            "position": {
              "distance": 0.4880952380952381,
              "offset": -125,
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
        "id": "889748c5-bdc4-42b4-b192-ea68628b15a8",
        "z": 9,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "45bdc2b4-2477-4f56-a49c-919cf173803c"
        },
        "target": {
          "id": "968a6b03-b33a-41be-bd98-bcec101235bf",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "50.505%",
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
                "text": "EV_SYS_BTN_DOWN / raise EV_ACT_PRINT_START"
              }
            },
            "position": {
              "distance": 0.42857142857142855,
              "offset": -128,
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
        "id": "56989e5f-14f6-4fd0-9a48-264f2a2a40e7",
        "z": 10,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "968a6b03-b33a-41be-bd98-bcec101235bf"
        },
        "target": {
          "id": "2bc17c00-20a3-4e28-9756-68d23a0eb37c",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "51.01%",
              "dy": "20%",
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
                "text": "EV_TICK / raise EV_ACT_BARRIER_UP; tick = DEL_BARRIER_TIMEOUT"
              }
            },
            "position": {
              "distance": 0.4880952380952381,
              "offset": -177,
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
        "id": "6a942c4f-021b-45ea-8e6d-b3662d39d085",
        "z": 11,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "2bc17c00-20a3-4e28-9756-68d23a0eb37c"
        },
        "target": {
          "id": "4df4b5af-7208-47ef-a797-1ba2ed0eba0f",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "100%",
              "dy": "46.667%",
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
                "text": "EV_TICK [tick == 0] / raise EV_ACT_BARRIER_DOWN"
              }
            },
            "position": {
              "distance": 0.4990570141052823,
              "offset": 134,
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
        "id": "3d0d9296-22a8-478e-90bd-467048f66058",
        "z": 12,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 565,
            "y": 470
          }
        ]
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