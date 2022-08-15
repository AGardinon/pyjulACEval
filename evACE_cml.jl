# --------------------------------------

using ArgParse
include("evACE.jl")

# --------------------------------------

parser = ArgParseSettings(description="Evaluate the ACE basis.")
@add_arg_table parser begin
    "--params", "-p"
        help = "A JSON dict file with the paramters for the evaluation."
end

# --------------------------------------
#
#   COMMAND LINE SCRIPT
#
# --------------------------------------

output_dict = evACE(parse_args(parser)["params"])
println(typeof(output_dict[:aceDescr]))

# -- end