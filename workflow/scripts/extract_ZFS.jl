using OutputParser
using DelimitedFiles

ORCAfile = ARGS[1]
energysettings = ARGS[2]
spinopsettings = ARGS[3]
outfile = ARGS[4]

if energysettings == "CASSCF" && spinopsettings == "SOC"
    searchstrings = ["QDPT WITH CASSCF DIAGONAL ENERGIES", "QDPT with ONLY SOC"]
elseif energysettings == "NEVPT2" && spinopsettings == "SOC"
    searchstrings = ["QDPT WITH NEVPT2 DIAGONAL ENERGIES", "QDPT with ONLY SOC"]
elseif energysettings == "CASSCF" && spinopsettings == "SOCSSC"
    searchstrings = ["THIS TIME INCLUDING SSC", "QDPT with SOC AND SSC"]
elseif energysettings == "NEVPT2" && spinopsettings == "SOCSSC"
    searchstrings = ["THIS TIME INCLUDING SSC", "QDPT WITH NEVPT2 DIAGONAL ENERGIES", "QDPT with SOC AND SSC"]
else
    error("The only possible methods for diagonal energies are 'CASSCF' and 'NEVPT2' and the only possible spin operator settings are 'SOC' and 'SOCSSC'!")
end

values = [parse_float(ORCAfile, [searchstrings..., "STATE   $state"], 0, 2) for state in 0:2]

average = (values[2]+values[3])/2
splitting = average-values[1]
splitting_rounded = round(splitting, digits = 3)

writedlm(outfile, splitting_rounded)
