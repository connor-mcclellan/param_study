TAUCELL := 1e0 1e-1 1e-2 1e-3

OUTDIRS := $(foreach tc,$(TAUCELL),taucell$(tc))

# Rule to generate the output directories
$(OUTDIRS):
	mkdir -p $@

# Rule to generate the config.env files in the respective output directories
results/%/config.env:
	mkdir -p $(dir $@)
	python make_config.py $(subst taucell, ,$*) > $@


results/%: results/%/config.env
	mkdir -p $@; \
	cp $^ wind/config.env; \
	pushd wind; \
	make clean; \
	make data/athinput.wind_steadystate; \
	mv data/athinput.wind_steadystate ../$@; \
	screen -dm ./athenadev/bin/athena -i ../$@/athinput.wind_steadystate -d ../$@; \
	popd


all: $(foreach dir,$(OUTDIRS),results/$(dir))

clean:
	rm -rf $(foreach dir,$(OUTDIRS),results/$(dir))

