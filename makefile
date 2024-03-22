LTC="pdflatex"
BTC="bibtex"

ANAME="SelfConsistentModelingOfNGC2808"

SRCDIR="src/"
FIGDIR="src/figures"
BIBDIR="src/bibliography"
APEDIR="src/appendicies"

ApJDIR="ApJ"
ArXivDIR="ArXiv"

MANFILE="ms.tex"
MANPATH="$(SRCDIR)/$(MANFILE)"
ApJMANPATH="$(ApJDIR)/$(MANFILE)"
ArXivMANPATH="$(ArXivDIR)/$(MANFILE)"


ASSET_FILES = $(shell find ./src/ -regex '.*\(tex\|pdf\)$')


TFLAGS="-jobname=$(ANAME)"

.PHONY: manuscript apj arxiv clean veryclean

default: manuscript

all: manuscript apj arxiv

manuscript: ./src/$(ASSET_FILES)
	$(LTC) $(TFLAGS) $(MANPATH)
	$(BTC) $(ANAME)
	$(LTC) $(TFLAGS) $(MANPATH)
	$(LTC) $(TFLAGS) $(MANPATH)


apj:
	pubPolish --target ApJ --dest $(ApJDIR) $(MANPATH) -f
	cd $(ApJDIR) && $(LTC) $(TFLAGS) $(MANFILE)
	cd $(ApJDIR) && $(BTC) $(ANAME)
	cd $(ApJDIR) && $(LTC) $(TFLAGS) $(MANFILE)
	cd $(ApJDIR) && $(LTC) $(TFLAGS) $(MANFILE)
	tar -czvf $(ApJDIR).tar.gz $(ApJDIR)

arxiv:
	pubPolish --target ArXiv --dest $(ArXivDIR) $(MANPATH) -f
	cd $(ArXivDIR) && $(LTC) $(TFLAGS) $(MANFILE)
	cd $(ArXivDIR) && $(BTC) $(ANAME)
	cd $(ArXivDIR) && $(LTC) $(TFLAGS) $(MANFILE)
	cd $(ArXivDIR) && $(LTC) $(TFLAGS) $(MANFILE)
	tar -czvf $(ArXivDIR).tar.gz $(ArXivDIR)


clean:
	-rm $(ANAME).blg
	-rm $(ANAME).bbl
	-rm $(ANAME).aux
	-rm $(ANAME).log
	-rm $(ANAME).out

veryclean: clean
	-rm $(ANAME).pdf
