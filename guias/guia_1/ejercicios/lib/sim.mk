VERILATOR ?= verilator
BUILD_DIR ?= obj_dir
PRE_SRCS ?=
FST_FILE ?= $(BUILD_DIR)/sim.vcd

.DEFAULT_GOAL := sim
.PHONY: deps sim wave clean

deps:
	@set -eu; $(foreach src,$(PRE_SRCS),cp -f "$(src)" .;) :

sim: deps
	@set -eu; \
	build=$$(mktemp -d /tmp/sd-sim.XXXXXX); \
	trap 'rm -rf "$$build"' EXIT HUP INT TERM; \
	$(foreach src,$(SRCS),cp "$(src)" "$$build/";) \
	cp "$(LIB)/sim_top.sv" "$(LIB)/tb_helpers.svh" "$$build/"; \
	mkdir -p "$(BUILD_DIR)"; \
	(cd "$$build" && "$(VERILATOR)" --binary --timing --trace -j 2 \
	  -Wno-UNUSEDSIGNAL -Wno-WIDTHEXPAND -Wno-UNDRIVEN \
	  --top-module sim_top -Mdir obj_dir \
	  +incdir+. +define+TB_MODULE=$(TB) sim_top.sv $(notdir $(SRCS))); \
	"$$build/obj_dir/Vsim_top" "+trace_file=$(FST_FILE)"

wave: sim
	@echo "Abrir $(FST_FILE) en Surfer/VaporView"

clean:
	rm -rf "$(BUILD_DIR)"
