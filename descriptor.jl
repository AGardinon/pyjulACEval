
# ----------------------------------------------------
#
#       Descriptor.jl
#
# ----------------------------------------------------

using ACE1pack


# ----------------------------------------------------
# --- GENERATING THE BASE

# --- Build the ace basis from a dictionary
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

# --- String to Symbol
# - taken from ACE1pack routine
_params_to_species(species::Union{AbstractArray{T}, Tuple{T, T}}) where T <: AbstractString  = 
      Symbol.(species)

_params_to_species(dict::Dict{Tuple{Tsym, Tsym}, Tval}) where Tsym <: AbstractString where Tval <: Any = 
      Dict(Tuple(_params_to_species(d)) => val for (d, val) in dict)

_params_to_species(dict::Nothing) = nothing

# ----------------------------------------------------

# ----------------------------------------------------
# --- EVALUATION OF THE BASIS 

# --- basis evaluation

function ACEdescriptor(basis, at_config, sites)
    return [ACE1pack.JuLIP.site_energy(basis, at_config, idx) for idx in sites]
end

# ----------------------------------------------------

