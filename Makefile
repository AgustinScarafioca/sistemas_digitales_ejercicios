GUIAS_DIR := guias
GUIAS := $(sort $(notdir $(wildcard $(GUIAS_DIR)/guia_*)))
GUIA ?=
EJ ?=

.DEFAULT_GOAL := sim
.PHONY: sim deps wave clean help

sim deps wave clean:
	@if [ -n "$(GUIA)" ]; then \
	  $(MAKE) -C "$(GUIAS_DIR)/$(GUIA)" "$@" EJ="$(EJ)"; \
	else \
	  status=0; \
	  for guia in $(GUIAS); do \
	    $(MAKE) -C "$(GUIAS_DIR)/$$guia" "$@" || status=1; \
	  done; \
	  exit $$status; \
	fi

help:
	@echo 'make sim                         Simulate every exercise in every guide'
	@echo 'make sim GUIA=guia_1            Simulate every exercise in guia_1'
	@echo 'make sim GUIA=guia_1 EJ=ej1     Simulate one exercise'
	@echo 'Targets: sim, deps, wave, clean'
