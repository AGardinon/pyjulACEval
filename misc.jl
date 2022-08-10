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

# ----------------------------------------------------