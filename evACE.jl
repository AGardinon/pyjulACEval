# --------------------------------------

include("descriptor.jl")
include("trajectory.jl")
include("misc.jl")

# --------------------------------------
#
#   evACE.jl
#
# --------------------------------------

function evACE(input::String)
    # -> input dict
    input_dict = parse_dict(input)
    # -> init the ACE basis
    ace_basis = dict_to_ace_basis(input_dict)
    # -> handling the traj
    traj_db, at_info_dict = loadTraj(; input_dict[:trajectory]...)
    # -> compute the ACE descriptor
    ace_descr = ACEdescriptor(; traj_db=traj_db, basis=ace_basis, 
                                atom_c=input_dict[:evaluation][:c_atom], 
                                at_idx_dict=at_info_dict)

    return Dict(:trajInfo => at_info_dict, :aceDescr => ace_descr)
end

# -- end