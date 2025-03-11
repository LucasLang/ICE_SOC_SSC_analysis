using OutputParser
using DelimitedFiles

ORCAfile = ARGS[1]
outfile = ARGS[2]

values = [parse_float(ORCAfile, ["KRAMERS PAIR", "g-factors"], 1, word) for word in 0:2]
values_rounded = [round(value, digits=2) for value in values]

writedlm(outfile, values_rounded)