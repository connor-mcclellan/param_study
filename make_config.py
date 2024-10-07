import argparse

parser = argparse.ArgumentParser()
parser.add_argument("taucell", type=float)
args = parser.parse_args()

config = f'''
SHELL=/bin/bash
HDF5PATH=-hdf5
RADIATION=-implicit_radiation
PROBLEM=wind_steadystate
NZONES=384
NLIM=-1
NCYCLE_OUT=10
CFL=0.3
DT=1e-3
TLIM=1.0
MDOT=-mdot 1e18
EDOT=-edot 1.03
TAUCELL=-taucell {args.taucell}
BASE_DENSITY=-base_dens 1000
R_INNER=-r_inner 1.01e6
R_OUTER=-r_outer 7.5e7
'''

print(config)
