using OutputParser
using DelimitedFiles

ORCAfile = ARGS[1]
method = ARGS[2]
outfile = ARGS[3]

values = [parse_float(ORCAfile, ["QDPT WITH $method DIAGONAL ENERGIES", "KRAMERS PAIR", "g-factors"], 1, word) for word in 0:2]
values_rounded = [round(value, digits=2) for value in values]

writedlm(outfile, values_rounded)