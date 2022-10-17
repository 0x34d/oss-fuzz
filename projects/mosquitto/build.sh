#!/bin/bash -eu
# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################
export CXXFLAGS="$CFLAGS"
export LDFLAGS="$CFLAGS"
make WITH_STATIC_LIBRARIES=yes -j$(nproc)

mkdir fuzzing/
cp FuzzPropRecv.c fuzzing/FuzzPropRecv.c
cp FuzzReqRes.c fuzzing/FuzzReqRes.c
cp Makefile.fuzz fuzzing/Makefile

cd fuzzing/
make
cp FuzzPropRecv $OUT/FuzzPropRecv
cp FuzzReqRes $OUT/FuzzReqRes

pushd $SRC/oss-fuzz-bloat/mosquitto/
cp FuzzPropRecv_seed_corpus.zip $OUT/FuzzPropRecv_seed_corpus.zip
cp FuzzReqRes_seed_corpus.zip $OUT/FuzzReqRes_seed_corpus.zip
popd
