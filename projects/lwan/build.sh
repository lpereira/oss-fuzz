#!/bin/bash -eu

mkdir -p $WORK/lwan
cd $WORK/lwan

cmake -GNinja \
	-DCMAKE_BUILD_TYPE=Debug -DBUILD_FUZZER=${SANITIZER} \
	-DCMAKE_C_COMPILER="${CC}" -DCMAKE_C_FLAGS="${CFLAGS}" \
	$SRC/lwan/

ninja liblwan.a

for fuzzer in $SRC/lwan/src/bin/fuzz/*_fuzzer.cc; do
	executable=$(basename $fuzzer .cc)
	$CXX $CXXFLAGS -std=c++11 \
		-Wl,-whole-archive $WORK/lwan/src/lib/liblwan.a -Wl,-no-whole-archive \
		-I$SRC/lwan/src/lib $fuzzer \
		-fsanitize=${SANITIZER} \
		-lFuzzingEngine -lpthread -lz \
		-o $OUT/$executable
done
