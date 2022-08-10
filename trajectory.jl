
# ----------------------------------------------------
#
#       Trajectory.jl
#
# ----------------------------------------------------

using IPFitting

# ----------------------------------------------------
# --- TRAJ HANDLER

# --- Traj reader from dict
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
function _traj_init(; a)
    return nothing
end

# ----------------------------------------------------