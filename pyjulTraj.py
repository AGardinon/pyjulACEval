#!
import os
import numpy as np

# >>> Julia stuff
from julia.api import Julia
jl = Julia(compiled_modules=False)

from julia import Main, IPFitting #, Pkg

# > Project activation >> solved by changing the Julia project $PATH
#pkgPath = os.path.realpath(__file__)
#Pkg.activate(pkgPath)

# >>> Input
file_name = "examples/traj_2.1_0-100-1.xyz"
index = "0:10:1"

# >>> Main

# > Traj init
db = IPFitting.Data.read_xyz(file_name, verbose=False, index=":1",
energy_key="", force_key="", virial_key="")

