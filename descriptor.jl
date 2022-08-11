
# ----------------------------------------------------
#
#       Descriptor.jl
#
# ----------------------------------------------------

using ACE1, JuLIP
# include traj stuff
include("trajectory.jl")
# include usefull stuff
include("misc.jl")

# ----------------------------------------------------
# --- GENERATING THE BASE

# --- Build the ace basis from a dictionary
# function _dict_to_ace_basis_OLD(a::Dict)
#     # species
#     a["species"] = convert(Vector{String}, a["species"])
#     species = _params_to_species(a["species"])
#     # body order
#     N = a["N"]
#     # max poly degree
#     maxdeg = a["maxdeg"]
#     # rcut
#     rcut = a["rcut"]

#     # -- Default paramters
#     r0 = get!(input_dict["ace_basis"], "r0", 0.5)
#     pin = get!(input_dict["ace_basis"], "pin", 2)

#     # -- Hidden parameters
#     # degree - set as default as initial setp
#     _rin = 0.1
#     _D = SparsePSHDegree(; wL=1.5, csp=1.0)

#     return ACE1pack.ACE1.Utils.rpi_basis(;
#             species = species,
#             N = N,
#             maxdeg = maxdeg,
#             D = _D,
#             rcut = rcut, r0 = r0, rin = _rin,
#             pin = pin
#             )
# end

# --- Build the ace basis from a dictionary
function dict_to_ace_basis(input::Dict)
    # select right dict
    a = input[:ace_basis]
    # little conversion
    a[:species] = convert(Vector{String}, a[:species])

    # -- Default paramters
    r0 = get!(a, :r0, 0.5)
    pin = get!(a, :pin, 2)
    rin = get!(a, :rin, 0.1)
    D = SparsePSHDegree(; wL=1.5, csp=1.0)

    return ACE1.Utils.rpi_basis(;
            species = _params_to_species(a[:species]),
            N = a[:N],
            maxdeg = a[:maxdeg],
            D = D,
            rcut = a[:rcut], 
            r0 = r0, rin = rin,
            pin = pin
            )
end

# ----------------------------------------------------

# ----------------------------------------------------
# --- EVALUATION OF THE BASIS

# --- basis evaluation

function ACEdescriptor(; traj_db, basis, atom_c, at_idx_dict)
    eval_sites = at_idx_dict[:idx][atom_c]
    return [[ JuLIP.site_energy(basis, at_conf.at, site) 
            for site in eval_sites] 
            for at_conf in traj_db]
end

# ----------------------------------------------------

