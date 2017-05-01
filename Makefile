
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
	sed "s/^/' VERSION: rodash /g" ./VERSION > ./dist/rodash.cat.brs
	sed "s/^/' LICENSE: /g" ./LICENSE >> ./dist/rodash.cat.brs
	cd src && ls | xargs -J % sed -E -e ${COMMENT_LINES_RE} -e ${BLANK_LINES_RE} -e ${LEADING_WHITESPACE_RE} % >> ../dist/rodash.cat.brs

doc:
	cd jsdoc && npm install
	./jsdoc/node_modules/.bin/jsdoc -c jsdoc/jsdoc.json -t jsdoc/node_modules/ink-docstrap/template -d docs
