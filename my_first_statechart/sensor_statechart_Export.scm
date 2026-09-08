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
            "text": "sensor_statechart Export Export"
          },
          "specification": {
            "text": "@EventDriven\n@SuperSteps(no)\n\ninterface:\n    in event EV_BTN_PRESSED\n    in event EV_BTN_RELEASED\n    \n    in event EV_TICK\n    \n    out event EV_SYS_BTN_DOWN\n    out event EV_SYS_BTN_UP\n\n\n    var tick : integer = 0\n    const DEL_BTN_DEBOUNCE : integer = 30"
          }
        },
        "z": 1
      },
      {
        "position": {
          "x": 479,
          "y": 69
        },
        "size": {
          "height": 60,
          "width": 120
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_BTN_UP",
            "fontSize": 11
          }
        },
        "id": "72c83039-65e4-4e74-841f-7e585b3c56eb",
        "z": 2
      },
      {
        "position": {
          "x": 912,
          "y": 69
        },
        "size": {
          "height": 60,
          "width": 140
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_BTN_FALLING",
            "fontSize": 11
          },
          "specification": {
            "text": "EV_TICK [tick > 0] / tick--"
          }
        },
        "id": "724e43e1-d5d3-4fc6-8f69-41f87752d5ab",
        "z": 3
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "724e43e1-d5d3-4fc6-8f69-41f87752d5ab"
        },
        "target": {
          "id": "72c83039-65e4-4e74-841f-7e585b3c56eb",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "96.667%",
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
                "text": "EV_BTN_RELEASED"
              }
            },
            "position": {
              "distance": 0.5319488817891374,
              "offset": 11,
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
        "id": "2f878218-606b-4986-bbd2-f1d1ed9aabf5",
        "z": 13,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "72c83039-65e4-4e74-841f-7e585b3c56eb"
        },
        "target": {
          "id": "724e43e1-d5d3-4fc6-8f69-41f87752d5ab",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "5%",
              "dy": "85%",
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
                "text": "EV_BTN_PRESSED / tick = DEL_BTN_DEBOUNCE"
              }
            },
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
        "id": "c7bc4257-7302-4cf4-ac72-d86d07c6e9f9",
        "z": 14,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "position": {
          "x": 476,
          "y": 311
        },
        "size": {
          "height": 69,
          "width": 115
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_BTN_RISING",
            "fontSize": 11
          },
          "specification": {
            "text": "EV_TICK [tick > 0] / tick--"
          }
        },
        "id": "e3e27f34-74d6-44b0-b222-3cacfe179811",
        "z": 15
      },
      {
        "position": {
          "x": 907,
          "y": 320
        },
        "size": {
          "height": 60,
          "width": 140
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_BTN_DOWN",
            "fontSize": 11
          }
        },
        "id": "3ffcaf6e-ee53-4ee2-b6f5-e5c256c09966",
        "z": 16
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "3ffcaf6e-ee53-4ee2-b6f5-e5c256c09966"
        },
        "target": {
          "id": "e3e27f34-74d6-44b0-b222-3cacfe179811",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "96.667%",
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
                "text": "EV_BTN_RELEASED / tick = DEL_BTN_DEBOUNCE"
              }
            },
            "position": {
              "distance": 0.5319488817891374,
              "offset": 11,
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
        "id": "e9e07ee9-1774-4eef-8ed0-6ce35438667f",
        "z": 17,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "e3e27f34-74d6-44b0-b222-3cacfe179811"
        },
        "target": {
          "id": "3ffcaf6e-ee53-4ee2-b6f5-e5c256c09966",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "5%",
              "dy": "85%",
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
                "text": "EV_BTN_PRESSED"
              }
            },
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
        "id": "d8a08bc5-ebf6-4289-b0e6-7f739fee3a99",
        "z": 18,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "e3e27f34-74d6-44b0-b222-3cacfe179811"
        },
        "target": {
          "id": "72c83039-65e4-4e74-841f-7e585b3c56eb",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "35%",
              "dy": "85%",
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
                "text": "EV_TICK [tick == 0] / raise EV_SYS_BTN_UP"
              }
            },
            "position": {
              "distance": 0.6047120418848168,
              "offset": -115,
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
        "id": "86db6296-3aad-4cfc-a150-b575cf7aae93",
        "z": 19,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "724e43e1-d5d3-4fc6-8f69-41f87752d5ab"
        },
        "target": {
          "id": "3ffcaf6e-ee53-4ee2-b6f5-e5c256c09966",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "55%",
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
                "text": "EV_TICK [tick == 0] / raise EV_SYS_BTN_DOWN"
              }
            },
            "position": {
              "distance": 0.39528795811518325,
              "offset": -135,
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
        "id": "e5c02a64-b20b-40ca-bd6d-2c45065647d8",
        "z": 20,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "position": {
          "x": 361,
          "y": 93
        },
        "size": {
          "height": 18,
          "width": 18
        },
        "type": "Entry",
        "entryKind": "Initial",
        "attrs": {},
        "id": "8923b390-1a77-4d5c-bae9-bfba28bf3e46",
        "z": 27,
        "embeds": [
          "430105bb-b64f-4e57-8ed4-6156fe7e2405"
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
          "x": 361,
          "y": 108
        },
        "attrs": {
          "label": {
            "refX": "50%",
            "textAnchor": "middle",
            "refY": "50%",
            "textVerticalAnchor": "middle"
          }
        },
        "id": "430105bb-b64f-4e57-8ed4-6156fe7e2405",
        "z": 28,
        "parent": "8923b390-1a77-4d5c-bae9-bfba28bf3e46"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "8923b390-1a77-4d5c-bae9-bfba28bf3e46"
        },
        "target": {
          "id": "72c83039-65e4-4e74-841f-7e585b3c56eb",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "3.333%",
              "dy": "53.333%",
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
        "id": "c7c1ef51-cf2c-433f-a48a-889f0c04d853",
        "z": 29,
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