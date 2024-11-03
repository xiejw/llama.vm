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

PWD              = $(shell pwd)

# ------------------------------------------------------------------------------
# Sentencepiece Related
#
SRC_SP           = third_party/sentencepiece
BUILD_SP         = ${BUILD}/build_sentencepiece
INSTALL_SP       = ${BUILD}/install_sentencepiece
SP_LIB           = ${INSTALL_SP}/lib/libsentencepiece.a

CXXFLAGS        += -I${INSTALL_SP}/include
LDFLAGS         += -L${INSTALL_SP}/lib -lsentencepiece

# ------------------------------------------------------------------------------
# Actions
#
.DEFAULT_GOAL    = compile

compile: ${SP_LIB} ${BUILD}/main


test: ${SP_LIB} compile

release:
	make RELEASE=1 compile

${BUILD}/main: cmd/encoder/main.cc
	${CXX} ${CXXFLAGS} -o $@ $< ${LDFLAGS}

# ------------------------------------------------------------------------------
# Sentencepiece
#
${SP_LIB}:
	git submodule update --init                     && \
	mkdir -p ${BUILD_SP}                            && \
	cd ${BUILD_SP}                                  && \
	CXX= CC= CXXFLAGS=                                 \
		cmake                                      \
		-DCMAKE_BUILD_TYPE=Release                 \
		-DSPM_ENABLE_SHARED=OFF                    \
		${PWD}/${SRC_SP}                        && \
	make -j                                         && \
	cmake --install . --prefix ${PWD}/${INSTALL_SP}

