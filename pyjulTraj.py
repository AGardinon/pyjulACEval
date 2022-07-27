#!
import os
import numpy as np

# >>> Julia stuff
from julia.api import Julia
jl = Julia(compiled_modules=False)

from julia import Main, Pkg

# > Project activation
pkgPath = os.path.realpath(__file__)
Pkg.activate(pkgPath)

from julia import IPFitting

# >>> Input
file_name = "traj_2.1_0-100-1.xyz"
index = "0:10:1"

