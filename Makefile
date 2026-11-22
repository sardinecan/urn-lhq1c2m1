.PHONY: build clean help tei2slide xsltforms

SAXON := java -jar ~/programs/saxon12/saxon-he-12.10.jar
SRC_XPATH_DIR := src/xpath/src
SRC_XSLT_DIR := src/xslt/src
TEMP_DIR := temp
OUTPUT_DIR := public
ASSETS_DIR := assets
XSLTFORMS_DIR := assets/xsltforms

SOURCE_XPATH_XML := $(SRC_XPATH_DIR)/xpath.xml
SOURCE_XSLT_XML := $(SRC_XSLT_DIR)/xslt.xml
TEI2SLIDE_XSL := $(SRC_XPATH_DIR)/tei2slide.xsl
XSLTFORMS_XSL := $(XSLTFORMS_DIR)/xsltforms.xsl

help:
	@echo "Usage:"
	@echo "  make <target>"
	@echo "Makefile targets:"
	@echo "  tei2slide		- Apply tei2slide stylesheet to source file"
	@echo "  xsltforms		- Apply xsltforms stylesheet to xhtml files produced with tei2slide"
	@echo "  clean			- Remove the temporary directory"
	@echo "  build			- tei2slide + xsltforms + clean + copy assets to public"

tei2slide:
	@echo "tei2slide: Transform $(SOURCE_XPATH_XML) with $(TEI2SLIDE_XSL)..."
	@mkdir -p $(TEMP_DIR)
	$(SAXON) -xsl:$(TEI2SLIDE_XSL) -s:$(SOURCE_XPATH_XML) outputDir=$(TEMP_DIR)/xpath

	@echo "tei2slide: Transform $(SOURCE_XSLT_XML) with $(TEI2SLIDE_XSL)..."
	$(SAXON) -xsl:$(TEI2SLIDE_XSL) -s:$(SOURCE_XSLT_XML) outputDir=$(TEMP_DIR)/xslt
	@echo "tei2slide done!"

xsltforms: 
	@echo "xsltforms: Transform .xhtml files into .html"
	@mkdir -p $(OUTPUT_DIR)/xpath $(OUTPUT_DIR)/xslt
	@set -e; found=0; \
	for subdir in xpath xslt; do \
		for xhtml_file in $(TEMP_DIR)/$$subdir/*.xhtml; do \
			[ -f "$$xhtml_file" ] || continue; \
			found=1; \
			html_file="$${xhtml_file##*/}"; \
			html_file="$(OUTPUT_DIR)/$$subdir/$${html_file%.xhtml}.html"; \
			echo "  Transforming: $$xhtml_file → $$html_file"; \
			$(SAXON) -xsl:$(XSLTFORMS_XSL) -s:"$$xhtml_file" -o:"$$html_file"; \
		done; \
	done; \
	if [ "$$found" -eq 0 ]; then \
		echo "No XHTML files found in $(TEMP_DIR)/xpath or $(TEMP_DIR)/xslt; run make tei2slide first." >&2; \
		exit 1; \
	fi
	@echo "xsltforms done!"

build: tei2slide xsltforms clean
	@mkdir -p $(OUTPUT_DIR)/assets
	cp -R $(ASSETS_DIR)/. $(OUTPUT_DIR)/assets/
	@echo "Build done!"

clean:
	@echo "Removing temp"
	@rm -rf temp
	@echo "clean done!"
