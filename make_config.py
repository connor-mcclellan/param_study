import argparse

parser = argparse.ArgumentParser()
parser.add_argument("absfact", type=float)
parser.add_argument("--explicit", action="store_true", default=False)
args = parser.parse_args()

rad = "-nr_radiation" if args.explicit else "-implicit_radiation"

config = f'''
SHELL=/bin/bash
HDF5PATH=-hdf5
RADIATION={rad}
PROBLEM=wind_steadystate
NZONES=384
NLIM=-1
NCYCLE_OUT=10
CFL=0.3
DT=1e-3
TLIM=1.0
MDOT=-mdot 1e18
EDOT=-edot 1.03
TAUCELL=-taucell 5.0
ABSFACT=-absfact {args.absfact}
BASE_DENSITY=-base_dens 1000
R_INNER=-r_inner 1.01e6
R_OUTER=-r_outer 7.5e7
'''

print(config)
