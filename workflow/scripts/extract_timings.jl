using OutputParser
using DelimitedFiles
using Statistics

ORCAfile = ARGS[1]
sigmafile = ARGS[2]
RMEfile = ARGS[3]

Niter = Dict(3 => (4,6), 1 => (5,6))    # number of macro and microiterations for each multiplicity
open(sigmafile, "w") do io
    write(io, "# MULT NCSF T(sigma)/h\n")  # comment line
    for mult in [3,1]
        Nmacro = Niter[mult][1]
        Nmicro = Niter[mult][2]
        NCSF = parse_int(ORCAfile, ["CAS-SCF ITERATIONS", "MULT= $mult", "ICECI/CSF MACROITERATION   $Nmacro", "selected CSFs"], 0, 5)
        T_sigma = [parse_float(ORCAfile, ["CAS-SCF ITERATIONS", "MULT= $mult", "ICECI/CSF MACROITERATION   $Nmacro", "Iteration    $micro"], 1, 1) for micro in 0:(Nmicro-1)]
        T_sigma_mean_h = mean(T_sigma)/3600
        T_sigma_mean_h_rounded = round(T_sigma_mean_h, digits=1)
        write(io, "$mult $NCSF $T_sigma_mean_h_rounded\n")
    end
end

open(RMEfile, "w") do io
    write(io, "# Time for calculation of SOC and SSC RMEs\n")  # comment line
    T_SOC_h = parse_float(ORCAfile, ["CASSCF TIMINGS", "SOC RMEs"], 0, 3)/3600
    T_SOC_h_rounded = round(T_SOC_h, digits=1)
    write(io, "$T_SOC_h_rounded\n")
    T_SSC_h = parse_float(ORCAfile, ["CASSCF TIMINGS", "SSC RMEs"], 0, 5)/3600
    T_SSC_h_rounded = round(T_SSC_h, digits=1)
    write(io, "$T_SSC_h_rounded\n")
end