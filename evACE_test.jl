#!

using JSON, ACE1pack

# --- Input params
input_dict = JSON.parsefile("evACE.json")

# --- ACE basis init

# - modules ?
# -- String to Symbol
_params_to_species(species::Union{AbstractArray{T}, Tuple{T, T}}) where T <: AbstractString  = 
      Symbol.(species)

_params_to_species(dict::Dict{Tuple{Tsym, Tsym}, Tval}) where Tsym <: AbstractString where Tval <: Any = 
      Dict(Tuple(_params_to_species(d)) => val for (d, val) in dict)

_params_to_species(dict::Nothing) = nothing


# -- Build the ace basis (rpi or ace ??)
function dict_to_ace_basis(a::Dict)
    # species
    a["species"] = convert(Vector{String}, a["species"])
    species = _params_to_species(a["species"])
    # body order
    N = a["N"]
    # max poly degree
    maxdeg = a["maxdeg"]
    # rcut
    rcut = a["rcut"]

    # -- Default paramters
    r0 = get!(input_dict["ace_basis"], "r0", 0.5)
    pin = get!(input_dict["ace_basis"], "pin", 2)

    # -- Hidden parameters
    # degree - set as default as initial setp
    _rin = 0.1
    _D = SparsePSHDegree(; wL=1.5, csp=1.0)

    return ACE1pack.ACE1.Utils.rpi_basis(;
            species = species,
            N = N,
            maxdeg = maxdeg,
            D = _D,
            rcut = rcut, r0 = r0, rin = _rin,
            pin = pin
            )
end
# - modules ?

ace_basis = dict_to_ace_basis(input_dict["ace_basis"])
println(length(ace_basis))


# --- Traj reading

# - modules ?
function read_xyz(t::Dict)
    traj_file = t["traj_file"]
    index = t["index"]
    return ACE1pack.IPFitting.Data.read_xyz(
                traj_file, 
                index=index, 
                energy_key="", 
                force_key="", 
                virial_key="", 
                verbose=false
                )
end
# - modules ?

traj = read_xyz(input_dict["trajectory"])
println(length(traj))