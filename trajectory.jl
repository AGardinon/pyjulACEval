
# --------------------------------------
#
#       Trajectory.jl
#
# --------------------------------------

using ACE1pack

# ----------------------------------------------------
# --- TRAJ HANDLER

# --- Traj reader from dict
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

# --- just read the first frame 
# may be usefull to get information out of it
function _traj_init(t::Dict)
    t["index"] = ":1"
    return read_xyz(t)
end

# ----------------------------------------------------


# ----------------------------------------------------
# --- MISC 

# --- ordered elements dictionary
elements_dict = load_dict("asedata.json")

# ----------------------------------------------------