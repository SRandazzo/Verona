green=\033[0;32m
NC=\033[0m # No Color

bootstrap:

	@echo "\n${green} 📲  Bootstrapping Verona!\n${NC}"

	bundle install
	make pod

	@echo "\n${green} 📲  Opening Verona.xcworkspace, have fun!\n${NC}"
	open Verona.xcworkspace

pod:
	bundle exec pod install
	
