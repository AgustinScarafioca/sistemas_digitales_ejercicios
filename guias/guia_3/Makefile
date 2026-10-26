EJ ?=
.DEFAULT_GOAL := sim
.PHONY: sim deps wave clean

sim deps wave clean:
	@if [ -n "$(EJ)" ]; then \
	  $(MAKE) -C "ejercicios/$(EJ)" "$@"; \
	else \
	  $(MAKE) -C ejercicios "$@"; \
	fi
