# pyjulACEval

Wrapper for the evaluation of ACE descriptor in python.

## Requirements

This script is built using Packages and Functions that refer to the [ACE1pack](https://acesuit.github.io/ACE1pack.jl/dev/) distribution of ACE, to run it needs a working installation of the ACE1pack ([instructions](https://acesuit.github.io/ACE1pack.jl/dev/gettingstarted/installation/)).

## Script

...

### input.json

The `evACE.json` file stores the input values.

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
    - `traj_file`: XYZ file path.
    - `index`: chunk of the configuration to be read and analysed; `start:end:every`.
    
2. `ace_basis`: parameters that define the ACE basis (some parameters are set by default and can be left out from the dictionary)
    - `species`: list of all the atomic species.
    - `N`: correlation order (body-order - 1).
    - `maxdeg`: maximum polynomial degree.
    - `rcut`: radial cutoff.

_Default parameters_: `r0`, `pin`, `rin`, and `D`.

Additional, and more specific information about the ACE basis can be found in the ACE1pack implementation ([tutorial](https://acesuit.github.io/ACE1pack.jl/dev/literate_tutorials/) section).


### .jl version

The `.jl` code can be run from command line

    julia evACE_cml.jl --params evACE.json

or it can be run in the julia REPL including the `evACE.jl` script

    include("evACE.jl")
    otuput_dict = evACE("evACE.json")

The output `output_dict` will be a dictionary with 2 main keys:
- `trajInfo`: trajectory general information, atomic species index, and population.
- `aceDescr`: ACE descriptor design matrix $\[N_{conf} \times N_{atoms} \times N_{features}\]$

### .py version

The python wrapper of the julia code can be run as

    from julia.api import Julia
    jl = Julia(compiled_modules=False)
    from julia import Main

    evACEfn = Main.include("evACE.jl")
    output_dict = evACEfn("evACE.json")

