
.PHONY: test dist doc

# Run the tests
test: dist
	@rm -rf build/*
	cp -r test/* build
	cp dist/rodash.cat.brs build/source
	cd build; ${MAKE} install

# Smash the library down to one file
BLANK_LINES_RE="/^[ \t]*'.*/d"
COMMENT_LINES_RE="/^[ ]*$$/d"
LEADING_WHITESPACE_RE="s/^[ \t]*//"
dist:
	cd src && ls | xargs -J % sed -E -e ${COMMENT_LINES_RE} -e ${BLANK_LINES_RE} -e ${LEADING_WHITESPACE_RE} % > ../dist/rodash.cat.brs

doc:
	jsdoc -c doc/jsdoc.json -t doc/node_modules/ink-docstrap/template -d dist/doc
