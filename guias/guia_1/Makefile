EJERCICIOS_DIR := ejercicios
EJERCICIOS := $(sort $(notdir $(wildcard $(EJERCICIOS_DIR)/ej[0-9]*)))
EJ ?=

.DEFAULT_GOAL := sim
.PHONY: sim deps wave clean

sim deps wave clean:
	@if [ -n "$(EJ)" ]; then \
	  $(MAKE) -C "$(EJERCICIOS_DIR)/$(EJ)" "$@"; \
	else \
	  status=0; \
	  for ejercicio in $(EJERCICIOS); do \
	    if [ -f "$(EJERCICIOS_DIR)/$$ejercicio/Makefile" ]; then \
	      $(MAKE) -C "$(EJERCICIOS_DIR)/$$ejercicio" "$@" || status=1; \
	    fi; \
	  done; \
	  exit $$status; \
	fi
