# LaTeX basic Makefile
#
# WTFPL, 2016 - 2018 Romain Porte (MicroJoe) <microjoe@microjoe.org>
#
# Inspired from
# http://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
# and my basic Makefile skills.

# Very important variables to set up
PDF=CV.pdf
PRINC=CV.tex
PDF_EN=CV_EN.pdf
PRINC_EN=CV_EN.tex

AUXDIR=build
LATEXMK=source ~/.bashrc && latexmk \
        -auxdir=$(AUXDIR) \
        -outdir=$(AUXDIR) \
        -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make

# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: $(PDF) all clean live en live_en

# Main rule: Construct the PDF
all: $(PDF)

en: $(PDF_EN)

# Live: automatic watch and build of the PDF file
live: $(PRINC) $(SOURCES)
	$(LATEXMK) -pvc $(PRINC)

# Construct the PDF file from sources
$(PDF): $(PRINC) $(SOURCES)
	$(LATEXMK) $(PRINC)

live_en: $(PRINC_EN) $(SOURCES)
		$(LATEXMK) -pvc $(PRINC_EN)

$(PDF_EN): $(PRINC_EN) $(SOURCES)
			$(LATEXMK) $(PRINC_EN)
# Remove all the intermediate files
clean:
	@echo Cleaning temporary LaTeX files...
	@rm -rf $(AUXDIR)
