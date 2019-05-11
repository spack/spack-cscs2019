#!/bin/bash -e

##
# BASIC USAGE
##

spack list
spack list zlib
spack list -t ecp

spack compiler list
spack compiler info gcc

# Setup a mirror
spack mirror list
spack mirror add smc-2019 /mirror
spack mirror list
spack gpg trust /mirror/public.key

# Basic installation and query
spack install zlib
spack install zlib@1.2.8
spack install -v --no-cache zlib %gcc@4.7
spack install zlib cflags="-O3"

spack find
spack find -lf

# More complicated packages
spack info hpx
spack spec hpx build_type=Release cxxstd=14 instrumentation=valgrind ^boost@1.68.0
spack install hpx build_type=Release cxxstd=14 instrumentation=valgrind ^boost@1.68.0

# Check that RPATHs are set properly
objdump -x $(spack location -i hpx)/lib/libhpx.so | grep RPATH

# Uninstall packages
spack uninstall -y zlib@1.2.8
spack uninstall -y cflags="-O3"
spack uninstall -y zlib%gcc@4.7

# Advanced spack find options
spack find ^boost@1.68.0
spack find -p hpx

# How to add a spack compiled compiler
spack install gcc@8.3.0
spack compiler add $(spack location -i gcc@8.3.0)
spack compiler info gcc

# How to check

##
# PACKAGING SOFTWARE
##

# Show and comment the HPX package
# spack edit hpx

# Show CMakePackage
# spack edit -b cmake

# Show how to stop at configure and enter a shell
spack configure gsl
spack cd gsl
spack build-env gsl
cd -

##
# THE DEVELOPMENT ENVIRONMENT
##

# Install the dependencies
export PATH=$(spack location -i gcc)/bin:$PATH

cd /home/spack/hpx-development/deps
spack concretize
spack install

spack env activate /home/spack/hpx-development/deps
mkdir /home/spack/hpx-development/build
cd /home/spack/hpx-development/build
cmake -DCMAKE_INSTALL_PREFIX=/home/spack/hpx-developent/install -DHPX_WITH_CXX14=ON -DHPX_WITH_VALGRIND=ON -DBOOST_ROOT=/home/spack/hpx-development/deps/.spack-env/view -DHWLOC_ROOT=/home/spack/hpx-development/deps/.spack-env/view -DHPX_WITH_MALLOC=system -DVALGRIND_ROOT=/home/spack/hpx-development/deps/.spack-env/view -DHPX_WITH_EXAMPLES=OFF ../sources
make && make install

##
# Deploy stable versions
##
cd /home/spack/deployment/
cat spack.yaml
spack concretize
spack install
