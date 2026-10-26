EJERCICIOS := $(sort $(notdir $(wildcard ej[0-9]*)))
.DEFAULT_GOAL := sim
.PHONY: sim deps wave clean

sim deps wave clean:
	@status=0; \
	for ejercicio in $(EJERCICIOS); do \
	  if [ -f "$$ejercicio/Makefile" ]; then \
	    $(MAKE) -C "$$ejercicio" "$@" || status=1; \
	  fi; \
	done; \
	exit $$status
