
# ----------------------------------------------------
#
#       Trajectory.jl
#
# ----------------------------------------------------

using IPFitting, StatsBase
# include usefull stuff
include("misc.jl")

# ----------------------------------------------------
# --- TRAJ HANDLER

# --- Traj reader from dict
function loadTraj(; traj_file, index)
    # init
    at_info_dict = _traj_init(; traj_file=traj_file, get_info=true)
    # read and store
    traj_db = read_xyz(; traj_file=traj_file, index=index)
    return traj_db, at_info_dict
end


function read_xyz(; traj_file, index)
    return IPFitting.Data.read_xyz(
                traj_file, 
                index=index, 
                energy_key="", 
                force_key="", 
                virial_key="", 
                verbose=false
                )
end


# --- just read the first frame 
# may be usefull to get information out of it
function _traj_init(; traj_file, get_info=true)
    at_conf = read_xyz(; traj_file, index=":1")
    if get_info
        at_pop_dict = _get_at_pop(; at_conf=at_conf)
        at_idx_dict = _get_at_idx(; at_conf=at_conf)
        return Dict(:pop => at_pop_dict, :idx => at_idx_dict)
    else
        return nothing
    end
end


function  _get_at_pop(; at_conf)
    # get atZ (it needs conversion from bs chemistry to Int)
    atZ = [convert(Int, Z) for Z in at_conf[1].at.Z]
    # get the sorted count of all the species
    atZ_counts = countmap(atZ)
    # get the numbers of atoms
    at_pop_dict = Dict{String,Int64}()
    for (z,c) in zip(keys(atZ_counts), values(atZ_counts))
        at_pop_dict[elements_dict["symbols"][z]] = c
    end
    return at_pop_dict
end


function _get_at_idx(; at_conf)
    # get atZ (it needs conversion from bs chemistry to Int)
    atZ = [convert(Int, Z) for Z in at_conf[1].at.Z]
    # get the sorted count of all the species
    atZ_counts = countmap(atZ)
    # get the idx of atoms
    at_idx_dict = Dict{String,Vector{Int64}}()
    for z in unique(sort(atZ))
        z_str = elements_dict["symbols"][z]
        at_idx_dict[z_str] = findall(x->x==z, at_conf[1].at.Z)
    end
    return at_idx_dict
end

# ----------------------------------------------------