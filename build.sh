#Shifty build script.  Cobbled together with help from: http://blog.badsyntax.co/post/1465134196/minifying-javascript-using-google-closure-compiler-and

# All the files to build...
cat src/shifty.core.js \
	src/shifty.formulas.js \
	src/shifty.interpolate.js \
	src/shifty.clamp.js \
	> mifty.js


in=mifty.js
out=builds/mifty.minsrc.js

curl -s \
	-d compilation_level=SIMPLE_OPTIMIZATIONS \
	-d output_format=text \
	-d output_info=compiled_code \
	--data-urlencode "js_code@${in}" \
	http://closure-compiler.appspot.com/compile \
	 > $out

cat src/build_header.js builds/mifty.minsrc.js > builds/mifty.min.js

rm builds/mifty.minsrc.js