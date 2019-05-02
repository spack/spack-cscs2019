#/bin/bash -e

##
# BASIC USAGE
##

spack list
spack list zlib
spack list -t ecp

spack compiler list
spack compiler info gcc

# Setup a mirror
spack mirror add cscs-course /mirror
spack gpg trust public.key

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
objdump

# Uninstall packages
spack uninstall zlib@1.2.8
spack uninstall cflags="-O3"
spack uninstall -y zlib%gcc@4.7

# Advanced spack find options
spack find ^boost@1.68.0
spack find -p hpx

# How to add a spack copmiled compiler
spack install gcc@8.3.0
spack compiler add $(spack location -i gcc@8.3.0)


##
# PACKAGING SOFTWARE
##


