EMACS = /usr/local/bin/xemacs
RM = rm -f

SOURCES = latex-doc-var.el latex-doc.el
FLAGS = -batch -l docomp.el -f batch-byte-compile
DATA_SOURCES = latex-doc-build.el latex-doc-data.el
DATA = .latex-doc
INDEX = .latex-doc-index.el
INDEX_ELC = .latex-doc-index.elc

all:	clean-data src data

src:
	$(EMACS) $(FLAGS) $(SOURCES)

data:
	touch $(DATA)
	echo ";; Generated automatically.  Don't edit!!!" > $(INDEX)
	$(EMACS) $(FLAGS) $(DATA_SOURCES)
	$(EMACS) $(FLAGS) $(INDEX)

clean-data:
	$(RM) $(DATA) $(INDEX) $(INDEX_ELC)

clean:	clean_data
	$(RM) *.elc *~

distclean:	clean
