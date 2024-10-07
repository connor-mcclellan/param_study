import argparse

parser = argparse.ArgumentParser()
parser.add_argument("mdot", type=float)
parser.add_argument("base_dens", type=float)
args = parser.parse_args()

config = f'''
SHELL=/bin/bash
HDF5PATH=-hdf5
RADIATION=-nr_radiation
PROBLEM=wind_steadystate
NZONES=384
NLIM=-1
NCYCLE_OUT=10
CFL=0.7
DT=1e-3
TLIM=0.15
MDOT=-mdot {args.mdot}
EDOT=-edot 1.03
BASE_DENSITY=-base_dens {args.base_dens}
R_INNER=-r_inner 1.01e6
R_OUTER=-r_outer 7.5e7
'''

print(config)
