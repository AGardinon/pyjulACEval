# pyjulACEval

Wrapper for the evaluation of ACE descriptor in python.

## Requirements

This script is built using Packages and Functions that refer to the [ACE1pack](https://acesuit.github.io/ACE1pack.jl/dev/) distribution of ACE, to run it needs a working installation of the ACE1pack ([instructions](https://acesuit.github.io/ACE1pack.jl/dev/gettingstarted/installation/)).

## Script

...

### input.json

The `ACEval.json` file stores the input values.

    {
        "trajectory" : {
        "traj_file": path/to/myxyz,
        "index": "0:100:1"
        },

        "ace_basis" : {
            "species": ["H", "C", "O"],
            "N": 3,
            "maxdeg": 4,
            "rcut": 5.5
        },

        "evaluation" : {
            "c_atom" : "C"
        }
    }

Brief explanation of the file's sections and entries:
1. `trajectory`, contains inputs specific for the trajectory (XYZ file) handling:
    - 

### .jl version

...

### .py version
