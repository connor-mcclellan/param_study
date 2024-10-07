#MDOT := 1e17 5e17 1e18 5e18 1e19
#DENS := 75 100 150 200 500 1000

MDOT := 1e18
DENS := 100 1000

OUTDIRS := $(foreach md,$(MDOT),$(foreach de,$(DENS),mdot$(md)_dens$(de)))

# Rule to generate the output directories
$(OUTDIRS):
	mkdir -p $@

# Rule to generate the config.env files in the respective output directories
results/%/config.env:
	mkdir -p $(dir $@)
	python make_config.py $(subst mdot,,$(subst _dens, ,$*)) > $@


results/%/data: results/%/config.env
	mkdir -p $@; \
	cp $^ wind/config.env; \
	pushd wind; \
	make clean; \
	make data/athinput.wind_steadystate; \
	mv data/athinput.wind_steadystate ../$@; \
	screen -dm ./athenadev/bin/athena -i ../$@/athinput.wind_steadystate -d ../$@; \
	popd


all: $(foreach dir,$(OUTDIRS),results/$(dir)/data)



clean:
	rm -rf $(foreach dir,$(OUTDIRS),results/$(dir))

