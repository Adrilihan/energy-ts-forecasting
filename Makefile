################################################################################
# GLOBALS                                                                      #
################################################################################

PROJECT_NAME = energy-ts-forecasting
R_VERSION = 4.5.1
R_INTERPRETER = rig run -r $(R_VERSION)

################################################################################
# COMMANDS                                                                     #
################################################################################


# Install R dependencies using rlock
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


#################################################################################
# PROJECT RULES                                                                 #
#################################################################################


## Make dataset
.PHONY: data
data: requirements
	$(R_INTERPRETER) -f data/make_dataset.R
	
## Start RStudio session with appropriate R version and project set-up
.PHONY: rstudio
rstudio:
	rig rstudio $(R_VERSION) $(PROJECT_NAME).Rproj
