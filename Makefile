CPU := "$(shell sysctl -n machdep.cpu.brand_string 2>/dev/null)"

all: ## Build for Linux or Intel based Macs
ifeq ($(CPU), "Apple M1")
	@printf "\e[0;33mYou have an M1 silicon based Mac. Run \e[0;36mmake m1\e[0;33m instead\e[0m\n" && exit 1
endif
	docker build -t epitech-fedora .
	@printf "\e[0;32mGood to go, now go code, time is money.\e[0m\n"

m1: ## Build for M1 silicon based Macs
	@printf "Warning: This can take a while, might be a good time to grab a coffee."
	docker buildx build --platform=linux/amd64 --load -t epitech-fedora .
	@printf "\e[0;32mGood to go, now go code, time is money.\e[0m\n"

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'