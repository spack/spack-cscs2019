FROM ubuntu:16.04

# Setup the binary mirror
RUN mkdir /mirror
COPY public.key  /mirror/public.key
RUN chmod -R go+r /mirror

# Add system dependencies 
RUN apt-get -yqq update && apt-get -yqq install ca-certificates \
    && apt-get -yqq update  \
    && apt-get -yqq install patchelf \
        ca-certificates curl g++ \
        gcc-4.7 g++-4.7 gfortran-4.7 \
        gcc gfortran git gnupg2 \
        iproute2 make \
        openssh-server python python-pip tcl \
        emacs unzip \
        autoconf \
    && apt-get clean

# Copy in scripts to test container
# COPY tutorial-test.sh /tutorial/.test/tutorial-test.sh
# RUN chmod -R go+rx /tutorial/.test/tutorial-test.sh

RUN useradd -ms /bin/bash spack
USER spack
WORKDIR /home/spack
RUN git clone --depth 1 https://github.com/spack/spack
RUN echo 'export PS1="\[\e[0;34m\]cscs-smc-2019\[\e[0m\] \[\e[0;32m\][\w]\[\e[m\] $ "' >> ~/.bashrc
RUN echo '. /home/spack/spack/share/spack/setup-env.sh' >> ~/.bashrc

ENTRYPOINT ["/bin/bash"]