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
        autoconf tree lmod \
    && apt-get clean

RUN useradd -ms /bin/bash spack
USER spack
WORKDIR /home/spack

COPY --chown=spack:spack cscs-script.sh /home/spack/scripts/test_script.sh
COPY --chown=spack:spack spack.yaml /home/spack/hpx-development/deps/spack.yaml
COPY --chown=spack:spack deploy.yaml /home/spack/deployment/spack.yaml

RUN git clone --depth 1 -b courses/smc_cscs_2019 https://github.com/alalazo/spack

RUN git clone --depth 1 https://github.com/STEllAR-GROUP/hpx.git /home/spack/hpx-development/sources

RUN echo 'export PS1="\[\e[0;34m\]cscs-smc-2019\[\e[0m\] \[\e[0;32m\][\w]\[\e[m\] $ "' >> ~/.bashrc
RUN echo '. /home/spack/spack/share/spack/setup-env.sh' >> ~/.bashrc
RUN echo '. /usr/share/lmod/lmod/init/bash' >> ~/.bashrc

ENTRYPOINT ["/bin/bash"]