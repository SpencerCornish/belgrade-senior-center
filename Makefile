.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Runs pub get to get dependencies
	@pub get

serve: install gen-sass dart-serve ## Serves the frontend app with ddevc

firebase-serve: install gen-sass build ## Serves built JS files locally
	@firebase serve --only hosting

sass: install gen-sass ## Compile the Sass files to css

format: ## Format the dart files
	@dartfmt -w -l 120 lib/

gen-sass:
	@echo "Running sass generation script"
	@sh ./tool/sass_task.sh
	@echo "Done running sass generation script"


dart-serve:
	@webdev serve


build-js:  ## build to JS
	@webdev build
