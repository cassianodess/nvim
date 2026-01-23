.PHONY: setup-java

JAVA_BASE_DIR := $(HOME)/.local/share/java
JDTLS_DIR := $(JAVA_BASE_DIR)/jdtls
JDTLS_WORKSPACE_DIR := $(JDTLS_DIR)/workspace
JAVA_DEBUG_DIR := $(JAVA_BASE_DIR)/java-debug
LOMBOK_DIR := $(JAVA_BASE_DIR)/lombok

setup-java:
	mkdir -p $(JDTLS_DIR)
	mkdir -p $(JDTLS_WORKSPACE_DIR)
	mkdir -p $(JAVA_DEBUG_DIR)
	mkdir -p $(LOMBOK_DIR)