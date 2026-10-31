#!/usr/bin/env bash
# xiaomipad2 (Atom x5-Z8500 / Cherry Trail) kernel build wrapper
#   * LLVM=1         -> enables CONFIG_LTO_CLANG_THIN (silently dropped without it)
#   * -march=slm     -> Airmont ISA (SSE4.2/AES/PCLMUL/MOVBE); CPU has no AVX
#   (no -fno-plt: it makes objtool flag {dynamic} calls in UACCESS regions)
set -euo pipefail
cd "$(dirname "$0")"
: "${O:=out}"
: "${KCFLAGS:=-march=slm -mtune=slm}"
: "${JOBS:=$(nproc)}"
echo "[build] O=$O ARCH=x86 LLVM=1 KCFLAGS=$KCFLAGS -j$JOBS $*"
make O="$O" ARCH=x86 LLVM=1 KCFLAGS="$KCFLAGS" -j"$JOBS" "$@"
