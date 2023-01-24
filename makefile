LTC="pdflatex"
BTC="bibtex"

ANAME="SelfConsistentModelingOfNGC2808"

SRCDIR="src/"
FIGDIR="src/figures"
BIBDIR="src/bibliography"
APEDIR="src/appendicies"

MANFILE="ms.tex"
MANPATH="$(SRCDIR)/$(MANFILE)"


ASSET_FILES = $(shell find ./src/ -regex '.*\(tex\|pdf\)$')


TFLAGS="-jobname=$(ANAME)"

default: all

all: pdf

pdf: ./src/$(ASSET_FILES)
	$(LTC) $(TFLAGS) $(MANPATH)
	$(BTC) $(ANAME)
	$(LTC) $(TFLAGS) $(MANPATH)
	$(LTC) $(TFLAGS) $(MANPATH)

clean:
	-rm $(ANAME).blg
	-rm $(ANAME).bbl
	-rm $(ANAME).aux
	-rm $(ANAME).log
	-rm $(ANAME).out

veryclean: clean
	-rm $(ANAME).pdf
