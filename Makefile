PARAMNAME=absfact
PARAM := 0.1

OUTDIRS := $(foreach par,$(PARAM),$(PARAMNAME)$(par))

# Rule to generate the output directories
$(OUTDIRS):
	mkdir -p $@

# Rule to generate the config.env files in the respective output directories
implicit_results/%/config.env:
	mkdir -p $(dir $@)
	python make_config.py $(subst $(PARAMNAME), ,$*) > $@

explicit_results/%/config.env:
	mkdir -p $(dir $@)
	python make_config.py $(subst $(PARAMNAME), ,$*) --explicit > $@

implicit_results/%: implicit_results/%/config.env
	mkdir -p $@; \
	cp $^ wind/config.env; \
	pushd wind; \
	make deepclean; \
	make clean; \
	make athena; \
	make data/athinput.wind_steadystate; \
	mv data/athinput.wind_steadystate ../$@; \
	screen -dmS $(subst /,_,$@) ./athenadev/bin/athena -i ../$@/athinput.wind_steadystate -d ../$@; \
	popd

explicit_results/%: explicit_results/%/config.env
	mkdir -p $@; \
	cp $^ wind/config.env; \
	pushd wind; \
	make deepclean; \
	make clean; \
	make athena; \
	make data/athinput.wind_steadystate; \
	mv data/athinput.wind_steadystate ../$@; \
	screen -dmS $(subst /,_,$@) ./athenadev/bin/athena -i ../$@/athinput.wind_steadystate -d ../$@; \
	popd


all: $(foreach dir,$(OUTDIRS),explicit_results/$(dir)) $(foreach dir,$(OUTDIRS),implicit_results/$(dir))

clean:
	rm -rf $(foreach dir,$(OUTDIRS),explicit_results/$(dir)) $(foreach dir,$(OUTDIRS),implicit_results/$(dir))

