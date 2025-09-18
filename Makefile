################################################################################
# GLOBALS                                                                      #
################################################################################

PROJECT_NAME = energy-ts-forecasting
R_VERSION = 4.5.1
R_INTERPRETER = rig run -r $(R_VERSION)

################################################################################
# COMMANDS                                                                     #
################################################################################


## Install R dependencies using rlock
.PHONY: requirements
requirements:
	$(R_INTERPRETER) -e "renv::restore(clean = TRUE)"


## Set up R interpreter environment with rig and rlock
.PHONY: create_environment
create_environment:
	rig list | grep -Fq "$(R_VERSION)" || rig add $(R_VERSION)
	$(R_INTERPRETER) -e 'renv::restore()'
	
	@echo ">>> R env created. Activate with:"
	@echo "rig rstudio $(R_VERSION) $(PROJECT_NAME).Rproj"


################################################################################
# PROJECT RULES                                                                #
################################################################################


## Make dataset
.PHONY: data
data: requirements
	$(R_INTERPRETER) -f data/make_dataset.R
	
## Start RStudio session with appropriate R version and project set-up
.PHONY: rstudio
rstudio:
	rig rstudio $(R_VERSION) $(PROJECT_NAME).Rproj


################################################################################
# Self Documenting Commands                                                    #
################################################################################

.DEFAULT_GOAL := help

define PRINT_HELP_RSCRIPT
library(stringr); \
file_text <- readLines("Makefile"); \
file_text <- paste(file_text, collapse = "\n"); \
pattern <- "\n## (.*)\n[\\s\\S]+?\n([a-zA-Z_-]+):"; \
matches <- str_match_all(file_text, pattern)[[1]]; \
results <- paste(sprintf("%-25s %s", matches[,3], matches[,2]), collapse = "\n"); \
cat("Available rules:", results, sep = "\n")
endef
export PRINT_HELP_RSCRIPT

help:
	@$(R_INTERPRETER) -e '${PRINT_HELP_RSCRIPT}'
