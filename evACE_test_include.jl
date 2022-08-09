#!

using ArgParse

include("descriptor.jl")
include("trajectory.jl")

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
input_dict = load_dict(parse_args(parser)["params"])

# -- init the ACE basis
ace_basis = dict_to_ace_basis(input_dict["ace_basis"])
println(length(ace_basis))