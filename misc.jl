# ----------------------------------------------------
#
#       Misc.jl
#
# ----------------------------------------------------

using JSON

# ----------------------------------------------------
# --- MISC 

# --- ordered elements dictionary
elements_dict = JSON.parsefile("asedata.json")

# --- parse dict and turn keys into symbols
function parse_dict(s::String)
    d = JSON.parsefile(s)
    symbol_dict(x) = x
    symbol_dict(d::Dict) = Dict(Symbol(k) => symbol_dict(v) for (k, v) in d)
    return symbol_dict(d)
end

# --- dict key String to Symbol
# - taken from ACE1pack routine
_params_to_species(species::Union{AbstractArray{T}, Tuple{T, T}}) where T <: AbstractString  = 
      Symbol.(species)

_params_to_species(dict::Dict{Tuple{Tsym, Tsym}, Tval}) where Tsym <: AbstractString where Tval <: Any = 
      Dict(Tuple(_params_to_species(d)) => val for (d, val) in dict)

_params_to_species(dict::Nothing) = nothing
# ----------------------------------------------------