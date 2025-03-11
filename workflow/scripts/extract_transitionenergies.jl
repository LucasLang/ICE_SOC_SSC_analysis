using OutputParser
using DelimitedFiles

ORCAfile = ARGS[1]
outfolder = ARGS[2]

Nexc = 8   # number of excited states

transition_energies = [0.0]   # ground state has transition energy 0 by definition
for line in 1:Nexc
    val = parse_float(ORCAfile, ["TRANSITION", "STATE"], line, 4)
    push!(transition_energies, val)
end

println(transition_energies)

writedlm("$outfolder/ICE_transition_energies", transition_energies)