import matplotlib.pyplot as plt
import numpy as np
from scipy.interpolate import UnivariateSpline
import sys

expfolder = sys.argv[1]
transitionenergy_file = sys.argv[2]
outfolder = sys.argv[3]

data_X = np.loadtxt(f"{expfolder}/data_X.csv", delimiter=",")
GS_min = np.min(data_X[:,1])     # this is the lowest energy found in data_X
ICE_E = np.loadtxt(transitionenergy_file) + GS_min        # align the two energy scales
r_min = 1.2058   # the O-O distance I used in the calculations


spline_X = UnivariateSpline(data_X[:,0], data_X[:,1], s=0.005)
spline_X_v = np.vectorize(lambda x : spline_X(x))
grid_X = np.linspace(data_X[0,0], data_X[-1,0], 200)
values_X = spline_X_v(grid_X)

data_a = np.loadtxt(f"{expfolder}/data_a.csv", delimiter=",")
spline_a = UnivariateSpline(data_a[:,0], data_a[:,1], s=0.005)
spline_a_v = np.vectorize(lambda x : spline_a(x))
grid_a = np.linspace(data_a[0,0], data_a[-1,0], 200)
values_a = spline_a_v(grid_a)

data_b = np.loadtxt(f"{expfolder}/data_b.csv", delimiter=",")
spline_b = UnivariateSpline(data_b[:,0], data_b[:,1], s=0.005)
spline_b_v = np.vectorize(lambda x : spline_b(x))
grid_b = np.linspace(data_b[0,0], data_b[-1,0], 200)
values_b = spline_b_v(grid_b)

data_c = np.loadtxt(f"{expfolder}/data_c.csv", delimiter=",")
spline_c = UnivariateSpline(data_c[:,0], data_c[:,1], s=0.005)
spline_c_v = np.vectorize(lambda x : spline_c(x))
grid_c = np.linspace(data_c[0,0], data_c[-1,0], 200)
values_c = spline_c_v(grid_c)

data_C = np.loadtxt(f"{expfolder}/data_C.csv", delimiter=",")
spline_C = UnivariateSpline(data_C[:,0], data_C[:,1], s=0.005)
spline_C_v = np.vectorize(lambda x : spline_C(x))
grid_C = np.linspace(data_C[0,0], data_C[-1,0], 200)
values_C = spline_C_v(grid_C)

data_A = np.loadtxt(f"{expfolder}/data_A.csv", delimiter=",")
spline_A = UnivariateSpline(data_A[:,0], data_A[:,1], s=0.005)
spline_A_v = np.vectorize(lambda x : spline_A(x))
grid_A = np.linspace(data_A[0,0], data_A[-1,0], 200)
values_A = spline_A_v(grid_A)

data_B = np.loadtxt(f"{expfolder}/data_B.csv", delimiter=",")
spline_B = UnivariateSpline(data_B[:,0], data_B[:,1], s=0.005)
spline_B_v = np.vectorize(lambda x : spline_B(x))
grid_B = np.linspace(data_B[0,0], data_B[-1,0], 200)
values_B = spline_B_v(grid_B)

plt.figure(figsize=(4,3))

plt.plot(grid_X, values_X, color="tab:blue", label='Experimental')
plt.plot(grid_a, values_a, color="tab:blue")
plt.plot(grid_b, values_b, color="tab:blue")
plt.plot(grid_c, values_c, color="tab:blue")
plt.plot(grid_C, values_C, color="tab:blue")
plt.plot(grid_A, values_A, color="tab:blue")
plt.plot(grid_B, values_B, color="tab:blue")
plt.plot([r_min, r_min, r_min, r_min, r_min, r_min, r_min],
         [ICE_E[0], 0.5*(ICE_E[1]+ICE_E[2]), ICE_E[3], ICE_E[4], 0.5*(ICE_E[5]+ICE_E[6]), ICE_E[7], ICE_E[8]], marker = "o", color = "tab:orange", lw=0, markeredgecolor='black', label = 'Calculated')
plt.xlim(1,2.5)
plt.xlabel('Internuclear distance / \u212b')
plt.ylabel('Energy / eV')
plt.subplots_adjust(bottom=0.15)
plt.legend()
plt.savefig(f"{outfolder}/PES.png", dpi=300)
