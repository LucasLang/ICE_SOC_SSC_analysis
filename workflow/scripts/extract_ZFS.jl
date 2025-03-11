using OutputParser
using DelimitedFiles

ORCAfile = ARGS[1]
settings = ARGS[2]
outfile = ARGS[3]

if settings == "SOC"
    searchstring1 = "QDPT with ONLY SOC"
elseif settings == "SOCSSC"
    searchstring1 = "QDPT with SOC AND SSC"
else
    error("The only possible settings are 'SOC' and 'SOCSSC'!")
end

values = [parse_float(ORCAfile, [searchstring1, "STATE   $state"], 0, 2) for state in 0:2]

average = (values[2]+values[3])/2
splitting = average-values[1]
splitting_rounded = round(splitting, digits = 3)

writedlm(outfile, splitting_rounded)