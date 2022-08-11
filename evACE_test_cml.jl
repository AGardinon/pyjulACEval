#!

using ArgParse

include("descriptor.jl")
include("trajectory.jl")
include("misc.jl")

parser = ArgParseSettings(description="Evaluate the ACE basis.")
@add_arg_table parser begin
    "--params", "-p"
        help = "A JSON dict file with the paramters for the evaluation."
end

# --------------------------------------
#
#   MAIN
#
# --------------------------------------

# -- input dict
input_dict = parse_dict(parse_args(parser)["params"])

# -- init the ACE basis
ace_basis = dict_to_ace_basis(input_dict)
println(length(ace_basis))

# -- handle the traj
traj_db, at_info_dict = loadTraj(; input_dict[:trajectory]...)
println(at_info_dict[:pop])

# -- compute the ACE descriptor
ace_descr = ACEdescriptor(; traj_db=traj_db, basis=ace_basis, 
                            atom_c=input_dict[:evaluation][:c_atom], 
                            at_idx_dict=at_info_dict)

println(typeof(ace_descr))