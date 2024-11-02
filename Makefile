# ------------------------------------------------------------------------------
# Eve Template
#
CMD              =  cmd
SRC              =  lib
INC              =  include

EVE_FMT_FOLDERS  = ${CMD} ${SRC} ${INC}
EVE_PATH         = ../y/ann/eve
include ${EVE_PATH}/eve.mk


# ------------------------------------------------------------------------------
# Bootstrap
#

# ------------------------------------------------------------------------------
# Sentencepiece Related
#
SRC_SP             = third_party/sentencepiece
BUILD_SP           = ${BUILD}/build_sentencepiece
INSTALL_SP         = ${BUILD}/install_sentencepiece
SP_LIB             = ${INSTALL_SP}/lib/libsentencepiece.a

compile: ${SP_LIB}


run:
	cargo run

test:
	cargo clippy -- -D warnings && cargo build

release:
	cargo run --release

# ------------------------------------------------------------------------------
# Sentencepiece
#
${SP_LIB}:
	git submodule update --init                     && \
	mkdir -p ${BUILD_SP}                            && \
	PWD=`pwd`                                       && \
	cd ${BUILD_SP}                                  && \
	CXX= CC= CXXFLAGS= cmake ${PWD}/${SRC_SP}       && \
	make -j                                         && \
	cmake --install . --prefix ${PWD}/${INSTALL_SP}

