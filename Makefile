SHELL := /bin/bash

.DEFAULT_GOAL := help

.PHONY: help

help:
	@echo "Usage:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

kali: ## Build the Kali box
	vagrant up kali --provision
	
sandbox: ## Build the whole sandbox 
	vagrant up kali --provision
	vagrant up juiceshop
	vagrant up dvwa
	vagrant up metasploitable
	vagrant up samuraiwtf
	vagrant up webgoat
	vagrant up securityonion

redlearning: ## Build the learning sandbox
	vagrant up juiceshop
	vagrant up dvwa
	vagrant up metasploitable
	vagrant up webgoat

redskills: ## Build the skill testing sandbox
	vagrant up samuraiwtf

blueteam: ## Build the Blueteam sandbox
	vagrant up securityonion

teardown: ## Tear down the sandbox
	vagrant halt kali
	vagrant halt juiceshop
	vagrant halt dvwa
	vagrant halt metasploitable
	vagrant halt samuraiwtf
	vagrant halt webgoat
	vagrant halt securityonion

destroy: ## Destroy the sandbox
	vagrant destroy

rebuild: ## Wipes and redeploys the sandbox
	vagrant halt $(SANDBOX)
	vagrant destroy $(SANDBOX) -f
	vagrant up $(SANDBOX)
